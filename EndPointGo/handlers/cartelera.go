package handlers

import (
	"EndPointGo/database"
	"EndPointGo/models"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

// Cartelera godoc
// @Summary      Cartelera para un periodo de tiempo
// @Description  Devuelve la cartelera del cine para un periodo de tiempo
// @Tags         cartelera
// @Produce      json
// @Param        fechaInicio  query  string  true  "Fecha inicio (YYYY-MM-DD)"
// @Param        fechaFin     query  string  true  "Fecha fin (YYYY-MM-DD)"
// @Success      200  {array}   models.Cartelera
// @Failure      400  {object}  map[string]string
// @Failure      500  {object}  map[string]string
// @Router       /cartelera [get]
func DameCartelera(c *gin.Context) {
	// Obtenemos los query parameters
	fechaInicio := c.Query("fechaInicio")
	fechaFin := c.Query("fechaFin")

	// Validamos que ninguno esté vacío
	if fechaInicio == "" || fechaFin == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Los parametros fechaInicio y fechaFin son obligatorios"})
		return
	}

	// Llamamos al SP
	rows, err := database.DB.Query("CALL DameCartelera(?, ?)", fechaInicio, fechaFin)
	if err != nil {
		errMsg := err.Error()
		if strings.Contains(errMsg, "Incorrect date value") {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Fecha de inicio o fin invalida"}) // 400
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": errMsg}) // 500
		}
		return
	}
	defer rows.Close()

	// Recorremos los resultados
	var reporte []models.Cartelera
	for rows.Next() {
		var r models.Cartelera
		if err := rows.Scan(
			&r.IdFuncion,
			&r.Pelicula,
			&r.Genero,
			&r.FechaHora,
			&r.Duracion,
			&r.IdSala,
			&r.Sala,
			&r.Precio,
			&r.EntradasDisponibles,
		); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		reporte = append(reporte, r)
	}

	// Si no hay resultados devolvemos una lista vacía en lugar de null
	if reporte == nil {
		reporte = []models.Cartelera{}
	}

	c.JSON(http.StatusOK, reporte)
}
