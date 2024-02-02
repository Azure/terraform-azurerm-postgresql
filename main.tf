resource "azurerm_postgresql_server" "server" {
  location                          = var.location
  name                              = var.server_name
  resource_group_name               = var.resource_group_name
  sku_name                          = var.sku_name
  ssl_enforcement_enabled           = var.ssl_enforcement_enabled
  version                           = var.server_version
  administrator_login               = var.administrator_login
  administrator_login_password      = var.administrator_password
  auto_grow_enabled                 = var.auto_grow_enabled
  backup_retention_days             = var.backup_retention_days
  create_mode                       = var.create_mode
  creation_source_server_id         = var.creation_source_server_id
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
  storage_mb                        = var.storage_mb
  tags = merge(var.tags, (/*<box>*/ (var.tracing_tags_enabled ? { for k, v in /*</box>*/ {
    avm_git_commit           = "80225f6d5b9b27e0b5b4d0b83ec8a964823f27fe"
    avm_git_file             = "main.tf"
    avm_git_last_modified_at = "2023-01-11 06:11:02"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azurerm-postgresql"
    avm_yor_trace            = "691d38a2-bb08-42fe-b470-c143e983e4ed"
    } /*<box>*/ : replace(k, "avm_", var.tracing_tags_prefix) => v } : {}) /*</box>*/), (/*<box>*/ (var.tracing_tags_enabled ? { for k, v in /*</box>*/ {
    avm_yor_name = "server"
  } /*<box>*/ : replace(k, "avm_", var.tracing_tags_prefix) => v } : {}) /*</box>*/))

  dynamic "threat_detection_policy" {
    for_each = nonsensitive(var.threat_detection_policy) != null ? ["threat_detection_policy"] : []

    content {
      disabled_alerts            = var.threat_detection_policy.disabled_alerts
      email_account_admins       = var.threat_detection_policy.email_account_admins
      email_addresses            = var.threat_detection_policy.email_addresses
      enabled                    = var.threat_detection_policy.enabled
      retention_days             = var.threat_detection_policy.retention_days
      storage_account_access_key = var.threat_detection_policy.storage_account_access_key
      storage_endpoint           = var.threat_detection_policy.storage_endpoint
    }
  }
}

resource "azurerm_postgresql_database" "dbs" {
  count = length(var.db_names)

  charset             = var.db_charset
  collation           = var.db_collation
  name                = var.db_names[count.index]
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
}

resource "azurerm_postgresql_firewall_rule" "firewall_rules" {
  count = length(var.firewall_rules)

  end_ip_address      = var.firewall_rules[count.index]["end_ip"]
  name                = format("%s%s", var.firewall_rule_prefix, lookup(var.firewall_rules[count.index], "name", count.index))
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  start_ip_address    = var.firewall_rules[count.index]["start_ip"]
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_rules" {
  count = length(var.vnet_rules)

  name                = format("%s%s", var.vnet_rule_name_prefix, lookup(var.vnet_rules[count.index], "name", count.index))
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  subnet_id           = var.vnet_rules[count.index]["subnet_id"]
}

resource "azurerm_postgresql_configuration" "db_configs" {
  count = length(keys(var.postgresql_configurations))

  name                = element(keys(var.postgresql_configurations), count.index)
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.server.name
  value               = element(values(var.postgresql_configurations), count.index)
}

