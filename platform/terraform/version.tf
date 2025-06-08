terraform {
  required_version = ">= 1.12.1, < 1.13.0"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.30.0, < 5.0.0"
    }
  }
}