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

variable "node_count" {
  description = "Nombre de nœuds"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "Taille des nœuds"
  type        = string
  default     = "Standard_B2s"
}
