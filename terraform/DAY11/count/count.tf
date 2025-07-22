resource "aws_instance" "ai" {
    count = 11 #if we give this way then all instance name will be same roboshop
    ami = var.ami_id
    instance_type = var.instance_names[count.index] == "MongoDB" || var.instance_names[count.index] == "Mysql" ? "t3.medium" : "t2.micro"

    tags = {
        Name = var.instance_names[count.index]
    }
}