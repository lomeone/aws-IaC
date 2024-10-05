resource "aws_msk_cluster" "main" {
  cluster_name           = var.name.msk
  kafka_version          = var.kafka.version
  number_of_broker_nodes = var.kafka.broker_count

  client_authentication {
    sasl {
      iam = true
    }
  }

  broker_node_group_info {
    instance_type  = var.kafka.broker_instance
    client_subnets = var.vpc.subnet_ids

    storage_info {
      ebs_storage_info {
        volume_size = var.kafka.volume_size
      }
    }

    security_groups = var.vpc.security_groups
  }
}
