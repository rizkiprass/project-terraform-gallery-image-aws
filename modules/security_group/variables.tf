variable "name" {
  default = ""
}

variable "description_alb" {
  default = ""
}

variable "description_app" {
  default = ""
}

variable "description_web" {
  default = ""
}

variable "description_db" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "cidr" {
  default = ""
}

variable "alb-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
  }
}

variable "application-port-list" {
  type = map(any)
  default = {
    "tcp"  = 8080
  }
}

variable "web-port-list" {
  type = map(any)
  default = {
    "tcp"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

variable "mysql-port-list" {
  type = map(any)
  default = {
    "mysql" = 3306,
    "ssh"   = 22
  }
}

