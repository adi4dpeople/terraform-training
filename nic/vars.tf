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

variable "subnet_id" {
  default = ""
}

variable "location" {
  default = ""
}
