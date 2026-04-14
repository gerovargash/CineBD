package database

import (
	"bufio"
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"

	_ "github.com/go-sql-driver/mysql"
)

var DB *sql.DB

func ConectarDB() {

	reader := bufio.NewReader(os.Stdin)
	fmt.Print("Ingrese la contraseña de MySQL: ")
	password, _ := reader.ReadString('\n')
	password = strings.TrimSpace(password)

	// Armamos la conexión con la contraseña ingresada
	dsn := fmt.Sprintf("root:%s@tcp(localhost:3306)/bdcine", password)

	var err error
	DB, err = sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("Error al conectar con la base de datos:", err)
	}

	if err = DB.Ping(); err != nil {
		log.Fatal("No se pudo hacer ping a la base de datos:", err)
	}

	log.Println("Conexión a MySQL exitosa")
}
