variable "rg_name" { type = string }
variable "location" { type = string }

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet provided by the networking module."
}

variable "public_ip_id" {
  type        = string
  description = "The ID of the Static Public IP provided by the networking module."
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH Public Key passed down from root/tfvars."
}
