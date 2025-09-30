terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # tu peux figer une 3.x connue si tu veux : "~> 3.116"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {} # <- obligatoire, même vide
  # Par défaut, le provider utilisera ta session Azure CLI (az login)
}
