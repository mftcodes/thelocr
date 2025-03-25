package main

import (
	"bowen/platform/config"
	"bowen/platform/logs"
	"bowen/platform/router"
)

func main() {
	config.SetupLogging()
	logs.InitLogging()

	logs.InfoLog.Println("Starting up Project Bowen API...")

	config.InitDB()

	router := router.InitRouter()

	router.Run(":8080")
}
