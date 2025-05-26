package main

import (
	"log"
	"thelocr/api/logger"
	"thelocr/api/router"
	"thelocr/api/setup"
)

func main() {
	locrEnv, err := setup.InitApp()
	if err != nil {
		log.Fatal("Failed to initialize app")
		panic(err)
	}

	logger.InfoLog.Println("Starting up LOCR API...")

	if locrEnv == "dev" {
		logger.InfoLog.Println("Running in Debug Mode.")
	} else {
		logger.InfoLog.Println("Running in Production Mode.")
	}

	router := router.InitRouter(locrEnv)

	router.Run()
}
