variable "remote_state_bucket" {
}

variable "tooling_stack_name" {
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

// Pages Repositories

variable "pages_repositories" {
  type = list(string)
  default = ["pages-build-container"]
}


resource "aws_ecr_repository" "pages_repository" {
  count = length(var.pages_repositories)

  name                 = var.pages_repositories[count.index]
  image_tag_mutability = "MUTABLE"
}

