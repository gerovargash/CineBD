package handlers

import (
	"EndPointGo/database"
	"EndPointGo/models"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

// ReservarButaca godoc
// @Summary      Reserva una butaca
// @Description  Crea una reserva para una funcion con un DNI
// @Tags         reservas
// @Accept       json
// @Produce      json
// @Param        body  body  models.Reserva  true  "Datos de la reserva"
// @Success      201  {object}  map[string]string
// @Failure      400  {object}  map[string]string
// @Router       /reservas [post]
func ReservarButaca(c *gin.Context) {
	// Leemos el body de la petición
	var body models.Reserva
	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Datos invalidos"})
		return
	}

	// Validamos que ningún campo esté vacío
	if body.IdFuncion == 0 || body.IdButaca == 0 || body.DNI == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Los campos idFuncion, idButaca y dni son obligatorios"})
		return
	}

	// Llamamos al SP
	_, err := database.DB.Exec("CALL ReservarButacaConDNI(?, ?, ?)", body.IdFuncion, body.IdButaca, body.DNI)
	if err != nil {
		errMsg := err.Error()
		if strings.Contains(errMsg, "Data too long for column") {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Ingrese DNI valido"}) // 400
		} else if strings.Contains(errMsg, "Funcion inexistente") {
			c.JSON(http.StatusBadRequest, gin.H{"error": "La funcion está inexistente"}) // 400
		} else if strings.Contains(errMsg, "Funcion inactiva") {
			c.JSON(http.StatusBadRequest, gin.H{"error": "La funcion está inactiva"}) // 400
		} else if strings.Contains(errMsg, "Butaca ocupada") {
			c.JSON(http.StatusConflict, gin.H{"error": "La butaca ya está ocupada"}) // 409
		} else if strings.Contains(errMsg, "La butaca no pertenece a la sala de la funcion") {
			c.JSON(http.StatusConflict, gin.H{"error": "La butaca no pertenece a la sala de la funcion"}) // 409
		} else {
			c.JSON(http.StatusInternalServerError, gin.H{"error": errMsg}) // 500
		}
		return
	}

	c.JSON(http.StatusCreated, gin.H{"mensaje": "Reserva creada exitosamente"})
}
