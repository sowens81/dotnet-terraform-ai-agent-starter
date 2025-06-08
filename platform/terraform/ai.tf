resource "azurerm_ai_services" "ai_services" {
  name                = local.ai_services_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "S0"
}

resource "azurerm_ai_foundry" "ai_foundry" {
  name                = local.ai_foundry_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  storage_account_id  = azurerm_storage_account.storage_account.id
  key_vault_id        = azurerm_key_vault.key_vault.id
  tags                = local.tags

  primary_user_assigned_identity = azurerm_user_assigned_identity.user_assigned_identity.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
  }
}

resource "azurerm_ai_foundry_project" "ai_foundry_project" {
  name               = var.project_name
  location           = azurerm_ai_foundry.ai_foundry.location
  ai_services_hub_id = azurerm_ai_foundry.ai_foundry.id
  tags               = local.tags
}