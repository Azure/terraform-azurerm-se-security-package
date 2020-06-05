provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "random_string" "resource_group_name_prefix" {
  length    = 5
  special   = false
  lower     = true
  min_lower = 5
}

resource "azurerm_resource_group" "test_group" {
  name     = "rg-security-group-minimal-test-network-${random_string.resource_group_name_prefix.result}"
  location = "uksouth"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-security-group"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.test_group.location
  resource_group_name = azurerm_resource_group.test_group.name
}

resource "azurerm_subnet" "subnet" {
  name                                           = "snet-security-group"
  resource_group_name                            = azurerm_resource_group.test_group.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefix                                 = "10.0.2.0/24"
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.KeyVault"]
}

module "security" {
  source                               = "../"
  key_vault_private_endpoint_subnet_id = azurerm_subnet.subnet.id
  use_existing_resource_group          = false
  resource_group_location              = azurerm_resource_group.test_group.location
}










