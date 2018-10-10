package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
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

	// Setting database configuration, including server name, user name, password and database name
	var dbConfig DBConfig
	dbConfig.server = terraform.Output(t, terraformOptions, "server_fqdn")
	var userTemp = terraform.Output(t, terraformOptions, "administrator_login")
	dbConfig.user = fmt.Sprintf("%s@%s", userTemp, dbConfig.server)
	dbConfig.password = terraform.Output(t, terraformOptions, "administrator_password")
	// TODO - figure out reading the database names and iterating rather than hardcoding a single database
	dbConfig.database = "testdb1"
	// dbConfig.database = terraform.Output(t, terraformOptions, "database_name")

	// It can take a minute or so for the database to boot up, so retry a few times
	maxRetries := 15
	timeBetweenRetries := 5 * time.Second
	description := fmt.Sprintf("Executing commands on database %s", dbConfig.server)

	// Verify that we can connect to the database and run SQL commands
	retry.DoWithRetry(t, description, maxRetries, timeBetweenRetries, func() (string, error) {
		// Connect to specific database, i.e. mssql
		db, err := DBConnectionE(t, "postgres", dbConfig)
		if err != nil {
			return "", err
		}

		// Create a table
		creation := "create table person (id integer, name varchar(30), primary key (id))"
		DBExecution(t, db, creation)

		// Insert a row
		expectedID := 12345
		expectedName := "azure"
		insertion := fmt.Sprintf("insert into person values (%d, '%s')", expectedID, expectedName)
		DBExecution(t, db, insertion)

		// Query the table and check the output
		query := "select name from person"
		DBQueryWithValidation(t, db, query, "azure")

		// Drop the table
		drop := "drop table person"
		DBExecution(t, db, drop)
		fmt.Println("Executed SQL commands correctly")

		defer db.Close()

		return "", nil
	})

	// At the end of the test, clean up any resources that were created
	terraform.Destroy(t, terraformOptions)
}
