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

	config.InitDB()

	router := router.InitRouter()

	router.Run(":8080")
}
