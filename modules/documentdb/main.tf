resource "aws_docdb_subnet_group" "docdb" {
  name_prefix = var.name
  subnet_ids  = var.group_subnets
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier              = var.name
  db_subnet_group_name            = aws_docdb_subnet_group.docdb.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb.name
  vpc_security_group_ids          = var.cluster_security_group
  engine                          = var.engine
  engine_version                  = var.engine_version
  master_username                 = var.master_username
  master_password                 = var.master_password
  apply_immediately               = var.apply_immediately

  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.cluster_instance_count
  identifier         = var.name
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.cluster_instance_class
}

resource "aws_docdb_cluster_parameter_group" "docdb" {
  family      = var.family
  name_prefix = var.name
  description = "${var.name} docdb cluster parameter group"
  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

###############################################################################
# Creates Global Cluster
###############################################################################
resource "null_resource" "create_global_cluster" {
  count = var.create_global ? 1 : 0
  provisioner "local-exec" {
    command = "aws docdb create-global-cluster --region ${var.region} --global-cluster-identifier ${var.global_identifier} --source-db-cluster-identifier ${aws_docdb_cluster.docdb.arn}"
  }
  depends_on = [aws_docdb_cluster.docdb, aws_docdb_cluster_instance.cluster_instances]
}

###############################################################################
# Creates DocDB Cluster replication on the following regions
###############################################################################
resource "null_resource" "create_replication_cluster" {
  count = var.create_global ? length(var.global_region) : 0
  provisioner "local-exec" {
        command = "aws docdb --region ${var.global_region[count.index]} create-db-cluster --db-cluster-identifier ${var.name} --global-cluster-identifier ${var.global_identifier} --engine ${var.engine} --engine-version ${var.engine_version}"
  }
  depends_on = [null_resource.create_global_cluster]
}

resource "time_sleep" "wait_2_minutes" {
  count = var.create_global ? 1 : 0
  depends_on = [null_resource.create_replication_cluster]

  create_duration = "120s"
}

###############################################################################
# Creates DocDB Instances on the following regions
###############################################################################
resource "null_resource" "create_replication_instance" {
  count = var.create_global ? length(var.global_region) : 0
  provisioner "local-exec" {
    command = "aws docdb --region ${var.global_region[count.index]} create-db-instance --db-instance-class ${var.cluster_instance_class} --db-cluster-identifier ${var.name} --db-instance-identifier ${var.name} --engine ${var.engine}"
  }
  depends_on = [null_resource.create_global_cluster, null_resource.create_replication_cluster, time_sleep.wait_2_minutes]
}

###############################################################################
# Removing Replication Cluster from Global
###############################################################################
resource "null_resource" "remove_replication_global" {
  count = var.create_global ? 0 : length(var.global_region)

  provisioner "local-exec" {
    command = "aws docdb --region ${var.global_region[count.index]} remove-from-global-cluster --db-cluster-identifier arn:aws:rds:${var.global_region[count.index]}:${var.account_id}:cluster:${var.name} --global-cluster-identifier ${var.global_identifier}"
  }
}

resource "time_sleep" "wait_2_minutes_remove_replicas" {
  count = var.create_global ? 0 : 1
  depends_on = [null_resource.remove_replication_global]

  create_duration = "120s"
}

###############################################################################
# Removing Source Cluster from Global
###############################################################################
resource "null_resource" "remove_source_global" {
  count = var.create_global ? 0 : 1

  provisioner "local-exec" {
    command = "aws docdb --region ${var.region} remove-from-global-cluster --db-cluster-identifier arn:aws:rds:${var.region}:${var.account_id}:cluster:${var.name} --global-cluster-identifier ${var.global_identifier}"
  }

  depends_on = [null_resource.remove_replication_global, time_sleep.wait_2_minutes_remove_replicas]
}

resource "time_sleep" "wait_2_minutes_remove_source" {
  count = var.create_global ? 0 : 1
  depends_on = [null_resource.remove_source_global]

  create_duration = "120s"
}

###############################################################################
# Deleting Global
###############################################################################
resource "null_resource" "delete_global_cluster" {
  count = var.create_global ? 0 : 1

  provisioner "local-exec" {
    command = "aws docdb delete-global-cluster --region ${var.region} --global-cluster-identifier ${var.global_identifier}"
  }

  depends_on = [null_resource.remove_source_global, time_sleep.wait_2_minutes_remove_source]
}

resource "time_sleep" "wait_1_minutes_remove_global" {
  count = var.create_global ? 0 : 1
  depends_on = [null_resource.delete_global_cluster]

  create_duration = "60s"
}

###############################################################################
# Deleting Replication Instances
###############################################################################
resource "null_resource" "delete_instance_replicas" {
  count = var.create_global ? 0 : length(var.global_region)

  provisioner "local-exec" {
    command = "aws docdb --region ${var.global_region[count.index]} delete-db-instance --db-instance-identifier ${var.name}"
  }
  depends_on = [null_resource.delete_global_cluster, time_sleep.wait_1_minutes_remove_global]
}

resource "time_sleep" "wait_2_minutes_remove_replica_instances" {
  count = var.create_global ? 0 : 1
  depends_on = [null_resource.delete_instance_replicas]

  create_duration = "120s"
}

###############################################################################
# Deleting Replication Clusters
###############################################################################
resource "null_resource" "delete_cluster_replicas" {
  count = var.create_global ? 0 : length(var.global_region)

  provisioner "local-exec" {
    command = "aws docdb --region ${var.global_region[count.index]} delete-db-cluster --db-cluster-identifier ${var.name} --skip-final-snapshot"
  }

  depends_on = [null_resource.delete_instance_replicas, time_sleep.wait_2_minutes_remove_replica_instances]
}
