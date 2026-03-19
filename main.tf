resource "azurerm_resource_group" "main" {
  name     = "rg-softpro-project"
  location = "centralus"
}

module "networking" {
  source    = "./modules/networking"
  rg_name   = azurerm_resource_group.main.name
  location  = azurerm_resource_group.main.location
  vnet_name = "vnet-prod"
}

module "compute" {
  source         = "./modules/compute"
  rg_name        = azurerm_resource_group.main.name
  location       = azurerm_resource_group.main.location
  subnet_id      = module.networking.subnet_id
  public_ip_id   = module.networking.public_ip_id
  ssh_public_key = var.ssh_public_key
}

module "monitoring" {
  source        = "./modules/monitoring"
  rg_name       = azurerm_resource_group.main.name
  vm_id         = module.compute.vm_id
  email_address = var.email_address
}

# --- Networking Module Moves ---
moved {
  from = azurerm_virtual_network.vnet
  to   = module.networking.azurerm_virtual_network.vnet
}

moved {
  from = azurerm_subnet.public
  to   = module.networking.azurerm_subnet.public
}

moved {
  from = azurerm_network_security_group.nsg
  to   = module.networking.azurerm_network_security_group.nsg
}

moved {
  from = azurerm_public_ip.web_ip
  to   = module.networking.azurerm_public_ip.web_ip
}

moved {
  from = azurerm_subnet_network_security_group_association.nsg-association
  to   = module.networking.azurerm_subnet_network_security_group_association.nsg-association
}

# --- Compute Module Moves ---
moved {
  from = azurerm_network_interface.web_nic
  to   = module.compute.azurerm_network_interface.web_nic
}

moved {
  from = azurerm_linux_virtual_machine.web_server
  to   = module.compute.azurerm_linux_virtual_machine.web_server
}

# --- Monitoring Module Moves ---
moved {
  from = azurerm_monitor_action_group.main
  to   = module.monitoring.azurerm_monitor_action_group.main
}

moved {
  from = azurerm_monitor_metric_alert.cpu_alert
  to   = module.monitoring.azurerm_monitor_metric_alert.cpu_alert
}

moved {
  from = azurerm_monitor_metric_alert.vm_availability
  to   = module.monitoring.azurerm_monitor_metric_alert.vm_availability
}
