#AVD 구성요소
#Resource Group
#Workspace
#Hostpool
#Hostpool registration expiration date (create a time_rotating resource)
#Application Group (our DAG)
#Application Group association to workspace


#Create Resource Group
resource "azurerm_resource_group" "avd_rg" {
  name     = var.rg_name
  location = var.deploy_location
}

#Create AVD Host Pool - 풀링된 호스트 풀 유형
resource "azurerm_virtual_desktop_host_pool" "pooledbreadthfirst" {
  name                = "pooledbreadthfirst"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  type               = "Pooled"
  #validate_environment = true
  load_balancer_type = "BreadthFirst"
}
#Create AVD Host Pool - 풀링된 개인 유형
resource "azurerm_virtual_desktop_host_pool" "personalautomatic" {
  name                = "personalautomatic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  type                             = "Personal"
  #validate_environment = true
  personal_desktop_assignment_type = "Automatic"
}
#Host pool에 대한 등록 정보 관리
resource "azurerm_virtual_desktop_host_pool_registration_info" "example" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.example.id
  expiration_date = "2022-01-01T23:40:52Z"
}

#Create Application Group - RemoteApp
resource "azurerm_virtual_desktop_application_group" "remoteapp" {
  name                = "acctag"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type          = "RemoteApp"
  host_pool_id  = azurerm_virtual_desktop_host_pool.pooledbreadthfirst.id
  friendly_name = "TestAppGroup"
  description   = "Acceptance Test: An application group"
}
#Create Application Group - 데스크톱
resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = "appgroupdesktop"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.personalautomatic.id
  friendly_name = "TestAppGroup"
  description   = "Acceptance Test: An application group"
}
#Create Workspace 
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.workspace
  location            = var.deploy_location
  resource_group_name = azurerm_resource_group.rg.name

  friendly_name = "${var.prefix}-Workspace"
  description   = "${var.prefix}-Workspace"
}
#Create AVD 앱 그룹 할당
resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.remoteapp.id
}

