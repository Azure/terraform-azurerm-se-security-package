#Required Variables
variable "key_vault_private_endpoint_subnet_id" {
  type        = string
  description = "The subnet to add the Key Vaults Private Endpoint to."
}

variable "use_existing_resource_group" {
  type        = string
  description = "Boolean flag to determine whether or not to deploy services to an existing Azure Resource Group. When false specify a resource_group_location, when true specify the resource_group_name."
  default     = false
}

#Optional Variables
variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group to deploy the security services into."
  default     = ""
}

variable "resource_group_location" {
  type        = string
  description = "The location to create the security Azure Resources."
  default     = ""
}

variable "prefix" {
  type        = list(string)
  description = "A naming prefix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "suffix" {
  type        = list(string)
  description = "A naming suffix to be used in the creation of unique names for Azure resources."
  default     = []
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IP Address CIDR ranges to allow access to the Key Vault."
  default     = []
}

variable "permitted_virtual_network_subnet_ids" {
  type        = list(string)
  description = "List of the Subnet IDs to allow to access to the Key Vault."
  default     = []
}

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "The Name of the SKU used for this Key Vault. Either 'standard' or 'premium'"
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Enable Key Vault to be used in deployment"
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Enable Key Vault to be used in disk encryption"
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Enable Key Vault to be used in ARM templates deployments"
  default     = false
}