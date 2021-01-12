
resource "azurerm_databricks_workspace" "databricks" {
  name                = "databricks-${var.environnement}"
  resource_group_name = azurerm_resource_group.rg-datalake.name
  location            = "${var.location}"
  sku                 = "standard"

  custom_parameters {
    public_subnet_name  =  azurerm_subnet.snet-adb-artedatalake-pub.name
    private_subnet_name =  azurerm_subnet.snet-adb-artedatalake-prv.name
  }
  tags = {
    project = "datalake"
    env = "${var.environnement}"
  }
}
