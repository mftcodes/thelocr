package config

import (
	"fmt"
	"os"
)

func SetupLocalDevEnv() error {
	tempDir := SetLocalConfDir()
	err := os.Mkdir(tempDir, 0750)
	if err != nil && !os.IsExist(err) {
		return err
	}

	localSettingsFile := fmt.Sprintln("USER=root\nPASSWD=9YCoZ#ULdVQQvmcF\nNET=tcp\nSERVER=localhost:3308\nDB=minuchin")

	fileUri := SetLocalConfFileUri()
	err = os.WriteFile(fileUri, []byte(localSettingsFile), 0750)
	if err != nil && !os.IsExist(err) {
		return err
	}

	return nil
}

func SetLocalConfDir() string {
	return "/tmp/project.bowen/"
}

func SetLocalConfFileUri() string {
	return "/tmp/project.bowen/localdev.conf"
}

func SetProdConfFileUri() string {
	return "/etc/project.bowen/minuchin.conf"
}
