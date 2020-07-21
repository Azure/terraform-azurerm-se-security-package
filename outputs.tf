output "resource_group" {
  value = local.resource_group
}

output "key_vault" {
  value = module.key_vault.key_vault
}

output "private_endpoint" {
  value = azurerm_private_endpoint.private_endpoint
}

output "private_dns_zone" {
  value = azurerm_private_dns_zone.key_vault_dns_zone
}
