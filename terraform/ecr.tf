resource "aws_ecr_repository" "strapi" {
  name = "strapi"
  image_scanning_configuration {
    scan_on_push = true
  }
}

