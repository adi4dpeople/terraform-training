provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  # version = "=1.36.0"

  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.location}"

  tags = {
    environment = "Training"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "trainingvnet"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["10.0.0.0/16"]
  }

  resource "azurerm_subnet" "subnet" {
    name                 = "trainingsubnet01"
    resource_group_name  = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    address_prefix       = "10.0.1.0/24"
  }

  resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "trainigvmnic${var.count_offset}${count.index + 1}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "trainigvmipconfig01"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "trainig"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count                 = 2
  name                  = "trainigvm${var.count_offset}${count.index + 1}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  vm_size               = "Standard_D1"

  # Uncomment this line to delete the OS disk automatically when deletingB4ms
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "trainingvm${var.count_offset}${count.index + 1}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "trainingvm01"
    admin_username = "trainingadmin"
    admin_password = "Trainig@123"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Training"
  }
}
