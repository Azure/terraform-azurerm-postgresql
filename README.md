## Create an Azure PostgreSQL Database

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

    server_version = "9.5"
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

## Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We provide 2 ways to build, run, and test the module on a local development machine.  [Native (Mac/Linux)](#native-maclinux) or [Docker](#docker).

### Native(Mac/Linux)

#### Prerequisites

- [Bundler **(~> 1.15)**](https://bundler.io/)
- [Terraform **(~> 0.11.7)**](https://www.terraform.io/downloads.html)
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
$ docker build -t azure-postgresql-module .
```

#### Run test (Docker)

This runs the local validation:

```sh
$ docker run --rm azure-postgresql-module /bin/bash -c "./test.sh validate"
```

This runs the full tests (deploys resources into your Azure subscription):

```sh
$ docker run -e "ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID" -e "ARM_CLIENT_ID=$AZURE_CLIENT_ID" -e "ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET" -e "ARM_TENANT_ID=$AZURE_TENANT_ID" -e "ARM_TEST_LOCATION=WestUS2" -e "ARM_TEST_LOCATION_ALT=EastUS" --rm azure-postgresql-module bash -c "./test.sh full"
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
