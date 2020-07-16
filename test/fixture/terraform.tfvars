location = "eastus"

db_names = ["db1", "db2"]

fw_rule_prefix = "firewall"

fw_rules = [
  { name = "test1", start_ip = "10.0.0.5", end_ip = "10.0.0.8" },
]

vnet_rule = "postgresql-vnet-rule-"
