package controllers

import (
	"net/http"

	"bowen/api/logs"
	"bowen/api/models"
	"bowen/api/services"

	"github.com/gin-gonic/gin"
)

type ResourceController struct{}

var resourceService = new(services.ResourceService)

/* *** TODO NOTES ***
 * Need to refactor errors to logs, and consider
 * having errors going back to the front-end (or client?)
 * to be more generic, 500 perhaps?
 */

func (rc *ResourceController) Create(c *gin.Context) {
	var resInput models.ResourceInsert
	if err := c.ShouldBindJSON(&resInput); err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	_, err := resourceService.Create(resInput)
	if err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	c.Status(http.StatusOK)
}

func (rc *ResourceController) Detail(c *gin.Context) {
	uri := Uri{}
	if err := c.BindUri(&uri); err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.AbortWithError(http.StatusBadRequest, err)
		return
	}
	user, err := resourceService.GetById(uri.Res_Uuid)
	if err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": http.StatusText(http.StatusBadRequest)})
	}

	c.IndentedJSON(http.StatusOK, user)
}

func (rc *ResourceController) Search(c *gin.Context) {
	var terms models.ResourceSearchBase
	if err := c.ShouldBindJSON(&terms); err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	result, err := resourceService.SearchBase(terms)
	if err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, result)
}

func (rc *ResourceController) Update(c *gin.Context) {
	var res models.ResourceEdit
	if err := c.ShouldBindJSON(&res); err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.JSON(http.StatusBadRequest, gin.H{"A error": err.Error()})
		return
	}

	result, err := resourceService.Update(res)
	if err != nil {
		logs.ErrorLog.Printf("%v", err)
		c.JSON(http.StatusBadRequest, gin.H{"B error": err.Error()})
		return
	}

	c.IndentedJSON(http.StatusOK, result)
}
