## Create a Resource Group for Storage
resource "azurerm_resource_group" "rg_storage" {
  location = "korea central"
  name     = "gac-krc-storage-rg"
}

# generate a random string (consisting of four characters)
resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}

## Azure Storage Accounts requires a globally unique names
## Create a File Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "stor${random_string.random.id}"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = azurerm_resource_group.rg_storage.location
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"
}

# Create storage Fileshare
resource "azurerm_storage_share" "FSShare" {
  name                 = "fslogix"
  storage_account_name = azurerm_storage_account.storage.name
  depends_on           = [azurerm_storage_account.storage]
}

## Azure built-in roles
data "azurerm_role_definition" "storage_role" {
  name = "Storage File Data SMB Share Contributor"
}
## Azure built- in assignment
resource "azurerm_role_assignment" "af_role" {
  scope              = azurerm_storage_account.storage.id
  role_definition_id = data.azurerm_role_definition.storage_role.id
  principal_id       = azuread_group.aad_group.id
}