variable "rg_name" { type = string }

variable "vm_id" {
  type        = string
  description = "The resource ID of the Virtual Machine to be monitored by Metric Alerts."
}

variable "email_address" {
  type        = string
  description = "The email receiver for the Action Group notification system."
}
