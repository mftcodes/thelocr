package router

import (
	// "fmt"
	"net/http"

	"bowen/dbservice"

	"github.com/gin-gonic/gin"
)

type Uri struct {
	Id string `uri:"id"`
}

func Initialize() *gin.Engine {
	r := gin.Default()

	api := r.Group("/api")
	{
		api.GET("", func(c *gin.Context) {
			c.String(http.StatusOK, "Bowen API is up and running.\n")
		})
		address := api.Group("/address")
		{
			address.GET("", GetAddrs)
			address.GET(":id", GetAddrById)
		}
	}

	return r
}

func GetAddrs(c *gin.Context) {
	// c.String(http.StatusOK, "Get Addresses.\n")
	addrs := dbservice.GetAllAddrs()
	c.IndentedJSON(http.StatusOK, addrs)
}

func GetAddrById(c *gin.Context) {
	uri := Uri{}
	if err := c.BindUri(&uri); err != nil {
		c.AbortWithError(http.StatusBadRequest, err)
		return
	}
	// msg := fmt.Sprintf("Get Address by ID: %d\n", uri.Id)
	// c.String(http.StatusOK, msg)
	addr := dbservice.GetAddrById(uri.Id)
	c.IndentedJSON(http.StatusOK, addr)
}
