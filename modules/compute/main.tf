# Network Interface
resource "azurerm_network_interface" "web_nic" {
  name                = "web-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id # From networking module
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id # From networking module
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "web_server" {
  name                = "softpro-web-vm"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B2ps_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-arm64"
    version   = "latest"
  }

  # Install Nginx
  custom_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
  )

  lifecycle {
    ignore_changes = [custom_data]
  }
}
