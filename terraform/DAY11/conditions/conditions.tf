resource "aws_instance" "conditions" {
    ami = var.ami_id
    instance_type = var.instance_name == "MongoDB" ? "t3.medium" : "t2.micro"
}