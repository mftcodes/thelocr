package main

import (
	"log"
	"thelocr/api/logger"
	"thelocr/api/router"
	"thelocr/api/setup"
)

func main() {
	envs, err := setup.InitApp()
	if err != nil {
		log.Fatal("Failed to initialize app")
		panic(err)
	}

	logger.InfoLog.Println("Starting up LOCR API...")

	if envs["LOCR_ENV"] == "dev" {
		logger.InfoLog.Println("Running in Debug Mode.")
	} else {
		logger.InfoLog.Println("Running in Production Mode.")
	}

	router := router.InitRouter(envs)

	router.Run(":8080")
}
