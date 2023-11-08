package main

import (
	"bowen/dbservice"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/api/", func(c *gin.Context) {
		c.String(http.StatusOK, "API is up and running.\n")
	})
	router.GET("/api/address", GetAddrs)
	router.GET("/api/address/:id", GetAddrById)

	router.Run("localhost:8080")
}

func GetAddrs(c *gin.Context) {
	addrs := dbservice.GetAllAddrs()
	c.IndentedJSON(http.StatusOK, addrs)
}

func GetAddrById(c *gin.Context) {
	id := c.Param("id")
	addr := dbservice.GetAddrById(id)
	c.IndentedJSON(http.StatusOK, addr)
}
