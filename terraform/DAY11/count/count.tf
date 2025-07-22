resource "aws_instance" "ai" {
    count = 11 #if we give this way then all instance name will be same roboshop
    ami = var.ami_id
    instance_type = var.instance_names[count.index] == "MongoDB" || var.instance_names[count.index] == "Mysql" ? "t3.medium" : "t2.micro"

    tags = {
        Name = var.instance_names[count.index]
    }
}

resource "aws_route53_record" "record" {
    count = 11
    zone_id = var.zone_id
    name = "${var.instance_names[count.index]}.devopslearner.space" #when mixing string  variable give $ {} #interpolation
    type = "A"
    ttl = 1
    records = [aws_instance.conditions[count.inex].private_ip]
}