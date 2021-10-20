###############################################################################
# Variables - Security Groups
###############################################################################
variable "create" {
  description = "Whether to create security group and its rules."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID where the DocumentDB Security Group will be deployed."
  type        = string
  default     = null
}

variable "source_address" {
  description = "Computed ingress rule to create where 'source_security_group_id' is used."
  type        = string
  default     = null
}

variable "source_cidr" {
  description = "IPv4 CIDR range to use on all ingress rules."
  type        = string
  default     = null
}

variable "sg_name" {
  description = "Name of security group - not required if create_group is false."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
