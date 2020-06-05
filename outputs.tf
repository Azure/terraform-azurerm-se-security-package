output "resource_group" {
  value = data.azurerm_resource_group.current
}

output "key_vault" {
  value = module.key_vault.key_vault
}
