package models

type Cartelera struct {
	IdFuncion           int     `json:"idFuncion"`
	Pelicula            string  `json:"pelicula"`
	Genero              string  `json:"genero"`
	FechaHora           string  `json:"fechaHora"`
	Duracion            string  `json:"duracion"`
	IdSala              float64 `json:"idSala"`
	Sala                string  `json:"sala"`
	Precio              float64 `json:"precio"`
	EntradasDisponibles int     `json:"entradasDisponibles"`
}
