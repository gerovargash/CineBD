package database

import (
	"database/sql"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

var DB *sql.DB

func ConectarDB() {
	var err error
	dsn := "root:negradito99@tcp(localhost:3306)/bdcine"
	DB, err = sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("Error al conectar con la base de datos:", err)
	}

	if err = DB.Ping(); err != nil {
		log.Fatal("No se pudo hacer ping a la base de datos:", err)
	}

	log.Println("Conexión a MySQL exitosa")
}
