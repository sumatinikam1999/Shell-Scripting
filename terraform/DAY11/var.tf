variable "ami_id" {
    type = string
    default = "ami-0150ccaf51ab55a51"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "sg" {
    default = "allow_all"
}

variable "cidr_blocks" {
    type = list
    default = ["0.0.0.0/0"]
}

variable "tags" {
    type = map
    default = {
                Name = "MongoDB"
        Environment = "DEV"
        Terraform = "true"
        Project = "roboshop"
        Component = "MongoDB"
    }
}