resource "aws_ecr_repository" "strapi" {
  name = "strapi-ecr"
  image_scanning_configuration {
    scan_on_push = true
  }
}

