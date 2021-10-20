output "security_group_id" {
  description = "The ID of the DocumentDB security group"
  value = (aws_security_group.documentdb_security_group.*.id)[0]
}
