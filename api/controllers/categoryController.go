package controllers

import (
	"net/http"

	"thelocr/api/logger"
	"thelocr/api/services"

	"github.com/gin-gonic/gin"
)

type CategoryController struct{}

var categoryService = new(services.CategoryService)

func (cc *CategoryController) List(c *gin.Context) {
	cats, err := categoryService.GetAll()
	if err != nil {
		logger.ErrorLog.Printf("%v", err)
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": http.StatusText(http.StatusBadRequest)})
	}

	c.IndentedJSON(http.StatusOK, cats)
}
