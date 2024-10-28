resource "aws_db_subnet_group" "db_subnet_group" {
    name       = "db_subnet_group"
    subnet_ids = [var.db_subnets[0], var.db_subnets[1]]  # subnet IDs for DB 

    tags = {
        Name = "db_subnet_group"
        environment = "${var.environment}"
    }
}
resource "aws_db_instance" "instance" {
    db_name              = var.database_name
    allocated_storage    = var.allocated_storage
    storage_type         = var.storage_type
    engine               = var.engine    #"mysql" or postgras
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    username             = var.username
    password             = var.password
    db_subnet_group_name = "${aws_db_subnet_group.db_subnet_group.name}"
    vpc_security_group_ids = [var.rds]

    multi_az             = true
    skip_final_snapshot    = true  # this will skip the final snapshot after deleting the rds


    # Additional configurations
    backup_retention_period = var.backup_retention_period
    backup_window           = var.backup_window
    maintenance_window      = var.maintenance_window

    tags = {
        Name ="RDSdbinstance"
        environment = "${var.environment}"
    }
}

