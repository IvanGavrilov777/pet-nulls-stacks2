# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }
    tfe = {
      source = "hashicorp/tfe"
      version = "0.73.0"
    }
  }
}

variable "prefix" {
  type = string
}

# variable "TFE_TOKEN" {
#   type = string
#   ephemeral = true
#   sensitive = true
# }



resource "random_pet" "this" {
  prefix = var.prefix
  length = 3
}


output "name" {
  value = random_pet.this.id
}

data "tfe_outputs" "foo" {
  organization = "ivan-premium-trial"
  workspace = "trust-relationship-for-stacks"
}

output "tfe_outputs_values" {
  value = data.tfe_outputs.foo.values.role_arn
  sensitive = true
}

# resource "tfe_project" "test" {
#   organization = "ivan-premium-trial"
#   name = "newproject"
# }

# resource "tfe_team" "test" {
#   name         = "my-new-team-name"
#   organization = "ivan-premium-trial"
# }

