resource "aws_rds_cluster_parameter_group" "use_outbox" {
  name        = "rds-outbox-parameter"
  family      = "aurora-mysql8.0"
  description = "if use outbox pattern you need this parameter group"

  parameter {
    name  = "binlog_format"
    value = "ROW"
  }

  parameter {
    name  = "binlog_row_image"
    value = "full"
  }

  parameter {
    name  = "binlog_rows_query_log_events"
    value = 1
  }
}
