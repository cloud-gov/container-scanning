variable "remote_state_bucket" {
}

variable "tooling_stack_name" {
}

variable "repositories" {
  type = list(string)
  default = ["concourse-task","s3-resource-simple"]
}

terraform {
  backend "s3" {
  }
}


data "terraform_remote_state" "tooling" {
  backend = "s3"
  config = {
    bucket = var.remote_state_bucket
    key    = "${var.tooling_stack_name}/terraform.tfstate"
  }
}


resource "aws_ecr_repository" "repository" {
  count = length(var.repositories)

  name                 = var.repository_name[count.index]
  image_tag_mutability = "IMMUTABLE"
}
