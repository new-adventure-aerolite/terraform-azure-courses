resource "azurerm_kubernetes_cluster" "demo-cluster" {
  name                = "demo-cluster"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  dns_prefix          = "demo-cluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = azuread_service_principal.aks-demo.application_id
    client_secret = random_password.aks-demo-sp-password.result
  }
}

output "sp_client_id" {
  value = azuread_service_principal.aks-demo.id
}

output "sp_client_secret" {
  value = random_password.aks-demo-sp-password.result
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.demo-cluster.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.demo-cluster.kube_config_raw
}
