output "subnet_id" {
  value = azurerm_subnet.public.id
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "public_ip_id" {
  value = azurerm_public_ip.web_ip.id
}

output "public_ip_address" {
  value = azurerm_public_ip.web_ip.ip_address
}
