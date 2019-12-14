resource "azurerm_network_interface" "nic" {
  count               = "${var.vm_instances_count}"
  name                = "${var.vm_name}${format(var.count_format, var.count_offset + count.index + 1)}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "${var.vm_name}${format(var.count_format, var.count_offset + count.index + 1)}-ipconfig"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }
}
