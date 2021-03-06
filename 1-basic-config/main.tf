###########################
# CONFIGURATION
###########################

terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 2.0"

        }
    }
}

###########################
# VARIABLES
###########################

variable "region" {
    type = string
    description = "Region in Azure"
    default = "eastus"
}

variable "prefix" {
    type = string
    description = "prefix for naming"
    default = "dnl"
}

###########################
# PROVIDERS
###########################

provider "azurerm" {
    features {}
}

###########################
# DATA SOURCES
###########################

locals {
    name = "${var.prefix}-demo"
}

###########################
# RESOURCES
###########################

resource "azurerm_resource_group" "vnet" {
  name     = local.name
  location = var.region
}

module "network" {
  source              = "Azure/network/azurerm"
  version = "3.1.1"
  resource_group_name = azurerm_resource_group.vnet.name
  vnet_name = local.name
  address_space       = "10.0.0.0/16"
  #subnet_prefixes     = ["10.0.1.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  #subnet_names        = ["SubnetA", "subnetB", "subnetC"]
  #subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  #subnet_names        = ["subnet1", "subnet2", "subnet3"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3", "subnet4", "subnet5"]

  tags = {
    environment = "dev"
    costcenter  = "it"  
    project     = "Secret"
    owner       = "El Capitan America"
    department  = "Accounting"  
    location    = "USA"
  }

  depends_on = [azurerm_resource_group.vnet]
}

