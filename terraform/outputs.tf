output "instance_public_ip" {
  value = aws_instance.strapi.public_ip
}
output "public_dns" {
  value = aws_instance.strapi.public_dns
}
