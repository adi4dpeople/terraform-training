module "devrg1" {
  source   = "../../resource_group"
  rg_name  = "${var.devrg_name}"
  location = "${var.dev_location}"
}

module "devvnet1" {
  source              = "../../virtual_network"
  vnet_name           = "${var.devvnet_name}"
  location            = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  vnet_address_space  = ["${var.dev_vnet_address_space}"]
}

module "devsubnet1" {
  source                  = "../../subnets"
  subnet_name             = "${var.dev_subnet_name}"
  resource_group_name     = "${module.devrg1.name}"
  vnet_name               = "${module.devvnet1.name}"
  subnet_address_prefixes = ["${var.dev_subnet_address_prefixes[0]}"]
  route_table_id          = "${module.fwrt.id}"
}

module "devsubnet2" {
  source                  = "../../subnets"
  subnet_name             = "${var.dev_subnet_name2}"
  resource_group_name     = "${module.devrg1.name}"
  vnet_name               = "${module.devvnet1.name}"
  subnet_address_prefixes = ["${var.dev_subnet_address_prefixes[1]}"]
}

module "nic" {
  source              = "../../nic"
  vm_name             = "${var.vm_name}"
  location            = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  vm_instances_count  = "${var.vm_instances_count}"
  subnet_id           = "${module.devsubnet1.id[0]}"
}

module "nic1" {
  source              = "../../nic"
  vm_name             = "${var.vm_name1}"
  location            = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  vm_instances_count  = "${var.vm_instances_count1}"
  subnet_id           = "${module.devsubnet2.id[0]}"
}

module "vm" {
  source              = "../../virtual_machine"
  vm_name             = "${var.vm_name}"
  location            = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  vm_instances_count  = "${var.vm_instances_count}"
  vm_size             = "${var.vm_size}"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  nic                 = ["${module.nic.id}"]
  disk_size_gb        = "${var.disk_size_gb}"
  os_disk_type        = "${var.os_disk_type}"
  image_publisher     = "${var.image_publisher}"
  image_offer         = "${var.image_offer}"
  image_sku           = "${var.image_sku}"
  image_version       = "${var.image_version}"
}

module "vm1" {
  source              = "../../virtual_machine"
  vm_name             = "${var.vm_name1}"
  location            = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  vm_instances_count  = "${var.vm_instances_count1}"
  vm_size             = "${var.vm_size}"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  nic                 = ["${module.nic1.id}"]
  disk_size_gb        = "${var.disk_size_gb}"
  os_disk_type        = "${var.os_disk_type}"
  image_publisher     = "${var.image_publisher}"
  image_offer         = "${var.image_offer}"
  image_sku           = "${var.image_sku}"
  image_version       = "${var.image_version}"
}

module "fwrt" {
  source = "../../route_table"
  rt_name = "${var.rt_name}"
  location = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  udr_name = "${var.udr_name}"
  udr_address_prefix = "${var.udr_address_prefix}"
  udr_next_hop_type = "${var.udr_next_hop_type}"
  udr_next_hop_in_ip_address = "${var.udr_next_hop_in_ip_address}"
}

module "rt" {
  source = "../../route_table"
  rt_name = "${var.rt_name1}"
  location = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  udr_name = "${var.udr_name}"
  udr_address_prefix = "${var.udr_address_prefix}"
  udr_next_hop_type = "${var.udr_next_hop_type}"
  udr_next_hop_in_ip_address = "${var.udr_next_hop_in_ip_address}"
}
