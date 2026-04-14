package handlers

import (
	"EndPointGo/database"
	"EndPointGo/models"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

// ObtenerPrecioEntrada godoc
// @Summary      Determina el precio de una entrada
// @Description  Calcula el precio final segun genero y sala
// @Tags         funciones
// @Produce      json
// @Param        idFuncion path  int  true  "ID de la funcion"
// @Success      200  {object}  models.PrecioEntrada
// @Failure      400  {object}  map[string]string
// @Failure      500  {object}  map[string]string
// @Router       /precio/{idFuncion} [get]
func ObtenerPrecioEntrada(c *gin.Context) {
	// Obtenemos el idFuncion de la URL
	idFuncionStr := c.Param("idFuncion")

	// Lo convertimos de string a entero
	idFuncion, err := strconv.Atoi(idFuncionStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "El idFuncion debe ser un número entero"})
		return
	}

	// Llamamos al stored procedure
	rows, err := database.DB.Query("CALL DeterminarPrecioDeEntrada(?)", idFuncion)
	if err != nil {
		errMsg := err.Error()
		if strings.Contains(errMsg, "Funcion inexistente") {
			c.JSON(http.StatusNotFound, gin.H{"error": errMsg}) // 404
		} else if strings.Contains(errMsg, "Funcion inactiva") {
			c.JSON(http.StatusBadRequest, gin.H{"error": errMsg}) // 400
		} else if strings.Contains(errMsg, "La funcion ya ha acabado") {
			c.JSON(http.StatusBadRequest, gin.H{"error": errMsg}) // 400
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": errMsg}) // 500
		}
		return
	}
	defer rows.Close()

	// Leemos el único valor que devuelve
	var resultado models.PrecioEntrada
	if rows.Next() {
		if err := rows.Scan(&resultado.PrecioFinal); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
	}

	c.JSON(http.StatusOK, resultado)
}
