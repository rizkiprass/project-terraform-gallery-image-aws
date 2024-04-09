variable "name" {
  default = ""
}

variable "prefix_name" {
  default = ""
}

variable "env" {
  default = ""
}

variable "ami" {
  default = ""
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = ""
}

variable "user_data" {
  default = ""
}

variable "associate_public_ip" {
  description = "associate_public_ip"
  type = bool
  default = false
}

variable "subnet_id" {
  default = ""
}

variable "security_group_id" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "volume_size" {
  default = "10"
}

variable "iam_instance_profile" {
  description = ""
  default = ""
}