variable "image_id"{
    description = "image id"
    type= string

}    
variable "instance_type" {
    description = "type of the instance "
    type = string
    default = "t2.micro"
  
}
variable "instance_name" {
    description = "specifies the name of the instance created"
    type =string
  
}
variable "asg" {
    description = "security group id (asg) winstances---> allow this portss"
    type = string
  
}
variable "private_subnets"{}

variable "aws_iam_instance_profile" {
    description = "name of ec2 iam instace profile "
    type=string
  
}

variable "max_size" {
    description = "max count that auto scale can increase"
    type = string
  
}
variable "min_size" {
    description = "min count that auto scalig will maintain"
    type = string
  
}
variable "health_check_grace_period" {
    description = "till this grace time no new instance will be created even of the instance is in unhealthy state"
    type = string
}
variable "health_check_type" {
    description = "based on which  type auto scale spin up or scale down the instance"
    type = string
  
}
variable "desired_capacity" {

    description = "capacity that asg maintain aat nrml times"
    type = string
  
}
variable "vpc_name" {
  description = "name of project"
  type = string

}


variable "db_instance_endpoint"{
    description= "holds the RDS endpoint"
    type= string
}

variable "alb_target_group_arn"{
    type=string
}

variable "database_name" {}
variable "key" {}