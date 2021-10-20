###############################################################################
# DocumentDB Security Group Output
###############################################################################
output "security_group_id" {
  description = "The ID of the DocumentDB security group"
  value = module.documentdb_sg.security_group_id
}

###############################################################################
# DocumentDB Output
###############################################################################
output "documentdb_arn" {
  value = module.documentdb.arn
  description = "Amazon Resource Name (ARN) of the DocumentDB cluster."
}

output "documentdb_cluster_members" {
  value = module.documentdb.cluster_members
  description = "List of DocDB Instances that are a part of this cluster."
}

output "documentdb_cluster_resource_id" {
  value = module.documentdb.cluster_resource_id
  description = "The DocDB Cluster Resource ID."
}

output "documentdb_endpoint" {
  value = module.documentdb.endpoint
  description = "The DNS address of the DocDB instance."
}

output "documentdb_hosted_zone_id" {
  value = module.documentdb.hosted_zone_id
  description = "The Route53 Hosted Zone ID of the endpoint."
}

output "documentdb_id" {
  value = module.documentdb.id
  description = "The DocDB Cluster Identifier."
}

output "documentdb_reader_endpoint" {
  value = module.documentdb.reader_endpoint
  description = "A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas."
}
