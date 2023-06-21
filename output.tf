###########################################################################
# output for Resource: aws_ec2_transit_gateway_route_table
###########################################################################

output "tgw_rt_arn" {
  value = element(concat(aws_ec2_transit_gateway_route_table.this.*.arn, [""]), 0)
}

output "tgw_rt_id" {
  value = element(concat(aws_ec2_transit_gateway_route_table.this.*.id, [""]), 0)
}

output "tgw_rt_default_association_route_table" {
  value = element(concat(aws_ec2_transit_gateway_route_table.this.*.default_association_route_table, [""]), 0)
}

output "tgw_rt_default_propagation_route_table" {
  value = element(concat(aws_ec2_transit_gateway_route_table.this.*.default_propagation_route_table, [""]), 0)
}

output "tgw_rt_tags_all" {
  value = element(concat(aws_ec2_transit_gateway_route_table.this.*.tags_all, [""]), 0)
}