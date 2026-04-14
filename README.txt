=====================================
Pasos para descargar todo el proyecto
=====================================
1. Se debe descargar todo el proyecto de GitHub como archivo .zip
2. Descomprimir el archivo descargado

____________________________________
Pasos para crear la BD y usar la BD:
====================================
1. Para crear el esquema, las tablas, poblarlas las tablas y crear tambien los stored procedures y funciones se debe correr todo el codigo presente en el archivo "GenerarCineBD.sql" en la carpeta "/SQL"
2. Para usar los SPs se debe abrir el archivo "PruebasDeSPs" presente en la carpeta "/SQL" y correr las secciones de codigo que se necesite (Segun que SP se quiera probar)

_________________________
Pasos para correr la API:
=========================
OPCION 1 - Acceder por la web:
1. La API estara corriendo desde mi computadora, para acceder a la pagina swagger que la documenta acceder a la siguiente URL: "http://cinebd.ddns.net:1320/swagger/index.html#/"

OPCION 2 - Correr la API localmente:
1. Es necesario que se haya creado la base de datos como indica el paso 1. de la seccion anterior
2. En la carpeta /"EndPointGo" habran dos archivos ejecutables "apicinewindos.exe" y "apicinelinux", correr el que corresponda segun que sistema operativo este usando
3. Ingresar su contraseña para establecer conexion con la base de datos que acaba de crear
4. Si por pantalla aparece el mensaje "Conexión a MySQL exitosa" entonces la API esta corriendo correctamente y esta lista para acceder a sus endpoints

_________________________
Pasos para Probar la API:
=========================
OPCION 1 - Acceder por la web:
1. Entrar a la siguiente URL: "http://cinebd.ddns.net:1320/swagger/index.html#/" y probar los endpoints de la API (El servidor estara disponible hasta el jueves a la tarde)

OPCION 2 - Correr la API localmente:
Una vez se completaron los pasos 1. 2. 3. y 4. de la seccion anterior se podra probar la API con comandos curl desde la consola, con postman o con swagger localmente

- Con comando de la consola:
	Endpoint GET  /precios/{idFuncion}
	Formato:	curl "http://localhost:1320/v1/precio/x"
	Ejemplo:	curl "http://localhost:1320/v1/precio/1"  -> {"error":"Error 1644 (45000): La funcion ya ha acabado"}
	Ejemplo:	curl "http://localhost:1320/v1/precio/6"  -> {"precio":2200}
	Ejemplo:	curl "http://localhost:1320/v1/precio/60" -> {"error":"Error 1644 (45000): Funcion inexistente"}

	Endpoint GET  /reporte/ocupacion
	Formato:	curl "http://localhost:1320/v1/ocupacion/reporte?idPelicula=x&fechaInicio=xxxx-xx-xx&fechaFin=xxxx-xx-xx"
	Ejemplo:	curl "http://localhost:1320/v1/ocupacion/reporte?idPelicula=1&fechaInicio=2026-01-01&fechaFin=2027-01-01"   -> Reorte de las funciones de la pelicula con ID 1 desde el 1 de enero de 2026 al 1 de enero de 2027
	Ejemplo:	curl "http://localhost:1320/v1/ocupacion/reporte?idPelicula=1&fechaInicio=20264-01-01&fechaFin=2027-01-01"  -> {"error": "Fecha de inicio o fin invalida"}
	Ejemplo:	curl "http://localhost:1320/v1/ocupacion/reporte?idPelicula=100&fechaInicio=2026-01-01&fechaFin=2027-01-01" -> {"error": "Error 1644 (45000): Pelicula inexistente"}

	Endpoint POST /reservas
	Formato:	curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"xxxxxxxxxxx\",\"idButaca\": xx,\"idFuncion\": xx}"
	Ejemplo:	curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 17,\"idFuncion\": 6}"      -> {"mensaje": "Reserva creada exitosamente"}
	Ejemplo:	curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"1111155637850\",\"idButaca\": 19,\"idFuncion\": 6}" -> {"error":"Ingrese DNI valido"}
	Ejemplo:	curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 1,\"idFuncion\": 6}"       -> {"error":"La butaca no pertenece a la sala de la funcion"}
	Ejemplo:	curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 1,\"idFuncion\": 60}"      -> {"error":"Funcion inexistente"}
	Ejemplo, ejecutar los siguientes 5 comandos para probar que un DNI solo puede tener 4 reservas activas por dia:
			curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 22,\"idFuncion\": 8}"  -> {"mensaje": "Reserva creada exitosamente"}
			curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 23,\"idFuncion\": 8}"  -> {"mensaje": "Reserva creada exitosamente"}
			curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 24,\"idFuncion\": 8}"  -> {"mensaje": "Reserva creada exitosamente"}
			curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 25,\"idFuncion\": 8}"  -> {"mensaje": "Reserva creada exitosamente"}
			curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 26,\"idFuncion\": 8}"  -> {"error":"Error 1644 (45000): Numero de reservas para ese dia agotado"}
			curl -X POST "http://localhost:1320/v1/reservas" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"dni\": \"55637850\",\"idButaca\": 19,\"idFuncion\": 14}" -> {"mensaje": "Reserva creada exitosamente"}

	Endpoint GET  /cartelera
	Formato:	curl "http://localhost:1320/v1/cartelera?fechaInicio=xxxx-xx-xx&fechaFin=xxxx-xx-xx"
	Ejemplo:	curl "http://localhost:1320/v1/cartelera?fechaInicio=2026-01-01&fechaFin=2027-01-01"  -> La cartelera desde el 1 de enero de 2026 al 1 de enero de 2027
 	Ejemplo:	curl "http://localhost:1320/v1/cartelera?fechaInicio=20264-01-01&fechaFin=2027-01-01" -> {"error": "Fecha de inicio o fin invalida"}

* Si se reemplaza "localhost" por "cinebd.ddns.net" en la URL del comando curl se hace la misma consulta pero al servidor corriendo en mi computadora

- Con Postman
1. Correr el agente local de postman
2. Ir a la siguiguiente URL: https://gerovargasherrera-5870335.postman.co/workspace/Vargas-Herrera%2C-Ger%C3%B3nimo's-Work~1ffdbc46-2378-4c30-8d18-8f4a1c217b9f/request/53822116-ef63eab5-497d-48d5-801f-c4e9abab94e3?action=share&creator=53822116

- Con Swagger
1. Ir a la siguiente URL: localhost:1320/swagger/index.html#/










