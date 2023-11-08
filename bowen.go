package main

import (
	"bowen/config"
	"bowen/router"
)

func main() {
	config.InitDB()

	router := router.InitRouter()

	router.Run(":8080")
}
