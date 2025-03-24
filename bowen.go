package main

import (
	"bowen/platform/config"
	"bowen/platform/router"
)

func main() {
	config.InitDB()

	router := router.InitRouter()

	router.Run(":8080")
}
