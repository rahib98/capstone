# main.tf
provider "azurerm" {
  features {}
  subscription_id = "606e824b-aaf7-4b4e-9057-b459f6a4436d"
  client_id       = "4bde9b75-b164-48bf-955f-bd9c7f1781b3"
  client_secret   = var.client_secret  # Use the variable here
  tenant_id       = "104e77d4-81e7-4c16-ab44-935220bed6dd"
  skip_provider_registration = true
}

# Data source to fetch existing resource group details
data "azurerm_resource_group" "existing_rahib_rsg" {
  name = "rahib-RSG"
}

# Data source to fetch existing AKS cluster details
data "azurerm_kubernetes_cluster" "existing_rahib_aks" {
  name                = "rahibAKS"
  resource_group_name = data.azurerm_resource_group.existing_rahib_rsg.name

  depends_on = [
    data.azurerm_resource_group.existing_rahib_rsg
  ]
}

# Conditionally import existing AKS cluster if it exists, otherwise create new
resource "azurerm_kubernetes_cluster" "rahib_aks" {
  count = can(data.azurerm_kubernetes_cluster.existing_rahib_aks) ? 0 : 1  # Do not create if existing

  name                = "rahibAKS"
  location            = data.azurerm_resource_group.existing_rahib_rsg.location
  resource_group_name = data.azurerm_resource_group.existing_rahib_rsg.name
  dns_prefix          = "rahib-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Output the AKS cluster ID if it exists
output "existing_aks_cluster_id" {
  value = can(data.azurerm_kubernetes_cluster.existing_rahib_aks) ? data.azurerm_kubernetes_cluster.existing_rahib_aks.id : null
}
