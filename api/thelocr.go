package main

import (
	"thelocr/api/config"
	"thelocr/api/logs"
	"thelocr/api/router"
)

func main() {
	config.SetupLogging()
	logs.InitLogging()

	logs.InfoLog.Println("Starting up LOCR API...")

	env, err := config.InitDB()
	if err != nil {
		logs.ErrorLog.Printf("Failed to setup and configure database: %s", err)
		panic(err)
	}
	logs.InfoLog.Printf("Env: %s", env)

	router := router.InitRouter()

	router.Run(":8080")
}
