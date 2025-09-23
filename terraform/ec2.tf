resource "aws_instance" "strapi" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = "subnet-xxxxxx"          # replace with your subnet
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = templatefile("${path.module}/user_data.tpl", {
    image_url = "${data.aws_ecr_repository.strapi.repository_url}:${var.image_tag}"
  })

  tags = {
    Name = "strapi-server"
  }
}

