resource_group_name  = "rg-tfstate-sindre"
storage_account_name = "storagetfstatesindre"
container_name       = "tfstate"
use_azuread_auth     = true
use_cli              = true

   terraform init -migrate-state
     -backend-config="../shared/backend.hcl" 
     -backend-config="key=projects/backend/terraform.tfstate"