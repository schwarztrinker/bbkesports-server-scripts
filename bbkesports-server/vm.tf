<<<<<<< Updated upstream
resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault" "main" {
  name                        = "${local.global_prefix}-kv"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  value        = random_password.vm_password.result
  key_vault_id = azurerm_key_vault.main.id
}


resource "azurerm_virtual_network" "vm" {
  name                = "${local.global_prefix}-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "VirtualMachineSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vm.name
  address_prefixes     = ["10.0.0.0/25"]
}

resource "azurerm_network_interface" "vm" {
  name                = "${local.global_prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

}


resource "azurerm_public_ip" "main" {
  name                = "${local.global_prefix}-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${local.global_prefix}-vm"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B4s"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  admin_password = random_password.vm_password.result

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = data.cloudinit_config.config.rendered
}


# Network Security Group
# Network Security Group allowing all inbound traffic
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${local.global_prefix}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Allow all inbound TCP traffic
  security_rule {
    name                       = "Allow-All-TCP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow all inbound UDP traffic
  security_rule {
    name                       = "Allow-All-UDP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with the Network Interface
resource "azurerm_network_interface_security_group_association" "vm_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}


data "cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("${path.module}/scripts/cloud-config.yaml")
  }
}
=======
resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault" "main" {
  name                        = "${local.global_prefix}-kv"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  value        = random_password.vm_password.result
  key_vault_id = azurerm_key_vault.main.id
}


resource "azurerm_virtual_network" "vm" {
  name                = "${local.global_prefix}-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "VirtualMachineSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vm.name
  address_prefixes     = ["10.0.0.0/25"]
}

resource "azurerm_network_interface" "vm" {
  name                = "${local.global_prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

}


resource "azurerm_public_ip" "main" {
  name                = "${local.global_prefix}-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${local.global_prefix}-vm"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B2ms"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  admin_password = random_password.vm_password.result

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = data.cloudinit_config.config.rendered
}


data "cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"

    content = file("${path.module}/scripts/cloud-config.yaml")
  }
}
>>>>>>> Stashed changes
