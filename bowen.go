package main

import (
	"bowen/dbservice"

    "github.com/gin-gonic/gin"
)

func main() {
    router := gin.Default()
	router.GET("/api/", func(c *gin.Context) {
		c.String(200, "API is up and running.")
	})
    router.GET("/api/address", GetAddrs)
    router.GET("/api/address/:id", GetAddrById)

    router.Run("10.192.184.100:8080")
}

func GetAddrs(c *gin.Context) {
	addrs := dbservice.GetAllAddrs()
	c.IndentedJSON(200, addrs)
}

func GetAddrById(c *gin.Context) {
    id := c.Param("id")
	addr := dbservice.GetAddrById(id)
	c.IndentedJSON(200, addr)
}
