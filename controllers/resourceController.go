package controllers

import (
	"net/http"

	"bowen/models"
	"bowen/services"

	"github.com/gin-gonic/gin"
)

type ResourceController struct{}

var resourceService = new(services.ResourceService)

func (rc *ResourceController) Create(c *gin.Context) {
	var resInput models.ResourceInsert
	if err := c.ShouldBindJSON(&resInput); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	_, err := resourceService.Create(resInput)
	if err != nil {
		// Need to get rid of the error sending back, need to log send back generic message, or 500?
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.Status(http.StatusOK)
}
