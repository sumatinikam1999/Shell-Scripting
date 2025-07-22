resource "aws_security_group" "allow_all" {
    name = var.sg

    ingress {
        description = "allow all"
        from_port = 0
        to_port = 0
        protocol = "TCP"
        cidr_blocks = var.cidr_blocks
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.cidr_blocks
    }
}