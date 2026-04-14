package routes

import (
	"EndPointGo/handlers"

	"github.com/gin-gonic/gin"

	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

func ConfigurarRutas(router *gin.Engine) {
	// Ruta de Swagger UI
	router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	v1 := router.Group("/v1")
	{
		v1.GET("/precio/:idFuncion", handlers.ObtenerPrecioEntrada)
		v1.GET("/ocupacion/reporte", handlers.ReporteOcupacionPorPelicula)
		v1.POST("/reservas", handlers.ReservarButaca)
		v1.GET("/cartelera", handlers.DameCartelera)
	}
}
