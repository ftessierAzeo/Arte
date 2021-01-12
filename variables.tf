

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "westeurope"
}

variable "environnement" {
  description = "The name for the environnement."
}

variable "virtual_network_name" {
  description = "The name for the virtual network."
  default     = "vnet-mmg-iaas-fr"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.67.0.0/16"
}

variable "snet-adb-artedatalake-pub_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.67.0.0/20"
}

variable "snet-adb-artedatalake-prv_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.67.16.0/20"
}

variable "snet-adb-artedatalake_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.67.32.0/24"
}





variable "destination_address_prefix" {
  type    = list
  default = ["10.128.0.0/16","10.30.0.0/16"]

  # Example ["10.0.3.0/32","10.0.3.128/32"] or ["VirtualNetwork"] 
}

variable "whitelist_ips" {

    type = list(string)
    default = ["199.83.128.0/21","198.143.32.0/19", "149.126.72.0/21","103.28.248.0/22", "45.64.64.0/22", "185.11.124.0/22", "192.230.64.0/18", "107.154.0.0/16", "45.60.0.0/16", "45.223.0.0/16", "2a02:e980::/29"]
}

