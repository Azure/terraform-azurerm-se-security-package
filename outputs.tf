output "resource_group" {
  value = data.azurerm_resource_group.current
}

output "key_vault" {
  value = module.key_vault.key_vault
}

output "private_endpoint" {
  value = azurerm_private_endpoint.private_endpoint
}
