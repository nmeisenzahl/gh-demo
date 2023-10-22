package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type title struct {
	ID    string `json:"id"`
	Title string `json:"title"`
}

var titles = []title{
	{ID: "1", Title: "Hello World!"},
	{ID: "2", Title: "Hey Rosenheim!"},
	{ID: "3", Title: "Hi all!"},
}

func getTitles(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, titles)
}

func main() {
	router := gin.Default()
	router.GET("/", getTitles)

	router.Run("localhost:8080")
}
