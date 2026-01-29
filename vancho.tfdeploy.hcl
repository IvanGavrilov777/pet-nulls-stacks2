# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
#identity_token "aws" {
#  audience = ["aws.workload.identity"]
##}

#deployment "simple" {
#  inputs = {
#    prefix           = "simple"
#    instances        = 1
#region = "us-west-1"
#
#    role_arn            = "arn:aws:iam::459933373272:role/tfc-role"
#    identity_token_file = identity_token.aws.jwt_filename
#  }

#}

#deployment "complex" {
#  inputs = {
#    prefix           = "complex"
#    instances        = 3
#  }
#}

store "varset" "TFE_TOKEN" {
  #name     = "TFE_TOKEN"
  id = "varset-vBjRFWXnAEXsP534"
  category = "env"
}

deployment "vancho" {
  inputs = {
    prefix           = "vancho"
    instances        = 3
    TFE_TOKEN = store.varset.TFE_TOKEN.TFE_TOKEN
    remote_state  = upstream_input.name.name
  }
}



upstream_input "name" {
  type   = "stack"
  source = "app.terraform.io/ivan-premium-trial/stacks-testing/pet-nulls-stack"
}

