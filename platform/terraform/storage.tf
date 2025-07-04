resource "azurerm_storage_account" "storage_account" {
  name                     = local.storage_account_name
  location                 = azurerm_resource_group.resource_group.location
  resource_group_name      = azurerm_resource_group.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}