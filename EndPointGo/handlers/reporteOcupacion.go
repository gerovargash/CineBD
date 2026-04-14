package handlers

import (
	"EndPointGo/database"
	"EndPointGo/models"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

// ReporteOcupacionPorPelicula godoc
// @Summary      Reporte de ocupacion por pelicula
// @Description  Devuelve las ventas del cine para una pelicula en un periodo de tiempo
// @Tags         reportes
// @Produce      json
// @Param        idPelicula   query  int     true  "ID de la pelicula"
// @Param        fechaInicio  query  string  true  "Fecha inicio (YYYY-MM-DD)"
// @Param        fechaFin     query  string  true  "Fecha fin (YYYY-MM-DD)"
// @Success      200  {array}   models.ReporteOcupacion
// @Failure      400  {object}  map[string]string
// @Failure      500  {object}  map[string]string
// @Router       /ocupacion/reporte [get]
func ReporteOcupacionPorPelicula(c *gin.Context) {
	// Obtenemos los query parameters
	idPeliculaStr := c.Query("idPelicula")
	fechaInicio := c.Query("fechaInicio")
	fechaFin := c.Query("fechaFin")

	// Validamos que ninguno esté vacío
	if idPeliculaStr == "" || fechaInicio == "" || fechaFin == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Los parametros idPelicula, fechaInicio y fechaFin son obligatorios"})
		return
	}

	// Convertimos idPelicula a entero
	idPelicula, err := strconv.Atoi(idPeliculaStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "El idPelicula debe ser un numero entero"})
		return
	}

	// Llamamos al SP
	rows, err := database.DB.Query("CALL ReporteDeOcupacionPorPelicula(?, ?, ?)", idPelicula, fechaInicio, fechaFin)
	if err != nil {
		errMsg := err.Error()
		if strings.Contains(errMsg, "Pelicula inexistente") {
			c.JSON(http.StatusNotFound, gin.H{"error": errMsg}) // 404
		} else if strings.Contains(errMsg, "Incorrect date value") {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Fecha de inicio o fin invalida"}) // 400
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": errMsg}) // 500
		}
		return
	}
	defer rows.Close()

	// Recorremos los resultados
	var reporte []models.ReporteOcupacion
	for rows.Next() {
		var r models.ReporteOcupacion
		if err := rows.Scan(
			&r.IdFuncion,
			&r.FechaInicio,
			&r.IdSala,
			&r.Sala,
			&r.ButacasVendidas,
			&r.Recaudacion,
		); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		reporte = append(reporte, r)
	}

	// Si no hay resultados devolvemos una lista vacía en lugar de null
	if reporte == nil {
		reporte = []models.ReporteOcupacion{}
	}

	c.JSON(http.StatusOK, reporte)
}
