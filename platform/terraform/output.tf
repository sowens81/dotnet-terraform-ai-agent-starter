output "resource_group_id" {
  value = azurerm_resource_group.resource_group.id

}
output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.user_assigned_identity.id
}

output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}

output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}

# output "ai_foundry_id" {
#   value = azurerm_ai_foundry.ai_foundry.id
# }

# output "ai_foundry_project_id" {
#   value = azurerm_ai_foundry_project.ai_foundry_project.id
# }