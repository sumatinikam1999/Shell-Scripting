resource "aws_instance" "firstec2" {
    ami = var.ami_id
    instance_type = var.instance_type
}

