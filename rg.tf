provider "azurerm" {
	subscription_id = "d4440581-2a15-4eaf-80bb-01be45869342"
	client_id		= "b79c90d8-43ce-4043-8e7e-51969fadc2c2"
	client_secret	= ".kN_PRXu4xQh50qcO~nZSHPf~0cs2iWC0h"
	tenant_id		= "20353388-0782-4405-b92c-678851050cc6"
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

