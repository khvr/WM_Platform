bucket               = "<tf-state-bucket>"
key                  = "terraform.tfstate"
region               = "<aws-region>"
dynamodb_table       = "<tf-lock-dynamodb-table>"
encrypt              = true
workspace_key_prefix = "spa/prod"