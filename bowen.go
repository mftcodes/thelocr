package main

import (
	"bowen/router"
)

func main() {
	router := router.Initialize()

	router.Run(":8080")
}
