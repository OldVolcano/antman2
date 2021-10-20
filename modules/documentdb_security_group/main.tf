resource "aws_security_group" "documentdb_security_group" {
  count = var.create ? 1 : 0

  name_prefix = "${var.sg_name}-"
  description = "Security Group managed by Terraform"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.sg_name)
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "documentdb_sg_egress_all" {
  count = var.create ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = (aws_security_group.documentdb_security_group.*.id)[0]
}

resource "aws_security_group_rule" "documentdb_sg_ingress_all_cidrs" {
  count = var.source_cidr == null ? 0 : 1

  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [var.source_cidr]
  security_group_id = (aws_security_group.documentdb_security_group.*.id)[0]
  description       = "Allow CIDR/s to access DocumentDB"
}

resource "aws_security_group_rule" "documentdb_sg_ingress_all_addresses" {
  count = var.source_address == null ? 0 : 1

  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = var.source_address
  security_group_id        = (aws_security_group.documentdb_security_group.*.id)[0]
  description              = "Allow Source Address/es to access DocumentDB"
}
