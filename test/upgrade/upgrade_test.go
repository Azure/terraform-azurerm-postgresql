package upgrade

import (
	"fmt"
	"os"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExampleUpgrade_complete(t *testing.T) {
	examples := []string{
		"default",
		"replica",
	}

	for _, f := range examples {
		t.Run(f, func(t *testing.T) {
			currentRoot, err := test_helper.GetCurrentModuleRootPath()
			if err != nil {
				t.FailNow()
			}
			currentMajorVersion, err := test_helper.GetCurrentMajorVersionFromEnv()
			if err != nil {
				t.FailNow()
			}
			retryCfg, err := os.ReadFile("../retryable_errors.hcl.json")
			if err != nil {
				t.Fatalf(err.Error())
			}
			test_helper.ModuleUpgradeTest(t, "Azure", "terraform-azurerm-postgresql", fmt.Sprintf("examples/%s", f), currentRoot, terraform.Options{
				Upgrade:                  true,
				RetryableTerraformErrors: test_helper.ReadRetryableErrors(retryCfg, t),
			}, currentMajorVersion)
		})
	}
}
