package router

import (
	"net/http"

	"bowen/api/controllers"

	"github.com/gin-gonic/gin"
)

var addressController = new(controllers.AddressController)
var resourceController = new(controllers.ResourceController)
var categoryController = new(controllers.CategoryController)
var userController = new(controllers.UserController)

func InitRouter() *gin.Engine {
	r := gin.Default()

	api := r.Group("/api")
	{
		api.GET("", func(c *gin.Context) {
			c.String(http.StatusOK, "Bowen API is up and running.\n")
		})
		address := api.Group("/address")
		{
			address.GET("", addressController.List)
			address.GET(":id", addressController.Detail)
		}
		resource := api.Group("/resource")
		{
			resource.GET(":uuid", resourceController.Detail)
			resource.PUT("", resourceController.Create)
			resource.POST("/search", resourceController.Search)
			resource.POST("/create", resourceController.Create)
			resource.POST("/update", resourceController.Update)
		}
		category := api.Group("/category")
		{
			category.GET("", categoryController.List)
		}
		user := api.Group("/user")
		{
			user.GET(":id", userController.GetById)
			user.PUT("/create", userController.Create)
			user.POST("/login", userController.Login)
		}
	}

	return r
}
