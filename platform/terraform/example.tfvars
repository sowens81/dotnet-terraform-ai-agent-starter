subscription_id     = "00000000-0000-0000-0000-000000000000" # Replace with your actual subscription ID"
resource_name_alias = "exmaple" # This should be a unique alias for your resources
environment_suffix  = "dev" # This suffix will be appended to resource names to distinguish environments
project_name        = "example-project-name" # Name of the project for which resources are being created
location            = "uksouth" # Azure region where resources will be deployed
tags = {

  "Owner"       = "AI Team" # Owner of the resources, can be an individual or a team
  "CostCenter"  = "AI-Development" # Optional tag for cost tracking
}