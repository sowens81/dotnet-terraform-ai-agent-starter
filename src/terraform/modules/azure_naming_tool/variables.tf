variable "naming_standard" {
  description = <<-EOT
    The naming standard to use for the resources. 
    The available options are:
    - **standard**: Use a standard pattern for naming all resources. There is a chance that other users of the standard may have the same names for global resources. This standard also includes a tag list with tag names, where `resourceName` is used, following the standard naming pattern with hyphens for all resources, even if the actual resource name tags have no names.
    - **hybrid**: Use a mixture of the standard naming pattern with random strings. It follows the same tagging practice as the "standard" naming pattern, but introduces randomness to avoid potential conflicts with global resources.
    - **dynamic**: Use random strings for all resources, without any predefined naming pattern. It avoids any conflicts with other resources but may lack consistency in naming conventions.
  EOT
  type        = string
  default     = "standard"

  validation {
    condition = contains(["standard", "hybrid", "dynamic"], var.naming_standard)

    error_message = "The provided naming standard must be one of 'standard', 'hybrid', or 'dynamic'."
  }
}

variable "location" {
  description = "Map of Azure regions to their short names"
  type        = string
  default     = "UK south"

  validation {
    condition = contains([for k, v in local.region_short : k], var.location)
    
    # Creating a string with all allowed regions for the error message
    error_message = "The provided location must be a valid Azure region. Allowed locations are: ${join(", ", [for k in local.region_short : k])}."
  }
}

variable "environment" {
  description = "The environment for the deployment"
  type        = string
  default     = "production"

  validation {
    condition = contains([for k in local.environment_short : k], var.environment)

    # Creating a string with all allowed environments for the error message
    error_message = "The provided environment must be valid. Allowed environments are: ${join(", ", [for k in local.environment_short : k])}."
  }
}