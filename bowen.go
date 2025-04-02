package main

import (
	"bowen/api/config"
	"bowen/api/logs"
	"bowen/api/router"
)

func main() {
	config.SetupLogging()
	logs.InitLogging()

	logs.InfoLog.Println("Starting up Project Bowen API...")

	err := config.InitDB()
	if err != nil {
		logs.ErrorLog.Printf("Failed to setup and configure database: %s", err)
		panic(err)
	}

	router := router.InitRouter()

	router.Run(":8080")
}
