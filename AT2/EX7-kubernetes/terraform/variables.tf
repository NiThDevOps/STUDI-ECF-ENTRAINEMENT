variable "location" {
  description = "Région Azure"
  type        = string
  default     = "westeurope"
}

variable "rg_name" {
  description = "Nom du Resource Group"
  type        = string
  default     = "rg-ecf"
}

variable "aks_name" {
  description = "Nom du cluster AKS"
  type        = string
  default     = "aks-ecf"
}

variable "node_vm_size" {
  description = "Taille de VM du nodepool"
  type        = string
  default     = "Standard_B2s"
}

variable "node_count" {
  description = "Nombre de nœuds"
  type        = number
  default     = 1
}

# Laisse null pour générer automatiquement un nom unique (acrecdemo<digits>)
variable "acr_name" {
  description = "Nom de l'ACR (unique global)"
  type        = string
  default     = null
}
