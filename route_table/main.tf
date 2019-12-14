resource "azurerm_route_table" "rt" {
  name                = "${var.rt_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_route" "udrnh" {
  name                   = "${var.udr_name}"
  resource_group_name    = "${var.resource_group_name}"
  route_table_name       = "${azurerm_route_table.rt.name}"
  address_prefix         = "${var.udr_address_prefix}"
  next_hop_type          = "${var.udr_next_hop_type}"
  next_hop_in_ip_address = "${var.udr_next_hop_in_ip_address}"
}
