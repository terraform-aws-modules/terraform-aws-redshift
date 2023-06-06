provider "aws" {
  region = local.region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  s3_prefix = "redshift/${local.name}/"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-redshift"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# Complete
################################################################################

module "redshift" {
  source = "../../"

  cluster_identifier    = local.name
  allow_version_upgrade = true
  node_type             = "ra3.xlplus"
  number_of_nodes       = 3

  database_name          = "mydb"
  master_username        = "mydbuser"
  create_random_password = false
  master_password        = "MySecretPassw0rd1!" # Do better!

  encrypted   = true
  kms_key_arn = aws_kms_key.redshift.arn

  enhanced_vpc_routing   = true
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids             = module.vpc.redshift_subnets

  # Only available when using the ra3.x type
  availability_zone_relocation_enabled = true

  snapshot_copy = {
    destination_region = "us-east-1"
    grant_name         = aws_redshift_snapshot_copy_grant.useast1.snapshot_copy_grant_name
  }

  logging = {
    enable        = true
    bucket_name   = module.s3_logs.s3_bucket_id
    s3_key_prefix = local.s3_prefix
  }

  # Parameter group
  parameter_group_name        = "${local.name}-custom"
  parameter_group_description = "Custom parameter group for ${local.name} cluster"
  parameter_group_parameters = {
    wlm_json_configuration = {
      name = "wlm_json_configuration"
      value = jsonencode([
        {
          query_concurrency = 15
        }
      ])
    }
    require_ssl = {
      name  = "require_ssl"
      value = true
    }
    use_fips_ssl = {
      name  = "use_fips_ssl"
      value = false
    }
    enable_user_activity_logging = {
      name  = "enable_user_activity_logging"
      value = true
    }
    max_concurrency_scaling_clusters = {
      name  = "max_concurrency_scaling_clusters"
      value = 3
    }
    enable_case_sensitive_identifier = {
      name  = "enable_case_sensitive_identifier"
      value = true
    }
  }
  parameter_group_tags = {
    Additional = "CustomParameterGroup"
  }

  # Subnet group
  subnet_group_name        = "${local.name}-custom"
  subnet_group_description = "Custom subnet group for ${local.name} cluster"
  subnet_group_tags = {
    Additional = "CustomSubnetGroup"
  }

  # Snapshot schedule
  create_snapshot_schedule        = true
  snapshot_schedule_identifier    = local.name
  use_snapshot_identifier_prefix  = true
  snapshot_schedule_description   = "Example snapshot schedule"
  snapshot_schedule_definitions   = ["rate(12 hours)"]
  snapshot_schedule_force_destroy = true

  # Scheduled actions
  create_scheduled_action_iam_role = true
  scheduled_actions = {
    pause = {
      name          = "${local.name}-pause"
      description   = "Pause cluster every night"
      schedule      = "cron(0 22 * * ? *)"
      pause_cluster = true
    }
    resize = {
      name        = "${local.name}-resize"
      description = "Resize cluster (demo only)"
      schedule    = "cron(00 13 * * ? *)"
      resize_cluster = {
        node_type       = "ds2.xlarge"
        number_of_nodes = 5
      }
    }
    resume = {
      name           = "${local.name}-resume"
      description    = "Resume cluster every morning"
      schedule       = "cron(0 12 * * ? *)"
      resume_cluster = true
    }
  }

  # Endpoint access - only available when using the ra3.x type
  create_endpoint_access          = true
  endpoint_name                   = "${local.name}-example"
  endpoint_subnet_group_name      = aws_redshift_subnet_group.endpoint.id
  endpoint_vpc_security_group_ids = [module.security_group.security_group_id]

  # Usage limits
  usage_limits = {
    currency_scaling = {
      feature_type  = "concurrency-scaling"
      limit_type    = "time"
      amount        = 60
      breach_action = "emit-metric"
    }
    spectrum = {
      feature_type  = "spectrum"
      limit_type    = "data-scanned"
      amount        = 2
      breach_action = "disable"
      tags = {
        Additional = "CustomUsageLimits"
      }
    }
  }

  # Authentication profile
  authentication_profiles = {
    example = {
      name = "example"
      content = {
        AllowDBUserOverride = "1"
        Client_ID           = "ExampleClientID"
        App_ID              = "example"
      }
    }
    bar = {
      content = {
        AllowDBUserOverride = "1"
        Client_ID           = "ExampleClientID"
        App_ID              = "bar"
      }
    }
  }

  tags = local.tags
}

resource "aws_redshift_snapshot_copy_grant" "useast1" {
  # Grants are declared outside of module because they are generally performed
  # in the destination region and we do not embed multiple providers in the root module
  provider = aws.us_east_1

  snapshot_copy_grant_name = "${local.name}-us-east-1"
  kms_key_id               = aws_kms_key.redshift_us_east_1.arn

  tags = local.tags
}

################################################################################
# Default
################################################################################

module "default" {
  source = "../../"

  cluster_identifier = "${local.name}-default"
  node_type          = "dc2.large"

  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids             = module.vpc.redshift_subnets

  tags = local.tags
}

################################################################################
# Disabled
################################################################################

module "disabled" {
  source = "../../"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  redshift_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  # Use subnet group created by module
  create_redshift_subnet_group = false

  tags = local.tags
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/redshift"
  version = "~> 5.0"

  name        = local.name
  description = "Redshift security group"
  vpc_id      = module.vpc.vpc_id

  # Allow ingress rules to be accessed only within current VPC
  ingress_rules       = ["redshift-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]

  # Allow all rules for all protocols
  egress_rules = ["all-all"]

  tags = local.tags
}

resource "aws_kms_key" "redshift" {
  description             = "Customer managed key for encrypting Redshift cluster"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}

resource "aws_kms_key" "redshift_us_east_1" {
  provider = aws.us_east_1

  description             = "Customer managed key for encrypting Redshift snapshot cross-region"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}

data "aws_iam_policy_document" "s3_redshift" {
  statement {
    sid       = "RedshiftAcl"
    actions   = ["s3:GetBucketAcl"]
    resources = [module.s3_logs.s3_bucket_arn]

    principals {
      type        = "Service"
      identifiers = ["redshift.amazonaws.com"]
    }
  }

  statement {
    sid       = "RedshiftWrite"
    actions   = ["s3:PutObject"]
    resources = ["${module.s3_logs.s3_bucket_arn}/${local.s3_prefix}*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }

    principals {
      type        = "Service"
      identifiers = ["redshift.amazonaws.com"]
    }
  }
}

module "s3_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket_prefix = local.name
  acl           = "log-delivery-write"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_redshift.json

  attach_deny_insecure_transport_policy = true
  force_destroy                         = true

  tags = local.tags
}

resource "aws_redshift_subnet_group" "endpoint" {
  name       = "${local.name}-endpoint"
  subnet_ids = module.vpc.private_subnets

  tags = local.tags
}
