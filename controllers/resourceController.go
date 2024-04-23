package controllers

import (
	"net/http"

	"bowen/models"
	"bowen/services"

	"github.com/gin-gonic/gin"
)

type ResourceController struct{}

var resourceService = new(services.ResourceService)

/* *** TODO NOTES ***
 * Need to refactor errors to logs, and consider
 * having errors going back to the front-end (or client?)
 * to be more generic, 500 perhsp?
 */

func (rc *ResourceController) Create(c *gin.Context) {
	var resInput models.ResourceInsert
	if err := c.ShouldBindJSON(&resInput); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	_, err := resourceService.Create(resInput)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.Status(http.StatusOK)
}

func (rc *ResourceController) Search(c *gin.Context) {
	var terms models.ResourceSearchBase
	if err := c.ShouldBindJSON(&terms); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	result, err := resourceService.SearchBase(terms)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, result)
}

func (rc *ResourceController) Update(c *gin.Context) {
	var res models.ResourceEdit
	if err := c.ShouldBindJSON(&res); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"A error": err.Error()})
		return
	}

	result, err := resourceService.Update(res)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"B error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, result)
}
