package controllers

import (
	"net/http"

	"thelocr/api/logger"
	"thelocr/api/services"

	"github.com/gin-gonic/gin"
)

type AddressController struct{}

var addressService = new(services.AddressService)

func (ac *AddressController) List(c *gin.Context) {
	addrs, err := addressService.GetAll()
	if err != nil {
		logger.ErrorLog.Printf("%v", err)
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": http.StatusText(http.StatusBadRequest)})
	}

	c.IndentedJSON(http.StatusOK, addrs)
}

func (ac *AddressController) Detail(c *gin.Context) {
	uri := Uri{}
	// Can probably do better here and ensure it can be parsed as int?
	if err := c.BindUri(&uri); err != nil {
		c.AbortWithError(http.StatusBadRequest, err)
		return
	}
	addr, err := addressService.GetById(uri.Id)
	if err != nil {
		logger.ErrorLog.Printf("%v", err)
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": http.StatusText(http.StatusBadRequest)})
	}

	c.IndentedJSON(http.StatusOK, addr)
}
