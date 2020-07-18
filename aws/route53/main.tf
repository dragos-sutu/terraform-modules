resource "aws_route53_zone" "zones" {
  for_each = var.zones

  name = each.value

  tags = var.tags
}


data "aws_route53_zone" "zone" {
  count = length(var.alias_records)

  name = var.alias_records[count.index].zone_name
}

resource "aws_route53_record" "records" {
  count = length(var.alias_records)

  alias {
    name                   = var.alias_records[count.index].alias.name
    zone_id                = var.alias_records[count.index].alias.zone_id
    evaluate_target_health = false
  }

  zone_id = data.aws_route53_zone.zone[count.index].zone_id
  name    = var.alias_records[count.index].name
  type    = var.alias_records[count.index].type
}
