variable "vpc_name" {
  description = "name of project"
  type = string

}

variable "public_subnets" {}

variable "alb" {
    type = string
  
}
variable "vpc_id" {
  type = string
}
variable "environment" {
  
}