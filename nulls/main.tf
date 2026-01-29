# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

variable "pet" {
  type = string
}

variable "instances" {
  type = number
}

/*
module "repo" {
  source  = "app.terraform.io/ivan-premium-trial/repo/tags"
  version = "499.0.0"
}

*/

# module "pet" {
#   source  = "app.terraform.io/ivan-premium-trial/pet/random"
#   version = "13.0.0"
# }

resource "null_resource" "this" {
  count = var.instances

  triggers = {
    pet = var.pet
  }
}

output "ids" {
  value = [for n in null_resource.this: n.id]
}

