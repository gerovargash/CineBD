// @title           API Cine
// @version         1.0
// @description     API para la gestion de reservas de cine
// @host            cinebd.ddns.net:1320
// @BasePath        /v1
package main

import (
	"EndPointGo/database"
	_ "EndPointGo/docs"
	"EndPointGo/routes"

	"github.com/gin-gonic/gin"
)

func main() {
	database.ConectarDB()

	router := gin.Default()

	routes.ConfigurarRutas(router)

	router.Run("192.168.1.30:1320")
}
