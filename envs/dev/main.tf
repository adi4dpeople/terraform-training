module "devrg1" {
  source = "../../resource_group"
  rg_name = "${var.devrg_name}"
  location = "${var.dev_location}"
}

module "devvnet1" {
  source = "../../virtual_network"
  vnet_name = "${var.devvnet_name}"
  location  = "${var.dev_location}"
  resource_group_name = "${module.devrg1.name}"
  vnet_address_space  = "${var.dev_vnet_address_space}"
}

module "devsubnet1" {
  source = "../../subnets"
  subnet_name = "${var.dev_subnet_name}"
  resource_group_name = "${module.devrg1.name}"
  vnet_name  = "${module.devvnet1.name}"
  subnet_address_prefixes = ["${var.dev_subnet_address_prefixes[0]}"]
}

module "devsubnet2" {
  source = "../../subnets"
  subnet_name = "${var.dev_subnet_name2}"
  resource_group_name = "${module.devrg1.name}"
  vnet_name  = "${module.devvnet1.name}"
  subnet_address_prefixes = ["${var.dev_subnet_address_prefixes[1]}"]
}
