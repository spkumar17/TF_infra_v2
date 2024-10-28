output "domain_name" {
    value = data.aws_route53_zone.my_zone.name
}

