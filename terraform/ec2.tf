data "aws_security_group" "strapi_sg" {
  filter {
    name   = "group-name"
    values = ["strapi-sg"]
  }
  vpc_id = "vpc-01b35def73b166fdc"
}

resource "aws_instance" "strapi" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  availability_zone = "ap-south-1a"
  subnet_id         = "subnet-0393e7c5b435bd5b6"

  vpc_security_group_ids = [data.aws_security_group.strapi_sg.id]

  user_data = file("user_data.tpl")

  tags = {
    Name = "Sairam-Server"
  }
}
