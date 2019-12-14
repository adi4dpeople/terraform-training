variable "location" {
  default     = ""
  description = "Geographic location of the virtual network"
}

variable "vm_instances_count" {
  default     = ""
  description = "Number of VMs to provision."
}

variable "count_offset" {
  default     = 0
  description = "Start server numbering from this value. If you set it to 100, servers will be numbered -101, 102,..."
}

variable "count_format" {
  default     = "%02d"
  description = "Server numbering format (-01, -02, etc.) in printf format"
}

variable "resource_group_name" {
  default     = ""
  description = "Resource group name"
}

variable "vm_name" {
  default     = ""
  description = "Name of the Virtual Machine"
}

variable "vm_size" {
  default     = ""
  description = "Size of the VM. See https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-sizes/"
}

# Images to use
# See https://github.com/Azure/azure-quickstart-templates/blob/master/101-vm-simple-windows/azuredeploy.json
variable "image_publisher" {
  default     = ""
  description = "OS Image publisher"
}

variable "image_offer" {
  default     = ""
  description = "OS Image offer"
}

variable "image_sku" {
  default     = ""
  description = "OS Image sku"
}

variable "image_version" {
  default     = ""
  description = "OS Image version"
}

variable "os_disk_name" {
  default     = "osdisk"
  description = "Base name of the OS disk"
}

variable "os_disk_type" {
  default     = "Standard_LRS"
  description = "OS Disk Type"
}

variable "admin_username" {
  default     = ""
  description = "Admin account"
}

variable "admin_password" {
  default     = ""
  description = "Admin account password (required)"
}

variable "data_disk_type" {
  default     = "Standard_LRS"
  description = "Data Disk Type"
}

variable "nic" {
  default     = [""]
  description = "Network Interface ID"
}

variable "disk_size_gb" {
  default = ""
}
