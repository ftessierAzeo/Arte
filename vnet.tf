
resource "azurerm_virtual_network" "vnet-artedatalake" {
  name                = "vnet-artedatalake-${var.environnement}"
  location            = "${var.location}"
  address_space       = ["${var.address_space}"]
  resource_group_name = azurerm_resource_group.rg-datalake.name
  
  tags = {
    project = "datalake"
    env = "${var.environnement}"
  }
} 
 
 resource "azurerm_subnet" "snet-adb-artedatalake-pub" {
  name                 = "snet-adb-artedatalake-pub-${var.environnement}"
  virtual_network_name = "${azurerm_virtual_network.vnet-artedatalake.name}"
  resource_group_name  = azurerm_resource_group.rg-datalake.name
  address_prefix       = "${var.snet-adb-artedatalake-pub_prefix}"
  #enforce_private_link_endpoint_network_policies = true
}

 resource "azurerm_subnet" "snet-adb-artedatalake-prv" {
  name                 = "snet-adb-artedatalake-prv-${var.environnement}"
  virtual_network_name = "${azurerm_virtual_network.vnet-artedatalake.name}"
  resource_group_name = azurerm_resource_group.rg-datalake.name
  address_prefix       = "${var.snet-adb-artedatalake-prv_prefix}"
}

 resource "azurerm_subnet" "snet-adb-artedatalake" {
  name                 = "snet-adb-artedatalake-${var.environnement}"
  virtual_network_name = "${azurerm_virtual_network.vnet-artedatalake.name}"
  resource_group_name = azurerm_resource_group.rg-datalake.name
  address_prefix       = "${var.snet-adb-artedatalake_prefix}"
}