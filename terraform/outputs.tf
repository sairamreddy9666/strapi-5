output "ecr_repo_url" {
  value = aws_ecr_repository.strapi.repository_url
}

output "public_ip" {
  value = aws_instance.strapi.public_ip
}
output "public_dns" {
  value = aws_instance.strapi.public_dns
}
