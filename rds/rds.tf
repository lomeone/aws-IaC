resource "aws_rds_cluster" "msa-1" {
  cluster_identifier              = var.name.db_cluster
  engine                          = "aurora-mysql"
  engine_version                  = "3.05.2"
  database_name                   = var.name.db
  manage_master_user_password     = true
  master_username                 = var.admin_username
  db_subnet_group_name            = "aws_db_subnet_group.default.name" // 가져올 방법 확인
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.use_outbox.name
  vpc_security_group_ids          = [aws_security_group.rds_mysql.id]
}

resource "aws_rds_cluster_instance" "writer" {
  count                = 1
  identifier           = "${var.name.db_cluster}-instance-writer"
  cluster_identifier   = aws_rds_cluster.msa-1.id
  instance_class       = "db.t4g.medium"
  engine               = aws_rds_cluster.msa-1.engine
  engine_version       = aws_rds_cluster.msa-1.engine_version
  db_subnet_group_name = "db_subnet_group"
  apply_immediately    = true
}

resource "aws_rds_cluster_instance" "reader" {
  count                = 3
  identifier           = "${var.name.db_cluster}-instance-reader-${count.index}"
  cluster_identifier   = aws_rds_cluster.msa-1.id
  instance_class       = "db.t4g.medium"
  engine               = aws_rds_cluster.msa-1.engine
  engine_version       = aws_rds_cluster.msa-1.engine_version
  db_subnet_group_name = "db_subnet_group"
  apply_immediately    = true

  availability_zone = element(["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"], count.index)
}
