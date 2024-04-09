output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_az1.id,
    aws_subnet.public_subnet_az2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_az1.id,
    aws_subnet.private_subnet_az2.id
  ]
}

output "data_subnet_ids" {
  value = [
    aws_subnet.data_subnet_az1.id,
    aws_subnet.data_subnet_az2.id
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.natgw.id
}

output "nat_gateway_allocation_id" {
  value = aws_eip.natgw_eip.id
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}

output "data_route_table_id" {
  value = aws_route_table.data_route_table.id
}
