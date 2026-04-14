package models

type ReporteOcupacion struct {
	IdFuncion       int     `json:"idFuncion"`
	FechaInicio     string  `json:"fechaInicio"`
	IdSala          int     `json:"idSala"`
	Sala            string  `json:"sala"`
	ButacasVendidas int     `json:"butacasVendidas"`
	Recaudacion     float64 `json:"recaudacion"`
}
