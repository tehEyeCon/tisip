variable "subscription_id" {
  description = "Azure subscription to deploy into. If omitted, provider will use CLI default subscription."
  type        = string
  default     = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70"
}

variable "tenant_id" {
  description = "The Tenant ID for the Azure provider"
  type        = string
  default     = "6980af2f-acfc-4513-ac50-552bcfdb01a0"
  
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}