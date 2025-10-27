data "azurerm_virtual_network" "vnet" {
  name                 = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "akssubnet" {
  name                 = "akssubnet-practice-dev"
  virtual_network_name = "vnet-practice-dev"
  resource_group_name  = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "aks-identity-practice"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "practiceaks"

  kubernetes_version  = "1.30.0" # adjust if newer available

  default_node_pool {
    name                = "systempool"
    node_count          = 2
    vm_size             = "Standard_D2_v2"
    vnet_subnet_id      = data.azurerm_subnet.akssubnet.id
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  network_profile {
    network_plugin    = "azure"         # Azure CNI (pods get IPs from VNet)
    network_policy    = "azure"
    dns_service_ip    = "10.2.0.10"
    service_cidr      = "10.2.0.0/16"
    outbound_type     = "loadBalancer"
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "dev"
  }
}
