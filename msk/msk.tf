resource "aws_msk_cluster" "main" {
  cluster_name = var.name.msk
  kafka_version = var.kafka_version
  number_of_broker_nodes = var.broker_count

  broker_node_group_info {
    instance_type = var.broker_size
    client_subnets = var.subnet_ids

    storage_info {
      ebs_storage_info {
        volume_size = var.volume_size
      }
    }

    security_groups = [aws_security_group.msk_security_group.id]
  }
}
