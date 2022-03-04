variable "deploy_location" {
    type = string
    default = "Korea Central"
    description = "location"
}
variable "resource_prefix"{
    type = string
    default = "gac-krc"
    description = "prefix"
}
variable "resource_group_name" {
    type = string
    default = "gac-krc-avd-rg"
}
variable "host_pool_name" {
    type = string
    default = "hostpool"
    description = "hostpool"
}