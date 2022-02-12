bucket               = "harsha-tf-state-bucket"
key                  = "terraform.tfstate"
region               = "us-east-1"
dynamodb_table       = "harsha-tf-state-dynamic-lock"
encrypt              = true
workspace_key_prefix = "spa/prod"