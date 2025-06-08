terraform {
  required_version = ">= 1.5.7, < 1.6.0"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.30.0, < 5.0.0"
    }
  }
}