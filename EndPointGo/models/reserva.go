package models

type Reserva struct {
	IdFuncion int    `json:"idFuncion"`
	IdButaca  int    `json:"idButaca"`
	DNI       string `json:"dni"`
}
