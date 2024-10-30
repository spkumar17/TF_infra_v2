# # Fetch the existing hosted zone by its domain name
# data "aws_route53_zone" "my_zone" {
#   name =  var.domain_name  
#   private_zone = false
# }

# # request public certificates from the amazon certificate manager.
# resource "aws_acm_certificate" "acm_certificate" {
#   domain_name               = var.domain_name
#   subject_alternative_names = [var.alternate_name]
#   validation_method         = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }



# # validate acm certificates
# resource "aws_acm_certificate_validation" "acm_certificate_validation" {
#     certificate_arn         = aws_acm_certificate.acm_certificate.arn
#     validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
    
#     depends_on = [aws_route53_record.route53_record]  # Explicitly specify the dependency

# }

# # create a record set in route 53 for domain validatation
# resource "aws_route53_record" "route53_record" {
#   for_each = {
#     for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.my_zone.zone_id 
# }

# Fetch the existing hosted zone by its domain name
data "aws_route53_zone" "my_zone" {
  name         = var.domain_name  
  private_zone = false
}

# Request public certificates from Amazon Certificate Manager
resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = [var.alternate_name]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Create record set in Route 53 for domain validation
resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.my_zone.zone_id 
}

# Validate ACM certificates
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
    certificate_arn         = aws_acm_certificate.acm_certificate.arn
    validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]

    depends_on = [aws_route53_record.route53_record]
}
