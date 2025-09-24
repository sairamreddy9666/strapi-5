variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "ami_id" {
  type    = string
  description = "AMI id (Amazon Linux 2 recommended)"
  default = "ami-01b6d88af12965bb6"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  description = "EC2 Key pair name (pre-created in AWS). Required for SSH."
  default = "first-kp"
}

variable "image_tag" {
  type    = string
  description = "Image tag to deploy (passed from GH Action)"
  default = "latest"
}

