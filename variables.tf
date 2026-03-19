variable "ssh_public_key" {
  type        = string
  description = "The OpenSSH public key used for the VM adminuser. Found in ~/.ssh/id_rsa.pub."
}

variable "email_address" {
  type        = string
  default     = "reese.herron13@gmail.com"
  description = "The destination email for Azure Monitor alerts. Used in the SRE Action Group."
}
