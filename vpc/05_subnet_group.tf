resource "aws_db_subnet_group" "default" {
  name       = "db_subnet_group"
  subnet_ids = aws_subnet.db_private[*].id
}
