resource "azurerm_virtual_machine" "vm" {
  count                 = "${var.vm_instances_count}"
  name                  = "${var.vm_name}${format(var.count_format, var.count_offset + count.index + 1)}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${element(var.nic, count.index)}"]
  vm_size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }
  storage_os_disk {
    name              = "${var.vm_name}${format(var.count_format, var.count_offset + count.index + 1)}-OSDISK"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.os_disk_type}"
  }
  # Optional data disks
  storage_data_disk {
    name            = "${element(azurerm_managed_disk.md.*.name, count.index)}"
    managed_disk_id = "${element(azurerm_managed_disk.md.*.id, count.index)}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${element(azurerm_managed_disk.md.*.disk_size_gb, count.index)}"
  }
  os_profile {
    computer_name  = "${var.vm_name}${format(var.count_format, var.count_offset + count.index + 1)}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
resource "azurerm_managed_disk" "md" {
  count                = "${var.vm_instances_count}"
  name                 = "${var.vm_name}${format(var.count_format, var.count_offset + count.index + 1)}-DATADISK"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  storage_account_type = "${var.data_disk_type}"
  create_option        = "Empty"
  disk_size_gb         = "${var.disk_size_gb}"
}
