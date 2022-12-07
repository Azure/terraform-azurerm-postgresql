[![Build Status](https://dev.azure.com/azurerm-terraform-test/azurerm-terraform-modules/_apis/build/status/Azure.terraform-azurerm-postgresql)](https://dev.azure.com/azurerm-terraform-test/azurerm-terraform-modules/_build/latest?definitionId=2)
## Create an Azure PostgreSQL Database

This Terraform module creates a Azure PostgreSQL Database.

## Usage in Terraform 0.13

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "examples-rg"
  location = "West Europe"
}

module "postgresql" {
  source = "Azure/postgresql/azurerm"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  server_name                   = "examples-server"
  sku_name                      = "GP_Gen5_2"
  storage_mb                    = 5120
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  administrator_login           = "login"
  administrator_password        = "password"
  server_version                = "9.5"
  ssl_enforcement_enabled       = true
  public_network_access_enabled = true
  db_names                      = ["my_db1", "my_db2"]
  db_charset                    = "UTF8"
  db_collation                  = "English_United States.1252"

  firewall_rule_prefix = "firewall-"
  firewall_rules = [
    { name = "test1", start_ip = "10.0.0.5", end_ip = "10.0.0.8" },
    { start_ip = "127.0.0.0", end_ip = "127.0.1.0" },
  ]

  vnet_rule_name_prefix = "postgresql-vnet-rule-"
  vnet_rules = [
    { name = "subnet1", subnet_id = "<subnet_id>" }
  ]

  tags = {
    Environment = "Production",
    CostCenter  = "Contoso IT",
  }

  postgresql_configurations = {
    backslash_quote = "on",
  }

  depends_on = [azurerm_resource_group.example]
}
```

## Usage

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "examples-rg"
  location = "West Europe"
}

module "postgresql" {
  source = "Azure/postgresql/azurerm"

  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  server_name                   = "examples-server"
  sku_name                      = "GP_Gen5_2"
  storage_mb                    = 5120
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  administrator_login           = "login"
  administrator_password        = "password"
  server_version                = "9.5"
  ssl_enforcement_enabled       = true
  public_network_access_enabled = true
  db_names                      = ["my_db1", "my_db2"]
  db_charset                    = "UTF8"
  db_collation                  = "English_United States.1252"

  firewall_rule_prefix = "firewall-"
  firewall_rules = [
    { name = "test1", start_ip = "10.0.0.5", end_ip = "10.0.0.8" },
    { start_ip = "127.0.0.0", end_ip = "127.0.1.0" },
  ]

  vnet_rule_name_prefix = "postgresql-vnet-rule-"
  vnet_rules = [
    { name = "subnet1", subnet_id = "<subnet_id>" }
  ]

  tags = {
    Environment = "Production",
    CostCenter  = "Contoso IT",
  }

  postgresql_configurations = {
    backslash_quote = "on",
  }
}
```

## Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We provide 2 ways to build, run, and test the module on a local development machine.  [Native (Mac/Linux)](#native-maclinux) or [Docker](#docker).

### Native(Mac/Linux)

#### Prerequisites

- [Terraform **(~> 0.12.20)**](https://www.terraform.io/downloads.html)
- [Golang **(~> 1.10.3)**](https://golang.org/dl/)

#### Environment setup

We provide simple script to quickly set up module development environment:

```sh
$ curl -sSL https://raw.githubusercontent.com/Azure/terramodtest/master/tool/env_setup.sh | sudo bash
```

#### Run test

Then simply run it in local shell:

```sh
$ cd $GOPATH/src/{directory_name}/
$ ./test.sh full
```

### Docker

We provide a Dockerfile to build a new image based `FROM` the `microsoft/terraform-test` Docker hub image which adds additional tools / packages specific for this module (see Custom Image section).  Alternatively use only the `microsoft/terraform-test` Docker hub image [by using these instructions](https://github.com/Azure/terraform-test).

#### Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

#### Build the image

```sh
$ docker build --build-arg BUILD_ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID --build-arg BUILD_ARM_CLIENT_ID=$ARM_CLIENT_ID --build-arg BUILD_ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET --build-arg BUILD_ARM_TENANT_ID=$ARM_TENANT_ID -t azure-postgresql .
```

#### Run test (Docker)

This runs the local validation:

```sh
$ docker run --rm azure-postgresql /bin/bash -c "bundle install && rake build"
```

This runs the full tests (deploys resources into your Azure subscription):

```sh
$ docker run --rm azure-postgresql /bin/bash -c "bundle install && rake full"
```

## License

[MIT](LICENSE)

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version       |
|---------------------------------------------------------------------------|---------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2        |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.0, < 4.0 |

## Providers

| Name                                                          | Version       |
|---------------------------------------------------------------|---------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0, < 4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                  | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_postgresql_configuration.db_configs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_configuration)               | resource |
| [azurerm_postgresql_database.dbs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_database)                                | resource |
| [azurerm_postgresql_firewall_rule.firewall_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_firewall_rule)           | resource |
| [azurerm_postgresql_server.server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server)                                 | resource |
| [azurerm_postgresql_virtual_network_rule.vnet_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_virtual_network_rule) | resource |

## Inputs

| Name                                                                                                                                       | Description                                                                                                                                                                                                                    | Type                                                                                                                                                                                                                                                                                                                                                                                                                                               | Default                        | Required |
|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login)                                              | The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created.                                                                                                                          | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | n/a                            |   yes    |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password)                                     | The Password associated with the administrator\_login for the PostgreSQL Server.                                                                                                                                               | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | n/a                            |   yes    |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days)                                      | Backup retention days for the server, supported values are between 7 and 35 days.                                                                                                                                              | `number`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `7`                            |    no    |
| <a name="input_db_charset"></a> [db\_charset](#input\_db\_charset)                                                                         | Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created.                                                                            | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"UTF8"`                       |    no    |
| <a name="input_db_collation"></a> [db\_collation](#input\_db\_collation)                                                                   | Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en\_US. Changing this forces a new resource to be created. | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"English_United States.1252"` |    no    |
| <a name="input_db_names"></a> [db\_names](#input\_db\_names)                                                                               | The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created.                                                                              | `list(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                     | `[]`                           |    no    |
| <a name="input_firewall_rule_prefix"></a> [firewall\_rule\_prefix](#input\_firewall\_rule\_prefix)                                         | Specifies prefix for firewall rule names.                                                                                                                                                                                      | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"firewall-"`                  |    no    |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules)                                                             | The list of maps, describing firewall rules. Valid map items: name, start\_ip, end\_ip.                                                                                                                                        | `list(map(string))`                                                                                                                                                                                                                                                                                                                                                                                                                                | `[]`                           |    no    |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled)               | Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier.                                                                                       | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                             | `true`                         |    no    |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled)  | Whether or not infrastructure is encrypted for this server                                                                                                                                                                     | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                             | `true`                         |    no    |
| <a name="input_location"></a> [location](#input\_location)                                                                                 | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.                                                                                                           | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | n/a                            |   yes    |
| <a name="input_postgresql_configurations"></a> [postgresql\_configurations](#input\_postgresql\_configurations)                            | A map with PostgreSQL configurations to enable.                                                                                                                                                                                | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                      | `{}`                           |    no    |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)            | Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled.                                                                                                                     | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                             | `false`                        |    no    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                            | The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created.                                                                                                    | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | n/a                            |   yes    |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name)                                                                      | Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.                                                                                                                                | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | n/a                            |   yes    |
| <a name="input_server_version"></a> [server\_version](#input\_server\_version)                                                             | Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, and 10.0. Changing this forces a new resource to be created.                                                                                            | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"9.5"`                        |    no    |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name)                                                                               | Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B\_Gen4\_1, GP\_Gen5\_8).                                                                              | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"GP_Gen5_4"`                  |    no    |
| <a name="input_ssl_enforcement_enabled"></a> [ssl\_enforcement\_enabled](#input\_ssl\_enforcement\_enabled)                                | Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled.                                                                                                                                  | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                             | `true`                         |    no    |
| <a name="input_ssl_minimal_tls_version_enforced"></a> [ssl\_minimal\_tls\_version\_enforced](#input\_ssl\_minimal\_tls\_version\_enforced) | The minimum TLS version to support on the sever                                                                                                                                                                                | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"TLS1_2"`                     |    no    |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb)                                                                         | Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs.                       | `number`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `102400`                       |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                             | A map of tags to set on every taggable resources. Empty by default.                                                                                                                                                            | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                                      | `{}`                           |    no    |
| <a name="input_threat_detection_policy"></a> [threat\_detection\_policy](#input\_threat\_detection\_policy)                                | Threat detection policy configuration, known in the API as Server Security Alerts Policy                                                                                                                                       | <pre>object(<br>    {<br>      enabled                    = optional(bool)<br>      disabled_alerts            = optional(set(string))<br>      email_account_admins       = optional(bool)<br>      email_addresses            = optional(set(string))<br>      retention_days             = optional(number)<br>      storage_account_access_key = optional(string)<br>      storage_endpoint           = optional(string)<br>    }<br>  )</pre> | `null`                         |    no    |
| <a name="input_vnet_rule_name_prefix"></a> [vnet\_rule\_name\_prefix](#input\_vnet\_rule\_name\_prefix)                                    | Specifies prefix for vnet rule names.                                                                                                                                                                                          | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                           | `"postgresql-vnet-rule-"`      |    no    |
| <a name="input_vnet_rules"></a> [vnet\_rules](#input\_vnet\_rules)                                                                         | The list of maps, describing vnet rules. Valud map items: name, subnet\_id.                                                                                                                                                    | `list(map(string))`                                                                                                                                                                                                                                                                                                                                                                                                                                | `[]`                           |    no    |

## Outputs

| Name                                                                                                     | Description                                                                      |
|----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| <a name="output_administrator_login"></a> [administrator\_login](#output\_administrator\_login)          | The Administrator login for the PostgreSQL Server                                |
| <a name="output_administrator_password"></a> [administrator\_password](#output\_administrator\_password) | The Password associated with the `administrator_login` for the PostgreSQL Server |
| <a name="output_database_ids"></a> [database\_ids](#output\_database\_ids)                               | The list of all database resource ids                                            |
| <a name="output_firewall_rule_ids"></a> [firewall\_rule\_ids](#output\_firewall\_rule\_ids)              | The list of all firewall rule resource ids                                       |
| <a name="output_server_fqdn"></a> [server\_fqdn](#output\_server\_fqdn)                                  | The fully qualified domain name (FQDN) of the PostgreSQL server                  |
| <a name="output_server_id"></a> [server\_id](#output\_server\_id)                                        | The resource id of the PostgreSQL server                                         |
| <a name="output_server_name"></a> [server\_name](#output\_server\_name)                                  | The name of the PostgreSQL server                                                |
| <a name="output_vnet_rule_ids"></a> [vnet\_rule\_ids](#output\_vnet\_rule\_ids)                          | The list of all vnet rule resource ids                                           |
<!-- END_TF_DOCS -->
