package setup

import (
	"database/sql"
	"errors"
	"fmt"
	"os"

	"thelocr/api/db"
	"thelocr/api/logger"

	"github.com/joho/godotenv"
)

var (
	DBConn *sql.DB
)

func InitApp() (locrEnv string, err error) {
	envs, err := LoadDotEnv()
	if err != nil {
		return locrEnv, err
	}

	locrEnv = envs["LOCR_ENV"]

	logFileUri, err := SetupLogFile(locrEnv, envs)
	if err != nil {
		return locrEnv, err
	}

	logger.InitLogging(logFileUri)

	logger.InfoLog.Printf("Environment (%s) Setup Complete", locrEnv)

	err = db.InitDB(envs)
	if err != nil {
		logger.ErrorLog.Printf("Error initializing db: %s", err)
	}
	logger.InfoLog.Println("DB Successfully initialized")

	return locrEnv, nil
}

func LoadDotEnv() (map[string]string, error) {
	var envs map[string]string
	envs, err := godotenv.Read(".env")

	if err != nil {
		return envs, err
	}

	return envs, nil
}

func SetupLogFile(locrEnv string, envs map[string]string) (logFileUri string, err error) {
	logFile := envs["LOG_FILE"]

	var locrDir string

	if locrEnv == "prod" {
		locrDir = envs["PROD_DIR"]
		logFileUri = fmt.Sprintf("%s%s", locrDir, logFile)
	} else {
		locrDir = envs["DEV_DIR"]
		logFileUri = fmt.Sprintf("%s%s", locrDir, logFile)
	}

	err = os.MkdirAll(locrDir, 0750)
	if err != nil && !os.IsExist(err) {
		return logFileUri, err
	}

	if _, err := os.Stat(logFileUri); errors.Is(err, os.ErrNotExist) {
		err = os.WriteFile(logFileUri, []byte("***** The LOCR LOGS *****\n\n\n"), 0750)
		if err != nil && !os.IsExist(err) {
			return logFileUri, err
		}
	}

	return logFileUri, nil
}
