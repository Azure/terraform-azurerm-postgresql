package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"

	_ "github.com/lib/pq"
)

func TestTerraformPostgresql(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./fixture",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{},
	}

	// This will init and apply the resources and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// At the end of the test, clean up any resources that were created
	terraform.Destroy(t, terraformOptions)
}
