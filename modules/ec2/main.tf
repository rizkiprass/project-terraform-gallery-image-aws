################ EC2 #################

resource "aws_instance" "general" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_id
  associate_public_ip_address = var.associate_public_ip
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = {
      Name = "${var.prefix_name}-${var.env}-${var.name}-root-ebs"
    }
  }

  tags = {
    Name = "${var.prefix_name}-${var.env}-${var.name}"
  }
}