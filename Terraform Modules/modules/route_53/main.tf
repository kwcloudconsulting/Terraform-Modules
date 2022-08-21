# get hosted zone details
data "aws_route53_zone" "hosted_zone" {
  name = var.hosted_zone_name
}

# create a record set in route 53
resource "aws_route53_record" "site_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.aws_route53_record
  type    = "A"

  alias {
    name                   = var.route53_alias_name
    zone_id                = data.aws_route53_zone.hosted_zone.zone_id
    evaluate_target_health = true
  }
}