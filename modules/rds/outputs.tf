output "rds-id" {
  value = "${aws_db_instance.rds.*.id}"
}