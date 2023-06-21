resource "null_resource" "validate_module_name" {
  count = local.module_name == var.tags["TerraformModuleName"] ? 0 : "Please check that you are using the Terraform module"
}

resource "null_resource" "validate_module_version" {
  count = local.module_version == var.tags["TerraformModuleVersion"] ? 0 : "Please check that you are using the Terraform module"
}

resource "aws_ec2_transit_gateway_route_table" "this" {
  count = var.create_tgw_rt ? 1 : 0

  transit_gateway_id = var.tgw_id

  tags = merge(
    var.tags, tomap(
      {"Name" = format("%s-%s-tgw-rt", var.prefix, var.tgw_rt_name)}
    )
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = length(values(var.tgw_attachment_id))

  transit_gateway_attachment_id  = values(var.tgw_attachment_id)[count.index]
  transit_gateway_route_table_id = element(concat(aws_ec2_transit_gateway_route_table.this.*.id, [""]), 0)

  depends_on = [
    aws_ec2_transit_gateway_route_table.this,
  ]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count = length(values(var.tgw_attachment_id))

  transit_gateway_attachment_id  = values(var.tgw_attachment_id)[count.index]
  transit_gateway_route_table_id = element(concat(aws_ec2_transit_gateway_route_table.this.*.id, [""]), 0)

  depends_on = [
    aws_ec2_transit_gateway_route_table.this,
  ]
}

resource "aws_ec2_transit_gateway_route" "this" {
  for_each = { for k, v in var.tgw_routes : k => v }

  destination_cidr_block         = each.value.destination_cidr_block
  blackhole                      = each.value.blackhole
  transit_gateway_route_table_id = element(concat(aws_ec2_transit_gateway_route_table.this.*.id, [""]), 0)
  transit_gateway_attachment_id  = lookup(var.tgw_attachment_id, each.key, null)

  depends_on = [
    aws_ec2_transit_gateway_route_table.this,
  ]
}