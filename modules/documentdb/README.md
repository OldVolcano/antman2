## Terraform AWS DocumentDB Cluster

This terraform module creates a documentDB cluster.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply\_immediately | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. | bool | `"false"` | no |
| backup\_retention\_period | The days to retain backups for. | number | `"7"` | no |
| cluster\_instance\_class | The instance class to use | string | `"db.r5.large"` | no |
| cluster\_instance\_count | Number of instances to spin up per availability_zone. | number | `"1"` | no |
| cluster\_security\_group | List of VPC security groups to associate with the Cluster. | list(string) | n/a | no |
| family | The family of the documentDB cluster parameter group. | string | `docdb4.0` | no |
| engine | The name of the database engine to be used for this DB cluster. | string | `docdb` | no |
| engine\_verion | The database engine version. Updating this argument results in an outage. | string | `4.0.0` | no |
| group\_subnet | A list of VPC subnet IDs. | list(string) | `[]` | no |
| master\_password | Password for the master DB user. | string | n/a | yes |
| master\_username | Username for the master DB user. | string | n/a | yes |
| name | Unique DocumentDB cluster identifier. | string | n/a | yes |
| parameters | additional parameters modified in parameter group | list(map(any)) | `[]` | no |
| preferred\_backup\_window | The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. | string | `"07:00-09:00"` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB cluster is deleted. | bool | `"false"` | no |
| create_global | Boolean if to create Global database or not. | bool | `true` | no |
| global\_identifier | The cluster identifier of the new global cluster. | string | n/a | yes |
| global\_region | List of regions where replication will be spun up. | list(string) | n/a | yes |
| aws_account_id | Account ID where resources are to be created. | string | n/a | yes |
| region | Region where resources will be created. | string | `us-east-1` | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of the DocumentDB cluster. |
| cluster_members | List of DocDB Instances that are a part of this cluster. |
| cluster_resource_id | The DocDB Cluster Resource ID. |
| endpoint | The DNS address of the DocDB instance. |
| hosted_zone_id | The Route53 Hosted Zone ID of the endpoint. |
| id | The DocDB Cluster Identifier. |
| reader_endpoint | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas. |
