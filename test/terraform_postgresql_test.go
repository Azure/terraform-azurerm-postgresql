package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"strings"
	"testing"
)

func TestTerraformPostgresql(t *testing.T) {
	t.Parallel()

	var fwRulePrefix = "firewall"
	var fwRules = []map[string]string{{"name": "test1", "start_ip": "10.0.0.5", "end_ip": "10.0.0.8"}}
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "./fixture",
		Vars:         map[string]interface{}{},
	}

	// Defer the destroy to cleanup all created resources
	defer terraform.Destroy(t, terraformOptions)

	// This will init and apply the resources and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Verify all firewall rules were created
	firewall_rule_ids := terraform.Output(t, terraformOptions, "firewall_rule_ids")
	for _, rule := range fwRules {
		name := fwRulePrefix + rule["name"]
		if strings.Index(firewall_rule_ids, name) == -1 {
			t.Fatal("Error: wrong firewall rule id found")
		}
	}

	// Verify vnet rules list is empty
	vnet_rule_ids := terraform.Output(t, terraformOptions, "vnet_rule_ids")
	if len(vnet_rule_ids) == 0 {
		t.Fatal("Error: vnet_rule_ids is empty!")
	}
}
