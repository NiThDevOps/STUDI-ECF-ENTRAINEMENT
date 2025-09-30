# 1) Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# 2) Suffixe stable (pour générer un nom ACR unique si non fourni)
resource "random_id" "acr_suffix" {
  byte_length = 2
  keepers = {
    rg = var.rg_name
  }
}

# 3) Nom ACR effectif
locals {
  acr_name_effectif = (
    var.acr_name != null && trim(var.acr_name) != "" ?
    lower(var.acr_name) :
    lower("acrecdemo${random_id.acr_suffix.dec}")
  )
}

# 4) Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = local.acr_name_effectif
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

# 5) AKS (cluster managé)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name                 = "nodepool1"
    vm_size              = var.node_vm_size
    node_count           = var.node_count
    orchestrator_version = null
    type                 = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  # Réseau simple (plugin Azure + LB standard)
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.2.0.0/24"
    dns_service_ip    = "10.2.0.10"
  }


  # Crée d'abord l'ACR (ordre logique)
  depends_on = [azurerm_container_registry.acr]
}

# 6) Donner au kubelet du cluster le droit de pull sur l’ACR
resource "azurerm_role_assignment" "aks_pull_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
