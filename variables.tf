variable "resource_group_name" {
  description = "Default resource group name that the database will be created in."
}

variable "location" {
  description = "The location/region where the database and server are created. Changing this forces a new resource to be created."
}

variable "server_name" {
    description = ""
}

variable "sku_name" {
    description = ""
    default = "B_Gen4_2"
}
variable "sku_capacity" {
    description = ""
    default = "2"
}
variable "sku_tier" {
    description = ""
    default = "Basic"
}
variable "sku_family" {
    description = ""
    default = "Gen4"
}

variable "storage_mb" {
    description = ""
    default = 5120
}
variable "backup_retention_days" {
    description = ""
    default = 7
}
variable "geo_redundant_backup" {
    description = ""
    default = "Disabled"
}

variable "administrator_login" {
    description = ""
}

variable "administrator_password" {
    description = ""
}

variable "version" {
    description = "The version for the database server. Valid values are: <values>."
    default = "9.5"
}

variable "ssl_enforcement" {
    description = ""
    default = "Enabled"
}

variable "db_names" {
    description = ""
    default = []
}

variable "db_charset" {
    description = ""
    default = "UTF8"
}

variable "db_collation" {
    description = ""
    default = "English_United States.1252"
}

variable "firewall_prefix"{ 
    description = ""
    default = "firewall-"
}
variable "firewall_ranges" {
    description = ""
    default = []
}

variable "vnet_rule_name_prefix" {
    description = ""
    default = "postgresql-vnet-rule-"
}
variable "vnet_rules" {
    description = ""
    default = []
}