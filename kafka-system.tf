module "msk" {
  source = "./modules/msk"

  name = "hansu-msk"

  vpc = {
    security_groups = [module.security_group.sg_id.msk]
    subnet_ids      = module.vpc.subnet_ids.private_subnets
  }

  kafka = {
    version         = "3.6.0"
    broker_count    = 3
    broker_instance = "kafka.t3.small"
    volume_size     = 1
  }
}

// for kafka connect & redpanda
resource "aws_s3_bucket" "kafka_system" {
  bucket = "kafka-system-bucket"
}

resource "aws_s3_bucket_versioning" "kafka_system" {
  bucket = aws_s3_bucket.kafka_system.id

  versioning_configuration {
    status = "Enabled"
  }
}

module "kafka_system_s3_gateway" {
  source = "./modules/s3-file-gateway/gateway"

  name = "kafka-system"

  vpc = {
    id                               = module.vpc.vpc_id
    subnet_ids                       = module.vpc.subnet_ids.private_subnets
    gateway_instance_subnet          = module.vpc.subnet_ids.public_subnets[0]
    gateway_instance_security_groups = [module.security_group.sg_id.s3_storage_gateway]
    s3_endpoint_route_table_ids      = concat(module.vpc.route_table_ids.public, module.vpc.route_table_ids.private)
  }
}

module "file_share_kafka_connector_plugin" {
  source = "./modules/s3-file-gateway/nfs-file-share"

  name = "hansu-kakfa-connector-plugin"

  storage_gateway_arn = module.kafka_system_s3_gateway.storage_gateway.gateway_arn

  s3 = {
    arn      = aws_s3_bucket.kafka_system.arn
    location = "plugin/"
  }
}

module "file_share_msk_auth" {
  source = "./modules/s3-file-gateway/nfs-file-share"

  name = "hansu-msk-auth"

  storage_gateway_arn = module.kafka_system_s3_gateway.storage_gateway.gateway_arn

  s3 = {
    arn      = aws_s3_bucket.kafka_system.arn
    location = "msk-auth/"
  }
}

module "file_share_redpanda" {
  source = "./modules/s3-file-gateway/nfs-file-share"

  name = "hansu-redpanda"

  storage_gateway_arn = module.kafka_system_s3_gateway.storage_gateway.gateway_arn

  s3 = {
    arn      = aws_s3_bucket.kafka_system.arn
    location = "redpanda/"
  }
}
