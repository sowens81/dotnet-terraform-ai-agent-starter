variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID where resources will be deployed."
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "The subscription_id must be a valid GUID."
  }
}

variable "resource_name_alias" {
  type        = string
  description = "Alias for the resource name, used for naming conventions. Must be 12 characters or fewer."
  default     = "aiexample"

  validation {
    condition     = length(var.resource_name_alias) <= 12
    error_message = "The resource_name_alias must be 12 characters or fewer."
  }
}

variable "environment_suffix" {
  type        = string
  description = "Suffix for the environment, used for naming conventions. Allowed values: int, dev, tst, uat, stg, prd."
  default     = "dev"

  validation {
    condition     = contains(["int", "dev", "tst", "uat", "stg", "prd"], var.environment_suffix)
    error_message = "The environment_suffix must be one of: int, dev, tst, uat, stg, prd."
  }
}

variable "project_name" {
  type        = string
  description = "Name for the AI Foundry Project."
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,32}$", var.project_name))
    error_message = "AI Services Project name must be 2 - 32 characters long, and contain only letters, numbers, and hyphens."
  }
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources in. Must be a valid Azure public region name in lowercase with no spaces (e.g., 'uksouth', 'westeurope')."

  validation {
    condition = contains([
      "ukwest", "uksouth", "westeurope", "northeurope",
      "eastus", "eastus2", "centralus", "northcentralus", "southcentralus",
      "westus", "westus2", "westus3",
      "canadacentral", "canadaeast",
      "francecentral", "francesouth",
      "germanywestcentral", "germanynorth",
      "norwayeast", "norwaywest",
      "swedencentral",
      "switzerlandnorth", "switzerlandwest",
      "uaenorth", "uaecentral",
      "brazilsouth",
      "japaneast", "japanwest",
      "australiaeast", "australiasoutheast", "australiacentral",
      "southeastasia", "eastasia",
      "koreacentral", "koreasouth",
      "southafricanorth", "southafricawest",
      "indiacentral", "indiawest", "indiasouth"
    ], var.location)
    error_message = "Invalid Azure region. Must be one of the official Azure public regions in lowercase with no spaces (e.g., 'uksouth', 'westeurope')."
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "provisioner" = "terraform"
  }
}