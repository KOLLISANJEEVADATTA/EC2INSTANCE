resource "aws_instance" "name" {
    ami = "ami-006935d9a6773e4ec"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    key_name = "aws-kp"
    subnet_id = aws_subnet.SUBNET1.id
    vpc_security_group_ids = ["${aws_security_group.SG.id}"]
    user_data = "${file("userdata.tpl")}"
}