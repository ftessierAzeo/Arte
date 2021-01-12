
resource "azurerm_storage_account" "artedatalake" {
  name                     = "artedatalake${var.environnement}"
  resource_group_name      = azurerm_resource_group.rg-datalake.name
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  allow_blob_public_access = "false" 

  tags = {
    project = "datalake"
    env = "${var.environnement}"
  }

}