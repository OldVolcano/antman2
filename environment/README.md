## Summary

Terraform code to create your DocumentDB Global Database.

# Inputs
## Inputs for environment

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_account_id | Account ID where resources are to be created. | string | n/a | yes |
| region | Region where resources will be created. | string | `us-east-1` | yes |

# Outputs
## Outputs for DocumentDB

| Name | Description |
|------|-------------|
| security\_group\_id | The ID of the DocumentDB Security Group. |
| documentdb_arn | Amazon Resource Name (ARN) of the DocumentDB cluster. |
| documentdb_cluster_members | List of DocDB Instances that are a part of this cluster. |
| documentdb_cluster_resource_id | The DocDB Cluster Resource ID. |
| documentdb_endpoint | The DNS address of the DocDB instance. |
| documentdb_hosted_zone_id | The Route53 Hosted Zone ID of the endpoint. |
| documentdb_id | The DocDB Cluster Identifier. |
| documentdb_reader_endpoint | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas. |
