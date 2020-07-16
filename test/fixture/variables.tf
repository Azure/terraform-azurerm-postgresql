variable "location" {}

variable "db_names" {
  type = list(string)
}

variable "fw_rule_prefix" {}

variable "fw_rules" {
  type = list(any)
}

variable "vnet_rule" {}

