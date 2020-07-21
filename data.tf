data "azurerm_resource_group" "current" {
  name  = local.resource_group.name
  count = var.use_existing_resource_group ? 1 : 0
}
