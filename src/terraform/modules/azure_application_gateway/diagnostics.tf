resource "azurerm_monitor_diagnostic_setting" "application_gateway_diagnostics_settings" {
  count                      = length(var.log_analytics_workspaces)
  name                       = var.log_analytics_workspaces[count.index].workspace_name
  target_resource_id         = azurerm_application_gateway.application_gateway.id
  log_analytics_workspace_id = var.log_analytics_workspaces[count.index].workspace_id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}