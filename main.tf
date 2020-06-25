provider "azurerm" {
  version = "~>2.0"
  features {}
}

locals {
  prefix              = var.prefix
  suffix              = concat(["sec"], var.suffix)
  resource_group_name = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.security_group[0].name
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
  suffix = local.suffix
  prefix = local.prefix
}

resource "azurerm_resource_group" "security_group" {
  name     = module.naming.resource_group.name
  location = var.resource_group_location
  count    = var.use_existing_resource_group ? 0 : 1
}

module "key_vault" {
  source                               = "git::https://github.com/Azure/terraform-azurerm-sec-key-vault"
  resource_group_name                  = data.azurerm_resource_group.current.name
  prefix                               = local.prefix
  suffix                               = local.suffix
  allowed_ip_ranges                    = var.allowed_ip_ranges
  permitted_virtual_network_subnet_ids = var.permitted_virtual_network_subnet_ids
  sku_name                             = var.sku_name
  enabled_for_deployment               = var.enabled_for_deployment
  enabled_for_disk_encryption          = var.enabled_for_disk_encryption
  enabled_for_template_deployment      = var.enabled_for_template_deployment

  module_depends_on = [null_resource.module_depends_on]
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = module.naming.private_endpoint.name
  resource_group_name = data.azurerm_resource_group.current.name
  location            = data.azurerm_resource_group.current.location
  subnet_id           = var.key_vault_private_endpoint_subnet_id

  private_service_connection {
    name                           = module.naming.private_service_connection.name
    subresource_names              = ["vault"]
    private_connection_resource_id = module.key_vault.key_vault.id
    is_manual_connection           = false
  }

  depends_on = [null_resource.module_depends_on]
}

resource "null_resource" "module_depends_on" {
  triggers = {
    value = "${length(var.module_depends_on)}"
  }
}