resource "aws_instance" "firstec2"
{
    ami = "ami-0150ccaf51ab55a51"
    instance_type = "t2.micro"
}