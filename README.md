# terraform-azure-postgresql

## Create an Azure SQL Database

This Terraform module creates a Azure PostgreSQL Database.

## Usage

```hcl
module "postgresql" {
  source              = "Azure/postgresql/azurerm"

    resource_group_name = "sample-rg"
    location = "west us 2"

    server_name = "sampleserver"
    sku_name = "GP_Gen5_2"
    sku_capacity = 2
    sku_tier = "GeneralPurpose"
    sku_family = "Gen5"

    storage_mb = 5120
    backup_retention_days = 7
    geo_redundant_backup = "Disabled"

    administrator_login = "login"
    administrator_password = "password"

    version = "9.5"
    ssl_enforcement = "Enabled"

    db_names = ["my_db1", "my_db2"]
    db_charset = "UTF8"
    db_collation = "English_United States.1252"

    firewall_prefix = "firewall-"
    firewall_ranges = [
        {name="test1", start_ip="10.0.0.5", end_ip="10.0.0.8"},
        {start_ip="127.0.0.0", end_ip="127.0.1.0"},
    ]

    vnet_rule_name_prefix = "postgresql-vnet-rule-"
    vnet_rules = [
        {name="subnet1", subnet_id="<subnet_id>"}
    ]
}
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
