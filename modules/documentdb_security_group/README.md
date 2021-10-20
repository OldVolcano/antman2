## Summary

Terraform module to create DocumentDB Security Groups

## Usage

```
module "documentdb_sg" {
  source = "../modules/documentdb_security_group"

  sg_name     = "documentdb-sg"
  vpc_id      = "vpc-212e5a47"
  source_cidr = "0.0.0.0/0"
  # source_address = "XXXXXXX"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Whether to create security group and its rules. | `bool` | `true` | no |
| vpc\_id | VPC ID where the DocumentDB Security Group will be deployed. | `string` | `null` | no |
| source\_address | Computed ingress rule to create where 'source_security_group_id' is used. | `string` | `null` | no |
| source\_cidr | IPv4 CIDR range to use on all ingress rules. | `string` | `null` | no |
| sg\_name | Name of security group - not required if create_group is false. | `string` | `null` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id | The ID of the DocumentDB Security Group. |
