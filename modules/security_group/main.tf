########################
##Security Group ALB
########################

resource "aws_security_group" "alb-sg" {
  name        = "${var.name}-alb-sg"
  description = var.description_alb
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.alb-port-list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "0.0.0.0/0"]
      description = ingress.key
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}-alb-sg"
  }
}

########################
##Security Group app Server
########################

resource "aws_security_group" "app-sg" {
  name        = "${var.name}-app-sg"
  description = var.description_app
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.application-port-list
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = var.cidr != "" ? [var.cidr] : []
      security_groups = [aws_security_group.alb-sg.id]
      description     = ingress.key
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-app-sg"
  }
}

########################
##Security Group db
########################

//mysql-sg
resource "aws_security_group" "db-sg" {
  name        = "${var.name}-db-sg"
  description = var.description_db
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.mysql-port-list
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = var.cidr != "" ? [var.cidr] : []
      security_groups = [aws_security_group.app-sg.id]
      description     = ingress.key
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1" //all traffic
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name}-db-sg"
  }

}