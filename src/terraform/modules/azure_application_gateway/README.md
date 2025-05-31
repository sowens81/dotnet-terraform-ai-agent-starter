<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.4.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.54.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.appgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.monitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agw_sku_capacity"></a> [agw\_sku\_capacity](#input\_agw\_sku\_capacity) | (Optional) The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. | `number` | `1` | no |
| <a name="input_agw_sku_name"></a> [agw\_sku\_name](#input\_agw\_sku\_name) | The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2. | `string` | `"WAF_v2"` | no |
| <a name="input_agw_sku_tier"></a> [agw\_sku\_tier](#input\_agw\_sku\_tier) | The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2. | `string` | `"WAF_v2"` | no |
| <a name="input_app_gateway_name"></a> [app\_gateway\_name](#input\_app\_gateway\_name) | Name of app gateway | `string` | n/a | yes |
| <a name="input_backend_address_pool"></a> [backend\_address\_pool](#input\_backend\_address\_pool) | n/a | <pre>map(object({<br>    backend_address_pool_name       = string,<br>    backend_address_pool_fqdns      = list(string),<br>    backend_address_pool_ip_address = list(string)<br>  }))</pre> | <pre>{<br>  "default-pool": {<br>    "backend_address_pool_fqdns": [],<br>    "backend_address_pool_ip_address": [],<br>    "backend_address_pool_name": "default-pool"<br>  }<br>}</pre> | no |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | n/a | <pre>map(object({<br>    cookie_based_affinity               = string<br>    affinity_cookie_name                = string<br>    backend_http_settings_name          = string<br>    path                                = string<br>    port                                = number<br>    probe_name                          = string<br>    protocol                            = string<br>    request_timeout                     = number<br>    host_name                           = string<br>    pick_host_name_from_backend_address = bool<br>    setup_authentication_certificate    = bool<br>    authentication_certificate_name     = string<br>    trusted_root_certificate_names      = list(string)<br>    connection_draining_enabled         = bool<br>    drain_timeout_sec                   = number<br>  }))</pre> | <pre>{<br>  "default-backend-http-settings": {<br>    "affinity_cookie_name": "",<br>    "authentication_certificate_name": "",<br>    "backend_http_settings_name": "default-backend-http-settings",<br>    "connection_draining_enabled": true,<br>    "cookie_based_affinity": "Disabled",<br>    "drain_timeout_sec": 1,<br>    "host_name": "",<br>    "path": "",<br>    "pick_host_name_from_backend_address": false,<br>    "port": 80,<br>    "probe_name": "",<br>    "protocol": "Http",<br>    "request_timeout": 30,<br>    "setup_authentication_certificate": true,<br>    "trusted_root_certificate_names": []<br>  },<br>  "default2-backend-http-settings": {<br>    "affinity_cookie_name": "",<br>    "authentication_certificate_name": "",<br>    "backend_http_settings_name": "default2-backend-http-settings",<br>    "connection_draining_enabled": false,<br>    "cookie_based_affinity": "Disabled",<br>    "drain_timeout_sec": 1,<br>    "host_name": "",<br>    "path": "",<br>    "pick_host_name_from_backend_address": false,<br>    "port": 80,<br>    "probe_name": "",<br>    "protocol": "Http",<br>    "request_timeout": 30,<br>    "setup_authentication_certificate": false,<br>    "trusted_root_certificate_names": []<br>  }<br>}</pre> | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | n/a | <pre>map(object({<br>    name                            = string,<br>    subnet_id                       = string,<br>    private_ip_address              = string,<br>    public_ip_address_id            = string,<br>    private_ip_address_allocation   = string,<br>    private_link_configuration_name = string<br>  }))</pre> | <pre>{<br>  "default-frontend-ip-conf": {<br>    "name": "default-frontend-ip-conf",<br>    "private_ip_address": "",<br>    "private_ip_address_allocation": "",<br>    "private_link_configuration_name": "",<br>    "public_ip_address_id": "",<br>    "subnet_id": ""<br>  }<br>}</pre> | no |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | n/a | <pre>map(object({<br>    name = string,<br>    port = number<br>  }))</pre> | <pre>{<br>  "default-frontend-port": {<br>    "name": "default-frontend-port",<br>    "port": 80<br>  }<br>}</pre> | no |
| <a name="input_gateway_ip_configurations"></a> [gateway\_ip\_configurations](#input\_gateway\_ip\_configurations) | n/a | <pre>map(object({<br>    name      = string,<br>    subnet_id = string<br>  }))</pre> | <pre>{<br>  "default-gateway-ip-conf": {<br>    "name": "default-gateway-ip-conf",<br>    "subnet_id": "required"<br>  }<br>}</pre> | no |
| <a name="input_http_listner"></a> [http\_listner](#input\_http\_listner) | n/a | <pre>map(object({<br>    name                                             = string,<br>    frontend_ip_configuration_name                   = string,<br>    frontend_port_name                               = string,<br>    host_name                                        = string,<br>    host_names                                       = list(string)<br>    protocol                                         = string<br>    require_sni                                      = bool<br>    ssl_certificate_name                             = string<br>    firewall_policy_id                               = string<br>    ssl_profile_name                                 = string<br>    setup_custom_error_configuration                 = bool<br>    custom_error_configuration_status_code           = string<br>    custom_error_configuration_custom_error_page_url = string<br>  }))</pre> | <pre>{<br>  "default-http-listner": {<br>    "custom_error_configuration_custom_error_page_url": "",<br>    "custom_error_configuration_status_code": "",<br>    "firewall_policy_id": "",<br>    "frontend_ip_configuration_name": "default-frontend-ip-conf",<br>    "frontend_port_name": "default-frontend-port",<br>    "host_name": "",<br>    "host_names": [],<br>    "name": "default-http-listner",<br>    "protocol": "Http",<br>    "require_sni": false,<br>    "setup_custom_error_configuration": false,<br>    "ssl_certificate_name": "",<br>    "ssl_profile_name": ""<br>  }<br>}</pre> | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (Required) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Application Gateway. | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. | `string` | n/a | yes |
| <a name="input_log_analytics_workspaces"></a> [log\_analytics\_workspaces](#input\_log\_analytics\_workspaces) | list of Log Analytics workspace with workspace name and id. | <pre>list(object({<br>    workspace_name = string<br>    workspace_id   = string<br>  }))</pre> | n/a | yes |
| <a name="input_request_routing_rule"></a> [request\_routing\_rule](#input\_request\_routing\_rule) | n/a | <pre>map(object({<br>    name                       = string<br>    rule_type                  = string<br>    http_listener_name         = string<br>    backend_http_settings_name = string<br>    priority                   = number<br>    backend_address_pool_name  = string<br>  }))</pre> | <pre>{<br>  "default_routing_rule": {<br>    "backend_address_pool_name": "default-pool",<br>    "backend_http_settings_name": "default-backend-http-settings",<br>    "http_listener_name": "default-http-listner",<br>    "name": "default_routing_rule",<br>    "priority": 20000,<br>    "rule_type": "Basic"<br>  }<br>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group for the resource. | `string` | n/a | yes |
| <a name="input_setup_identity_block"></a> [setup\_identity\_block](#input\_setup\_identity\_block) | For TLS termination with Key Vault certificates to work properly existing user-assigned managed identity, which Application Gateway uses to retrieve certificates from Key Vault, should be defined via identity block. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | <pre>{<br>  "provisioner": "terraform"<br>}</pre> | no |
| <a name="input_trusted_client_certificate"></a> [trusted\_client\_certificate](#input\_trusted\_client\_certificate) | n/a | <pre>map(object({<br>    name = string<br>    data = string<br>  }))</pre> | `null` | no |
| <a name="input_waf_configuration"></a> [waf\_configuration](#input\_waf\_configuration) | n/a | <pre>map(object({<br>    enabled          = bool<br>    firewall_mode    = string<br>    rule_set_type    = string<br>    rule_set_version = string<br>  }))</pre> | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Specifies a list of Availability Zones in which this Application Gateway should be located. Changing this forces a new Application Gateway to be created. | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_gw_id"></a> [app\_gw\_id](#output\_app\_gw\_id) | n/a |
<!-- END_TF_DOCS -->