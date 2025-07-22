resource "aws_instance" "ai" {
    ami = var.ami_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.allow_all.name]

/*
   tags = {
        Name = "MongoDB"
        Environment = "DEV"
        Terraform = "true"
        Project = "roboshop"
        Component = "MongoDB"
    }
*/

  tags = var.tags
}