resource "azurerm_network_security_group" "nsg_databricks" {
  name                  = "nsg_databricks" 
  resource_group_name      = azurerm_resource_group.rg-datalake.name
  location                 = "${var.location}"
    tags = {
    project = "datalake"
    env = "${var.environnement}"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_databricks_prv" {
  subnet_id                 = azurerm_subnet.snet-adb-artedatalake-prv.id
  network_security_group_id = azurerm_network_security_group.nsg_databricks.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_databricks_pub" {
  subnet_id                 = azurerm_subnet.snet-adb-artedatalake-pub.id
  network_security_group_id = azurerm_network_security_group.nsg_databricks.id
}


#### Inbound #####
resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-worker-to-worker-inbound" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for worker nodes communication within a cluster."
}

resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-ssh" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-ssh"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "AzureDatabricks"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for Databricks control plane management of worker nodes."
}

resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-proxy" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-proxy"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5557"
  source_address_prefix       = "AzureDatabricks"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for Databricks control plane management of worker nodes."
}


#### Outbound #####
resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-worker-to-databricks-webapp" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-databricks-webapp"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureDatabricks"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for worker nodes communication within a cluster."
}


resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-worker-to-sql" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-sql"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "Sql"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for workers communication with Azure SQL services."
}

resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-worker-to-storage" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-storage"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "Storage"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for workers communication with Azure Storage services."
}

resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-worker-to-worker-outbound" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-outbound"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for worker nodes communication within a cluster."
}

resource "azurerm_network_security_rule" "Databricks-workspaces_UseOnly_databricks-worker-to-eventhub" {
  name                        = "Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-eventhub"
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "9093"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "EventHub"
  resource_group_name         = azurerm_resource_group.rg-datalake.name
  network_security_group_name = azurerm_network_security_group.nsg_databricks.name
  description                 = "Required for worker communication with Azure Eventhub services."
}