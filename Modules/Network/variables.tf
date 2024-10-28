variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "name of project"
  type = string

}
variable "environment" {
    description = "type of env"
    type = string
  
}

variable "AZs" {}
variable "public_subnet_cidr" {} 
variable "private_subnet_cidr" {}
variable "db_subnet_cidr" {
  
}