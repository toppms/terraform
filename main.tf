provider "azurerm" {
  features {}
}
#Create Resource Group
resource "azurerm_resource_group" "example" {
  name     = "rg-example-virtualdesktop"
  location = "West Europe"
}
#Create AVD Host Pool - 풀링된 호스트 풀 유형
resource "azurerm_virtual_desktop_host_pool" "pooledbreadthfirst" {
  name                = "pooledbreadthfirst"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type               = "Pooled"
  load_balancer_type = "BreadthFirst"
}
#Create AVD Host Pool - 풀링된 개인 유형
resource "azurerm_virtual_desktop_host_pool" "personalautomatic" {
  name                = "personalautomatic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type                             = "Personal"
  personal_desktop_assignment_type = "Automatic"
}

resource "azurerm_virtual_desktop_application_group" "remoteapp" {
  name                = "acctag"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type          = "RemoteApp"
  host_pool_id  = azurerm_virtual_desktop_host_pool.pooledbreadthfirst.id
  friendly_name = "TestAppGroup"
  description   = "Acceptance Test: An application group"
}

resource "azurerm_virtual_desktop_application" "chrome" {
  name                         = "googlechrome"
  application_group_id         = azurerm_virtual_desktop_application_group.remoteapp.id
  friendly_name                = "Google Chrome"
  description                  = "Chromium based web browser"
  path                         = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
  command_line_argument_policy = "DoNotAllow"
  command_line_arguments       = "--incognito"
  show_in_portal               = false
  icon_path                    = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
  icon_index                   = 0
}