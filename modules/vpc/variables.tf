variable "name" {
  type = string
  default = ""
}

variable "env" {
  type = string
  default = ""
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_az1" {
  description = "public subnets az1 inside the VPC"
  type        = string
  default     = ""
}

variable "public_subnet_az2" {
  description = "public subnets az2 inside the VPC"
  type        = string
  default     = ""
}

variable "private_subnet_az1" {
  description = "private subnets az1 inside the VPC"
  type        = string
  default     = ""
}

variable "private_subnet_az2" {
  description = "private subnets az2 inside the VPC"
  type        = string
  default     = ""
}

variable "data_subnet_az1" {
  description = "data subnets az1 inside the VPC"
  type        = string
  default     = ""
}

variable "data_subnet_az2" {
  description = "data subnets az2 inside the VPC"
  type        = string
  default     = ""
}