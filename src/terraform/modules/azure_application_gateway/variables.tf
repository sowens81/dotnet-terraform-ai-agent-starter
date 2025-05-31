variable "name" {
  type        = string
  description = "Name of app gateway"
}

variable "resource_group_name" {
  description = "The name of the Resource Group for the resource."
  type        = string
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default = {
    "provisioner" = "terraform"
  }
}

variable "sku_name" {
  description = "The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2."
  type        = string
  default     = "WAF_v2"
}

variable "sku_tier" {
  description = "The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2."
  type        = string
  default     = "WAF_v2"
}

variable "sku_capacity" {
  description = "(Optional) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU."
  type        = number
  default     = 1
}

variable "setup_identity_block" {
  description = "For TLS termination with Key Vault certificates to work properly existing user-assigned managed identity, which Application Gateway uses to retrieve certificates from Key Vault, should be defined via identity block."
  type        = bool
  default     = false
}

variable "identity_ids" {
  type        = list(string)
  description = "(Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Application Gateway."
  default     = null
}

variable "zones" {
  description = "Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "frontend_ip_configurations" {
  type = map(object({
    name                            = string,
    subnet_id                       = string,
    private_ip_address              = string,
    public_ip_address_id            = string,
    private_ip_address_allocation   = string,
    private_link_configuration_name = string
  }))
  default = {
    "default-frontend-ip-conf" = {
      name                            = "default-frontend-ip-conf"
      subnet_id                       = ""
      private_ip_address              = ""
      public_ip_address_id            = ""
      private_ip_address_allocation   = ""
      private_link_configuration_name = ""
    }
  }
}

variable "gateway_ip_configurations" {
  type = map(object({
    name      = string,
    subnet_id = string
  }))
  default = {
    "default-gateway-ip-conf" = {
      name      = "default-gateway-ip-conf",
      subnet_id = "required"
    }
  }
}

variable "frontend_ports" {
  type = map(object({
    name = string,
    port = number
  }))
  default = {
    "default-frontend-port" = {
      name = "default-frontend-port",
      port = 80
    }
  }
}

variable "http_listner" {
  type = map(object({
    name                                             = string,
    frontend_ip_configuration_name                   = string,
    frontend_port_name                               = string,
    host_name                                        = string,
    host_names                                       = list(string)
    protocol                                         = string
    require_sni                                      = bool
    ssl_certificate_name                             = string
    firewall_policy_id                               = string
    ssl_profile_name                                 = string
    setup_custom_error_configuration                 = bool
    custom_error_configuration_status_code           = string
    custom_error_configuration_custom_error_page_url = string
  }))
  default = {
    "default-http-listner" = {
      name                                             = "default-http-listner",
      frontend_ip_configuration_name                   = "default-frontend-ip-conf"
      frontend_port_name                               = "default-frontend-port"
      host_name                                        = ""
      host_names                                       = []
      protocol                                         = "Http"
      require_sni                                      = false
      ssl_certificate_name                             = ""
      firewall_policy_id                               = ""
      ssl_profile_name                                 = ""
      setup_custom_error_configuration                 = false
      custom_error_configuration_status_code           = ""
      custom_error_configuration_custom_error_page_url = ""
    }
  }
}

variable "backend_address_pool" {
  type = map(object({
    backend_address_pool_name       = string,
    backend_address_pool_fqdns      = list(string),
    backend_address_pool_ip_address = list(string)
  }))
  default = {
    "default-pool" = {
      backend_address_pool_name       = "default-pool"
      backend_address_pool_fqdns      = []
      backend_address_pool_ip_address = []
    }
  }
}

variable "backend_http_settings" {
  type = map(object({
    cookie_based_affinity               = string
    affinity_cookie_name                = string
    backend_http_settings_name          = string
    path                                = string
    port                                = number
    probe_name                          = string
    protocol                            = string
    request_timeout                     = number
    host_name                           = string
    pick_host_name_from_backend_address = bool
    setup_authentication_certificate    = bool
    authentication_certificate_name     = string
    trusted_root_certificate_names      = list(string)
    connection_draining_enabled         = bool
    drain_timeout_sec                   = number
  }))

  default = {
    "default-backend-http-settings" = {
      cookie_based_affinity               = "Disabled"
      affinity_cookie_name                = ""
      backend_http_settings_name          = "default-backend-http-settings"
      path                                = ""
      port                                = 80
      probe_name                          = ""
      protocol                            = "Http"
      request_timeout                     = 30
      host_name                           = ""
      pick_host_name_from_backend_address = false
      setup_authentication_certificate    = true
      authentication_certificate_name     = ""
      trusted_root_certificate_names      = []
      connection_draining_enabled         = true
      drain_timeout_sec                   = 1
    }
    "default2-backend-http-settings" = {
      cookie_based_affinity               = "Disabled"
      affinity_cookie_name                = ""
      backend_http_settings_name          = "default2-backend-http-settings"
      path                                = ""
      port                                = 80
      probe_name                          = ""
      protocol                            = "Http"
      request_timeout                     = 30
      host_name                           = ""
      pick_host_name_from_backend_address = false
      setup_authentication_certificate    = false
      authentication_certificate_name     = ""
      trusted_root_certificate_names      = []
      connection_draining_enabled         = false
      drain_timeout_sec                   = 1
    }
  }
}

variable "request_routing_rule" {
  type = map(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_http_settings_name = string
    priority                   = number
    backend_address_pool_name  = string
  }))
  default = {
    "default_routing_rule" = {
      name                       = "default_routing_rule"
      rule_type                  = "Basic"
      http_listener_name         = "default-http-listner"
      backend_http_settings_name = "default-backend-http-settings"
      priority                   = 20000
      backend_address_pool_name  = "default-pool"
    }
  }
}

variable "trusted_client_certificate" {
  type = map(object({
    name = string
    data = string
  }))
  default = null
}

variable "waf_configuration" {
  type = map(object({
    enabled          = bool
    firewall_mode    = string
    rule_set_type    = string
    rule_set_version = string
  }))
  default = null
}

variable "log_analytics_workspaces" {
  type = list(object({
    workspace_name = string
    workspace_id   = string
  }))
  description = "list of Log Analytics workspace with workspace name and id."
}