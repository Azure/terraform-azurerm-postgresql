package e2e

import (
	"regexp"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamples(t *testing.T) {
	testFuncs := map[string]interface{}{
		"examples/default": testExample,
		"examples/replica": testExampleReplica,
	}

	for k, v := range testFuncs {
		t.Run(k, func(t *testing.T) {
			v.(func(t2 *testing.T, output string))(t, k)
		})
	}
}

func testExample(t *testing.T, exampleRelativePath string) {
	test_helper.RunE2ETest(t, "../../", exampleRelativePath, terraform.Options{
		Upgrade: true,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		serverId, ok := output["test_postgresql_server_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.DBforPostgreSQL/servers/.+"), serverId)
	})
}

func testExampleReplica(t *testing.T, exampleRelativePath string) {
	test_helper.RunE2ETest(t, "../../", exampleRelativePath, terraform.Options{
		Upgrade: true,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		serverId, ok := output["test_postgresql_replica_server_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.DBforPostgreSQL/servers/.+"), serverId)
	})
}
