variable "rg_name" {
  type        = string
  description = "The name of the Resource Group inherited from the root orchestrator."
}

variable "location" {
  type        = string
  description = "The Azure region (e.g., centralus) where all networking resources will reside."
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network. Standardized as vnet-prod."
}
