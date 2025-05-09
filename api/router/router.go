package router

import (
	"net/http"
	"time"

	"thelocr/api/controllers"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

var addressController = new(controllers.AddressController)
var resourceController = new(controllers.ResourceController)
var categoryController = new(controllers.CategoryController)
var userController = new(controllers.UserController)

func InitRouter(locrEnv string) *gin.Engine {
	if locrEnv == "prod" {
		gin.SetMode(gin.ReleaseMode)
	}
	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"GET", "POST", "PUT", "OPTIONS"},
		AllowHeaders: []string{"Origin"},
		ExposeHeaders: []string{
			"Content-Length",
			"application/json",
			"application/x-www-form-urlencoded",
			"multipart/form-data",
			"Access-Control-Allow-Headers",
			"content-type"},
		AllowCredentials: true,
		AllowOriginFunc: func(origin string) bool {
			return origin == "http://localhost:5173"
		},
		MaxAge: 12 * time.Hour,
	}))

	api := r.Group("/api")
	{
		api.GET("", func(c *gin.Context) {
			c.String(http.StatusOK, "TheLocr API is up and running.\n")
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
