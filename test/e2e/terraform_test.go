package e2e

import (
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
			test_helper.RunE2ETest(t, "../../", k, terraform.Options{
				Upgrade: true,
			}, v)
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
