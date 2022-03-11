# We will create a new VNet for our session hosts and peer it to our AD VNet.
# 세션 호스트에 대한 새 VNet 생성 및 AD를 VNet에 피어링
#배포할 구성요소
# 1. 세선 호스트
# 2. 가상 네트워크
# 3. 세션 호스트 서브넷
# 4. NSG
# 5. NSG – 서브넷 연결
# 6. Active Directory VNet에 대한 VNet 피어링

#데이터를 이용하여 기존 AD VNet의 속성 검색 후 새 피어링에 ID 전달

#Create Azure VNet 생성
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-VNet"
  address_space       = var.vnet_range
  dns_servers         = var.dns_servers
  location            = var.deploy_location
  resource_group_name = var.rg_name
  depends_on          = [azurerm_resource_group.rg]
}
#Create Subnet 생성
resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_range
  depends_on           = [azurerm_resource_group.rg]
}
#Create NSG 
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-NSG"
  location            = var.deploy_location
  resource_group_name = var.rg_name
  security_rule {
    name                       = "HTTPS"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [azurerm_resource_group.rg]
}
$
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

data "azurerm_virtual_network" "ad_vnet_data" {
  name                = var.ad_vnet
  resource_group_name = var.ad_rg
}

resource "azurerm_virtual_network_peering" "peer1" {
  name                      = "peer_avd_ad"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.ad_vnet_data.id
}
resource "azurerm_virtual_network_peering" "peer2" {
  name                      = "peer_ad_avd"
  resource_group_name       = var.ad_rg
  virtual_network_name      = var.ad_vnet
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}
}