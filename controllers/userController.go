package controllers

import (
	"net/http"

	"bowen/models"
	"bowen/services"

	"github.com/gin-gonic/gin"
)

type UserController struct{}

var userService = new(services.UserService)

func (uc *UserController) GetById(c *gin.Context) {
	uri := Uri{}
	if err := c.BindUri(&uri); err != nil {
		c.AbortWithError(http.StatusBadRequest, err)
		return
	}
	user, err := userService.GetById(uri.Id)
	if err != nil {
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": http.StatusText(http.StatusBadRequest)})
	}

	c.IndentedJSON(http.StatusOK, user)
}

func (uc *UserController) Login(c *gin.Context) {
	var terms models.UserLogin
	if err := c.ShouldBindJSON(&terms); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	result, err := userService.Login(terms)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, result)
}

func (uc *UserController) Create(c *gin.Context) {
	var terms models.UserCreate
	if err := c.ShouldBindJSON(&terms); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	result, err := userService.Create(terms)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, result)
}
