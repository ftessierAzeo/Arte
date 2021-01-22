provider "azurerm" {
/* 	subscription_id = "${var.AzureSubscriptionId}"
	client_id	= "${var.AzureClientId}"
	client_secret	= "${var.AzureClientSecret}"
	tenant_id	= "${var.AzureTenantId}" */
  version = "=2.20.0"
    features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }	
}

resource "azurerm_resource_group" "rg-datalake" {
  name     = "rg-datalake-${var.environnement}"
  location = "${var.location}"
    tags = {
    project = "datalake"
    env = "${var.environnement}"
  }
}

