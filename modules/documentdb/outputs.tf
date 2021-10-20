output "arn" {
  value = aws_docdb_cluster.docdb.arn
  description = "Amazon Resource Name (ARN) of the DocumentDB cluster."
}

output "cluster_members" {
  value = aws_docdb_cluster.docdb.cluster_members
  description = "List of DocDB Instances that are a part of this cluster."
}

output "cluster_resource_id" {
  value = aws_docdb_cluster.docdb.cluster_resource_id
  description = "The DocDB Cluster Resource ID."
}

output "endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
  description = "The DNS address of the DocDB instance."
}

output "hosted_zone_id" {
  value = aws_docdb_cluster.docdb.hosted_zone_id
  description = "The Route53 Hosted Zone ID of the endpoint."
}

output "id" {
  value = aws_docdb_cluster.docdb.id
  description = "The DocDB Cluster Identifier."
}

output "reader_endpoint" {
  value = aws_docdb_cluster.docdb.reader_endpoint
  description = "A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas."
}
