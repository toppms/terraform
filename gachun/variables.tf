variable "resource_group_name" {
    type = string
    default = "gac-krc-avd-rg"
}
variable "deploy_location" {
    type = string
    default = "Korea Central"
    description = "location"
}
variable "host_pool_name" {
    type = string
    default = "hostpool"
}
variable "ad_vnet" {
    type = string
    default = "hostpool"
}
variable "dns_servers" {
    type = string
    default = "hostpool"
}
variable "vnet_range" {
    type = string
    default = "hostpool"
    description = "hostpool"
}
variable "subnet_range" {
    type = string
    default = "hostpool"
}
variable "avd_users" {
    type = string
    default = "hostpool"
    description = "hostpool"
}
variable "aad_group_name" {
    type = string
    default = "hostpool"
    description = "hostpool"
}
variable "rdsh_count" {
    type = string
    default = "2"
}
variable "resource_prefix"{
    type = string
    default = "gac-krc"
}
variable "domain_name" {
    type = string
    default = "hostpool"
}
variable "domain_user_upn" {
    type = string
    default = "hostpool"
}
variable "domain_password" {
    type = string
    default = "hostpool"
}
variable "vm_size" {
    type = string
    default = "Standard_DS2_v2"
}
variable "ou_path" {
    type = string
    default = "Standard_DS2_v2"
}
variable "local_admin_username" {
    type = string
    default = "Standard_DS2_v2"
}
variable "netapp_acct_name" {
    type = string
    default = "AVD_NetApp"
}
variable "netapp_pool_name" {
    type = string
    default = "AVD_NetApp_pool"
}
variable "netappvolumename" {
    type = string
    default = "AVD_NetApp_volume"
}
variable "netapp_smb_name" {
    type = string
    default = "AVDNetApp"
}
variable "netapp_volume_path" {
    type = string
    default = "AVDNetAppVolume"
}
variable "netapp_subnet_name" {
    type = string
    default = "NetAppSubnet"
}
variable "netapp_address" {
    type = string
    default = ""
}
