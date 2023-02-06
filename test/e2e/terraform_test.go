package e2e

import (
	"os"
	"regexp"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamples(t *testing.T) {
	testFuncs := map[string]func(*testing.T, test_helper.TerraformOutput){
		"examples/default": testExampleDefault,
		"examples/replica": testExampleReplica,
	}

	for k, v := range testFuncs {
		t.Run(k, func(t *testing.T) {
			retryCfg, err := os.ReadFile("../retryable_errors.hcl.json")
			if err != nil {
				t.Fatalf(err.Error())
			}
			opts := terraform.Options{
				Upgrade:                  true,
				RetryableTerraformErrors: test_helper.ReadRetryableErrors(retryCfg, t),
			}
			test_helper.RunE2ETest(t, "../../", k, opts, v)
		})
	}
}

func testExampleDefault(t *testing.T, output test_helper.TerraformOutput) {
	serverId, ok := output["test_postgresql_server_id"].(string)
	assert.True(t, ok)
	assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.DBforPostgreSQL/servers/.+"), serverId)
}

func testExampleReplica(t *testing.T, output test_helper.TerraformOutput) {
	serverId, ok := output["test_postgresql_replica_server_id"].(string)
	assert.True(t, ok)
	assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.DBforPostgreSQL/servers/.+"), serverId)
}
