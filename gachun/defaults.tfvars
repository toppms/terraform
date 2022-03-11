deploy_location      = "korea central"
rg_name              = "gac-krc-rg"
prefix               = "gac-krc"
local_admin_username = "rootadmin"
local_admin_password = "eogksalsrnr1!"
vnet_range           = ["10.1.0.0/16"]
subnet_range         = ["10.1.0.0/24"]
dns_servers          = ["10.0.1.4", "168.63.129.16"]
aad_group_name       = "AVDUsers"
domain_name          = "infra.local"
domain_user_upn      = "rootadmin"     # do not include domain name as this is appended
domain_password      = "eogksalsrnr1!"
ad_vnet              = "gac-krc-vnet"
ad_rg                = "gac-krc-infra-rg"
avd_users = [
  "avduser01@infra.local",
  "avduser01@infra.local"
]