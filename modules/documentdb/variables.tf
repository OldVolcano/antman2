variable "group_subnets" {
  type        = list(string)
  description = "A list of VPC subnet IDs."
  default     = []
}

variable "cluster_security_group" {
  description = "List of VPC security groups to associate with the Cluster"
  type        = list(string)
}

variable "master_password" {
  type        = string
  description = "Password for the master DB user."
}

variable "region" {
  type        = string
  description = "Region where resources will be created."
}

variable "global_identifier" {
  type        = string
  description = "The cluster identifier of the new global cluster."
}

variable "create_global" {
  type        = bool
  description = "Boolean if to create Global database or not."
}

variable "account_id" {
  type        = string
  description = "Account ID where resources are to be created."
}

variable "global_region" {
  type        = list
  description = "List of regions where replication will be spun up."
}

variable "master_username" {
  type        = string
  description = "Username for the master DB user."
}

variable "cluster_instance_class" {
  type    = string
  default = "db.r5.large"
}

variable "cluster_instance_count" {
  type    = number
  default = 1
}

variable "name" {
  type        = string
  description = "Unique DocumentDB cluster identifier."
}

variable "backup_retention_period" {
  default = 7
  type    = number
}

variable "preferred_backup_window" {
  default = "07:00-09:00"
  type    = string
}

variable "skip_final_snapshot" {
  default     = false
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  type        = bool
}

variable "parameters" {
  description = "additional parameters modified in parameter group"
  type        = list(map(any))
  default     = []
}

variable "apply_immediately" {
  default     = false
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
}

variable "family" {
  default     = "docdb4.0"
  description = "Version of docdb family being created"
  type        = string
}

variable "engine" {
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Only `docdb` is supported."
  type        = string
}

variable "engine_version" {
  default     = "4.0.0"
  description = "The database engine version. Updating this argument results in an outage."
  type        = string
}
