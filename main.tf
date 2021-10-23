data "aws_subnet" "osxp" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-subnet"]
  }
}

data "aws_security_group" "osxp_all" {
  filter {
    name   = "tag:Name"
    values = ["${var.project}-all"]
  }
}

data "aws_route53_zone" "osxp" {
  name = var.domain
}

resource "aws_instance" "user" {
  ami                         = var.ami
  instance_type               = var.ec2_type
  subnet_id                   = data.aws_subnet.osxp.id
  vpc_security_group_ids      = [data.aws_security_group.osxp_all.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/scripts/user.yaml.tpl", {
    pubkey    = var.pubkey
    awxpubkey = var.awxpubkey
    name      = var.login
    domain    = var.domain
  })

  tags = {
    Name  = "${var.project}-user-${var.user}"
    TTL   = "86400"
    owner = "${var.project}-AWX"
  }
}

resource "aws_route53_record" "user" {
  zone_id = data.aws_route53_zone.osxp.zone_id
  ttl     = "60"
  type    = "A"
  name    = var.user
  records = [aws_instance.user.public_ip]
}
