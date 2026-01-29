# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
variable "remote_state" {
type = string
}

variable "prefix" {
  type = string
}

variable "instances" {
  type = number
}
variable "TFE_TOKEN" {
  type = string
  ephemeral = true
  sensitive = true
}

#variable "TFE_TOKEN"{}
##variable "region" {
#  type = string
#}

#variable "identity_token_file" {
#  type = string
#}

#variable "role_arn" {
#  type = string
#}


required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }

  null = {
    source  = "hashicorp/null"
    version = "~> 3.2.2"
  }

  tfe = {
    source = "hashicorp/tfe"
    version = "0.73.0"
  }

 # aws = {
 #   source = "hashicorp/aws"
 #   version = "5.61.0"
 # }
}

provider "random" "this" {}
provider "null" "this" {}
provider "tfe" "this" {
  config {
    token = var.TFE_TOKEN
  }
}
#provider "aws" "this" {
#config {
#    region = var.region
#    assume_role_with_web_identity {
#      role_arn                = var.role_arn
#      web_identity_token_file = var.identity_token_file
#    }
#}
#}



component "pet" {
  source = "./pet"

  inputs = {
    prefix = var.prefix
    #TFE_TOKEN = var.TFE_TOKEN
  }

  providers = {
    random = provider.random.this
    tfe = provider.tfe.this
  }
}

output "readstate" {
  description = "reading the state from another workspace"
  type        = string
  value       = component.pet.tfe_outputs_values
  sensitive = true
}
#12



component "nulls" {
  source = "./nulls"

  inputs = {
    pet       = component.pet.name
    instances = var.instances
  }

  providers = {
    null = provider.null.this
    random = provider.random.this
  }
}


#component "ec2" {
#  source = "./ec2"
#
#  providers = {
#    aws = provider.aws.this
#  }
#}

