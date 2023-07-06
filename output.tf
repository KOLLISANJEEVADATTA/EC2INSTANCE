output "vpc_id" {
  value = aws_vpc.VPC.id
}

output "subnet_id" {
  value = aws_subnet.SUBNET1.id
}

output "subnet_id-1" {
  value = aws_subnet.SUBNET2.id
}

output "sg_id" {
  value = aws_security_group.SG.id

}