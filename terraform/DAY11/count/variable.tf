variable "ami_id" {
    type = string
    default = "ami-0150ccaf51ab55a51"
}


variable "instance_names" {
    type = list
    default = ["MongoDB", "Cart", "Catalogue", "User", "Payment", "Shipping", "Dispatch", "Mysql", "Redis", "Web", "RabbitMQ"]
}

variable "zone_id" {
    default = "Z00027373O2OKHY987PPU"
}

variable "domain" {
    default = "devopslearner.space"
}