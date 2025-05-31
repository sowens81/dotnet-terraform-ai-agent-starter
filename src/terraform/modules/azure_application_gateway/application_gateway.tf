
resource "azurerm_application_gateway" "application_gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  zones               = var.zones
  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  dynamic "identity" {
    for_each = var.setup_identity_block == true ? ["setup_identity_block"] : []
    content {
      type         = "UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configurations
    content {
      name      = gateway_ip_configuration.value["name"]
      subnet_id = gateway_ip_configuration.value["subnet_id"]
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations
    content {
      name                            = frontend_ip_configuration.value["name"]
      subnet_id                       = frontend_ip_configuration.value["subnet_id"] == "" ? null : frontend_ip_configuration.value["subnet_id"]
      private_ip_address              = frontend_ip_configuration.value["private_ip_address"] == "" ? null : frontend_ip_configuration.value["private_ip_address"]
      public_ip_address_id            = frontend_ip_configuration.value["public_ip_address_id"] == "" ? null : frontend_ip_configuration.value["public_ip_address_id"]
      private_ip_address_allocation   = frontend_ip_configuration.value["private_ip_address_allocation"] == "" ? null : frontend_ip_configuration.value["private_ip_address_allocation"]
      private_link_configuration_name = frontend_ip_configuration.value["private_link_configuration_name"] == "" ? null : frontend_ip_configuration.value["private_link_configuration_name"]
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value["name"]
      port = frontend_port.value["port"]
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      cookie_based_affinity               = backend_http_settings.value["cookie_based_affinity"]
      affinity_cookie_name                = backend_http_settings.value["affinity_cookie_name"] == "" ? null : backend_http_settings.value["affinity_cookie_name"]
      name                                = backend_http_settings.value["backend_http_settings_name"]
      path                                = backend_http_settings.value["path"] == "" ? null : backend_http_settings.value["path"]
      port                                = backend_http_settings.value["port"]
      protocol                            = backend_http_settings.value["protocol"]
      probe_name                          = backend_http_settings.value["probe_name"] == "" ? null : backend_http_settings.value["probe_name"]
      host_name                           = (backend_http_settings.value["host_name"] == "" || backend_http_settings.value["pick_host_name_from_backend_address"] == true) ? null : backend_http_settings.value["host_name"]
      pick_host_name_from_backend_address = backend_http_settings.value["pick_host_name_from_backend_address"]
      request_timeout                     = backend_http_settings.value["request_timeout"]
      dynamic "authentication_certificate" {
        for_each = backend_http_settings.value["setup_authentication_certificate"] == true ? ["authentication_certificate"] : []
        content {
          name = backend_http_settings.value["authentication_certificate_name"]
        }
      }
      trusted_root_certificate_names = backend_http_settings.value["trusted_root_certificate_names"] == [] ? null : backend_http_settings.value["trusted_root_certificate_names"]
      dynamic "connection_draining" {
        for_each = backend_http_settings.value["connection_draining_enabled"] == true ? ["connection_draining"] : []
        content {
          enabled           = backend_http_settings.value["connection_draining_enabled"]
          drain_timeout_sec = backend_http_settings.value["drain_timeout_sec"]
        }
      }
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool
    content {
      name         = backend_address_pool.value["backend_address_pool_name"]
      fqdns        = backend_address_pool.value["backend_address_pool_fqdns"] == [] ? null : backend_address_pool.value["backend_address_pool_fqdns"]
      ip_addresses = backend_address_pool.value["backend_address_pool_ip_address"] == [] ? null : backend_address_pool.value["backend_address_pool_ip_address"]
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listner
    content {
      name                           = http_listener.value["name"]
      frontend_ip_configuration_name = http_listener.value["frontend_ip_configuration_name"]
      frontend_port_name             = http_listener.value["frontend_port_name"]
      host_name                      = (http_listener.value["host_name"] == "" || http_listener.value["host_names"] != []) ? null : http_listener.value["host_name"]
      host_names                     = (http_listener.value["host_name"] != "" || http_listener.value["host_names"] == []) ? null : http_listener.value["host_names"]
      protocol                       = http_listener.value["protocol"]
      require_sni                    = http_listener.value["require_sni"]
      ssl_certificate_name           = http_listener.value["ssl_certificate_name"] == "" ? null : http_listener.value["ssl_certificate_name"]
      firewall_policy_id             = http_listener.value["firewall_policy_id"] == "" ? null : http_listener.value["firewall_policy_id"]
      ssl_profile_name               = http_listener.value["ssl_profile_name"] == "" ? null : http_listener.value["ssl_profile_name"]
      dynamic "custom_error_configuration" {
        for_each = http_listener.value["setup_custom_error_configuration"] == true ? ["custom_error_configuration"] : []
        content {
          status_code           = http_listener.value["custom_error_configuration_status_code"]
          custom_error_page_url = http_listener.value["custom_error_configuration_custom_error_page_url"]
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule == null ? {} : var.request_routing_rule
    content {
      name                       = request_routing_rule.value["name"]
      rule_type                  = request_routing_rule.value["rule_type"]
      http_listener_name         = request_routing_rule.value["http_listener_name"]
      backend_http_settings_name = request_routing_rule.value["backend_http_settings_name"]
      priority                   = request_routing_rule.value["priority"]
      backend_address_pool_name  = request_routing_rule.value["backend_address_pool_name"]
    }
  }

  dynamic "trusted_client_certificate" {
    for_each = var.trusted_client_certificate == null ? {} : var.trusted_client_certificate
    content {
      name = trusted_client_certificate.value["name"]
      data = trusted_client_certificate.value["data"]
    }
  }

  dynamic "waf_configuration" {
    for_each = (var.sku_tier == "WAF_v2" || var.sku_tier == "WAF") ? var.waf_configuration : {}
    content {
      enabled          = waf_configuration.value["enabled"]
      firewall_mode    = waf_configuration.value["firewall_mode"]
      rule_set_type    = waf_configuration.value["rule_set_type"]
      rule_set_version = waf_configuration.value["rule_set_version"]
    }
  }

  lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      redirect_configuration,
      request_routing_rule,
      ssl_certificate,
      url_path_map,
      tags["ingress-for-aks-cluster-id"],
      tags["managed-by-k8s-ingress"]
    ]
  }

}