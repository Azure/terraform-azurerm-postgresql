# Changelog

## [Unreleased](https://github.com/Azure/terraform-azurerm-postgresql/tree/HEAD)

**Merged pull requests:**

- Bump github.com/Azure/terraform-module-test-helper from 0.17.0 to 0.18.0 in /test [\#108](https://github.com/Azure/terraform-azurerm-postgresql/pull/108) ([dependabot[bot]](https://github.com/apps/dependabot))

## [3.2.0](https://github.com/Azure/terraform-azurerm-postgresql/tree/3.2.0) (2024-02-02)

**Merged pull requests:**

- Bump github.com/Azure/terraform-module-test-helper from 0.16.0 to 0.17.0 in /test [\#101](https://github.com/Azure/terraform-azurerm-postgresql/pull/101) ([dependabot[bot]](https://github.com/apps/dependabot))
- Fix dynamic block for threat\_detection\_policy [\#98](https://github.com/Azure/terraform-azurerm-postgresql/pull/98) ([tommygarvin](https://github.com/tommygarvin))
- Bump github.com/Azure/terraform-module-test-helper from 0.9.1 to 0.16.0 in /test [\#88](https://github.com/Azure/terraform-azurerm-postgresql/pull/88) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump google.golang.org/grpc from 1.50.1 to 1.53.0 in /test [\#86](https://github.com/Azure/terraform-azurerm-postgresql/pull/86) ([dependabot[bot]](https://github.com/apps/dependabot))
- Correct runner pool name, add tracing tag toggle variables [\#76](https://github.com/Azure/terraform-azurerm-postgresql/pull/76) ([lonegunmanb](https://github.com/lonegunmanb))
- Bump tflint azurerm ruleset version [\#70](https://github.com/Azure/terraform-azurerm-postgresql/pull/70) ([lonegunmanb](https://github.com/lonegunmanb))
- Bump github.com/Azure/terraform-module-test-helper from 0.8.1 to 0.9.1 in /test [\#63](https://github.com/Azure/terraform-azurerm-postgresql/pull/63) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump github.com/gruntwork-io/terratest from 0.41.10 to 0.41.11 in /test [\#62](https://github.com/Azure/terraform-azurerm-postgresql/pull/62) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump golang.org/x/net from 0.1.0 to 0.7.0 in /test [\#61](https://github.com/Azure/terraform-azurerm-postgresql/pull/61) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump github.com/hashicorp/go-getter from 1.6.1 to 1.7.0 in /test [\#60](https://github.com/Azure/terraform-azurerm-postgresql/pull/60) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump github.com/hashicorp/go-getter/v2 from 2.1.1 to 2.2.0 in /test [\#59](https://github.com/Azure/terraform-azurerm-postgresql/pull/59) ([dependabot[bot]](https://github.com/apps/dependabot))
- Add version upgrade test to this module [\#58](https://github.com/Azure/terraform-azurerm-postgresql/pull/58) ([lonegunmanb](https://github.com/lonegunmanb))

## [3.1.1](https://github.com/Azure/terraform-azurerm-postgresql/tree/3.1.1) (2023-02-06)

**Merged pull requests:**

- Enhance generated random password to meet the complexity requirement [\#57](https://github.com/Azure/terraform-azurerm-postgresql/pull/57) ([lonegunmanb](https://github.com/lonegunmanb))
- Add random string to db server name in examples so we can execute tests concurrently [\#56](https://github.com/Azure/terraform-azurerm-postgresql/pull/56) ([lonegunmanb](https://github.com/lonegunmanb))
- Bump github.com/Azure/terraform-module-test-helper from 0.7.1 to 0.8.1 in /test [\#55](https://github.com/Azure/terraform-azurerm-postgresql/pull/55) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump github.com/gruntwork-io/terratest from 0.41.9 to 0.41.10 in /test [\#54](https://github.com/Azure/terraform-azurerm-postgresql/pull/54) ([dependabot[bot]](https://github.com/apps/dependabot))

## [3.1.0](https://github.com/Azure/terraform-azurerm-postgresql/tree/3.1.0) (2023-01-28)

**Merged pull requests:**

- Adding Microsoft SECURITY.MD [\#52](https://github.com/Azure/terraform-azurerm-postgresql/pull/52) ([microsoft-github-policy-service[bot]](https://github.com/apps/microsoft-github-policy-service))
- Bump github.com/Azure/terraform-module-test-helper from 0.6.0 to 0.7.1 in /test [\#51](https://github.com/Azure/terraform-azurerm-postgresql/pull/51) ([dependabot[bot]](https://github.com/apps/dependabot))
- Bump github.com/gruntwork-io/terratest from 0.41.7 to 0.41.9 in /test [\#50](https://github.com/Azure/terraform-azurerm-postgresql/pull/50) ([dependabot[bot]](https://github.com/apps/dependabot))
- Add `create_mode` and `creation_source_server_id` to postgresql module [\#49](https://github.com/Azure/terraform-azurerm-postgresql/pull/49) ([jiaweitao001](https://github.com/jiaweitao001))
- Bump github.com/Azure/terraform-module-test-helper from 0.4.0 to 0.6.0 in /test [\#48](https://github.com/Azure/terraform-azurerm-postgresql/pull/48) ([dependabot[bot]](https://github.com/apps/dependabot))

## [3.0.0](https://github.com/Azure/terraform-azurerm-postgresql/tree/3.0.0) (2022-12-30)

**Merged pull requests:**

- Update desciption for `ssl_minimal_tls_version_enforced` [\#47](https://github.com/Azure/terraform-azurerm-postgresql/pull/47) ([jiaweitao001](https://github.com/jiaweitao001))
- Set administrator\_password as sensitive [\#46](https://github.com/Azure/terraform-azurerm-postgresql/pull/46) ([jiaweitao001](https://github.com/jiaweitao001))
- Update description of `server_version` [\#45](https://github.com/Azure/terraform-azurerm-postgresql/pull/45) ([jiaweitao001](https://github.com/jiaweitao001))
- Exposing the psqlserver modules auto grow feature [\#44](https://github.com/Azure/terraform-azurerm-postgresql/pull/44) ([jiaweitao001](https://github.com/jiaweitao001))
- Disallow legacy dot index syntax [\#43](https://github.com/Azure/terraform-azurerm-postgresql/pull/43) ([lonegunmanb](https://github.com/lonegunmanb))
- Bump github.com/gruntwork-io/terratest from 0.41.6 to 0.41.7 in /test [\#41](https://github.com/Azure/terraform-azurerm-postgresql/pull/41) ([dependabot[bot]](https://github.com/apps/dependabot))
- Remove deprecated files [\#40](https://github.com/Azure/terraform-azurerm-postgresql/pull/40) ([lonegunmanb](https://github.com/lonegunmanb))
- Add CI pipeline [\#38](https://github.com/Azure/terraform-azurerm-postgresql/pull/38) ([jiaweitao001](https://github.com/jiaweitao001))
- Add public\_network\_access\_enabled variable [\#26](https://github.com/Azure/terraform-azurerm-postgresql/pull/26) ([kcirrr](https://github.com/kcirrr))
- Docker fix [\#24](https://github.com/Azure/terraform-azurerm-postgresql/pull/24) ([yupwei68](https://github.com/yupwei68))
- Integration of Terramodtest 0.8.0 [\#23](https://github.com/Azure/terraform-azurerm-postgresql/pull/23) ([yupwei68](https://github.com/yupwei68))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
