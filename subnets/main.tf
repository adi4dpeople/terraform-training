resource "azurerm_subnet" "subnet" {
count                = "${var.subnet_count}"
name                 = "${var.subnet_name}"
resource_group_name  = "${var.resource_group_name}"
virtual_network_name = "${var.vnet_name}"
address_prefix       = "${element(var.subnet_address_prefixes,count.index)}"
}
