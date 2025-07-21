variable "ami_id" {
    type = string # data type
    default = "ami-0150ccaf51ab55a51" # default  value
}

variable "instance_type" {
    type = string # data type
    default = "t2.micro" # default  value
}

variable "sg" {
    default = "allow-all"
}

variable "sg_cidr" {
    type = list
    default = ["0.0.0.0/0"] #list
}
