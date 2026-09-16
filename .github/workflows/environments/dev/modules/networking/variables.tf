variable "environment" {
  type        = string
  description = "The name of the target cloud environment (dev, staging, prod)"
}

variable "vpc_cidr" {
  type        = string
  description = "The base network address range"
}
