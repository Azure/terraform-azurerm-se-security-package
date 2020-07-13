output "resource_group" {
  value = module.security.resource_group
}

output "key_vault" {
  value = module.security.key_vault
}

output "private_endpoint" {
  value = module.security.private_endpoint
}

output "private_dns_zone" {
  value = module.security.private_dns_zone
}
