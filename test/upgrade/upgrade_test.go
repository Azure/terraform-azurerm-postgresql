package upgrade

import (
	"fmt"
	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
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
			test_helper.ModuleUpgradeTest(t, "Azure", "terraform-azurerm-postgresql", fmt.Sprintf("examples/%s", f), currentRoot, terraform.Options{
				Upgrade: true,
			}, currentMajorVersion)
		})
	}
}
