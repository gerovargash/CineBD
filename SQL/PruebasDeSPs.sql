-- ===========================================================
-- Pruebas SP DeterminarPrecioDeEntrada
-- ===========================================================
SELECT * FROM Funciones;
SELECT f.IdFuncion, f.IdSala, f.FechaFin, p.IdPelicula, g.Genero FROM Funciones f INNER JOIN Peliculas p ON f.IdPelicula = p.IdPelicula INNER JOIN Generos g ON p.IdGenero = g.IdGenero;

-- Llamada normal sobre una funcion sin nada especial
SELECT Precio FROM Funciones WHERE IdFuncion = 5;
CALL DeterminarPrecioDeEntrada(5);

-- Llamada a una funcion con genero especial (* 1.10)
SELECT f.Precio, f.IdSala, g.Genero FROM Funciones f INNER JOIN Peliculas p ON f.IdPelicula = p.IdPelicula INNER JOIN Generos g ON p.IdGenero = g.IdGenero WHERE IdFuncion = 22;
CALL DeterminarPrecioDeEntrada(22);	

-- Llamada a una funcion con sala especial (* 1.05)
SELECT f.Precio, f.IdSala, g.Genero FROM Funciones f INNER JOIN Peliculas p ON f.IdPelicula = p.IdPelicula INNER JOIN Generos g ON p.IdGenero = g.IdGenero WHERE IdFuncion = 3;
CALL DeterminarPrecioDeEntrada(3);

-- Llamada a una funcion con genero y sala especial (* 1.10 * 1.05)
SELECT f.Precio, f.IdSala, g.Genero FROM Funciones f INNER JOIN Peliculas p ON f.IdPelicula = p.IdPelicula INNER JOIN Generos g ON p.IdGenero = g.IdGenero WHERE IdFuncion = 23;
CALL DeterminarPrecioDeEntrada(23);

-- Llamada a una funcion inactiva
SELECT Precio, Estado FROM Funciones WHERE IdFuncion = 20;
CALL DeterminarPrecioDeEntrada(20);

-- Llamada a una funcion ya finalizada
SELECT Precio, FechaFin FROM Funciones WHERE IdFuncion = 4;
CALL DeterminarPrecioDeEntrada(4);

-- Prueba llamada funcion inexistente
CALL DeterminarPrecioDeEntrada(-1);
CALL DeterminarPrecioDeEntrada(1000);


-- ===========================================================
-- Pruebas SP ReporteDeOcupaciónPorPelicula
-- ===========================================================
SELECT * FROM Funciones ORDER BY IdPelicula;
SELECT * FROM Reservas ORDER BY IdFuncion;

-- Llamada normal sobre una pelicula 
SELECT * FROM Reservas WHERE IdPelicula = 1 ORDER BY IdFuncion;		-- RECORDAR que no se tendran en cuenta funciones sin FechaInicio
CALL ReporteDeOcupacionPorPelicula(1, "2026-01-01", "2026-08-01");

-- Llamada con funciones inactivas
SELECT * FROM Funciones WHERE IdPelicula = 10;
SELECT * FROM Reservas WHERE IdPelicula = 10 ORDER BY IdFuncion;
CALL ReporteDeOcupacionPorPelicula(10, "2026-01-01", "2026-06-01");

-- Llamada con peliculas sin FechaInicio y sin reservas
SELECT * FROM Funciones WHERE IdPelicula = 4;
SELECT * FROM Reservas WHERE IdPelicula = 4 ORDER BY IdFuncion;
CALL ReporteDeOcupacionPorPelicula(4, "2026-01-01", "2026-06-01");

SELECT * FROM Funciones WHERE IdPelicula = 3;
SELECT * FROM Reservas WHERE IdPelicula = 3 ORDER BY IdFuncion;
CALL ReporteDeOcupacionPorPelicula(3, "2026-01-01", "2026-06-01");

-- Llamada con fechaInicio > fechaFin
CALL ReporteDeOcupacionPorPelicula(1, "2026-06-01", "2026-01-01");

-- Prueba llamada pelicula inexistente
CALL ReporteDeOcupacionPorPelicula(40, "2026-01-01", "2026-06-01");

-- ===========================================================
-- Pruebas SP ReservarButacaConDNI
-- ===========================================================
SELECT * FROM Funciones;
SELECT * FROM Butacas ORDER BY IdSala;
SELECT * FROM Reservas;
-- DELETE FROM Reservas WHERE IdReserva = 69;

-- Llamado de una reserva normal 
CALL ReservarButacaConDNI(7, 20, '55637850');
DELETE FROM Reservas WHERE IdReserva = LAST_INSERT_ID();

-- Llamado de una reserva a una funcion inactiva
CALL ReservarButacaConDNI(20, 15, 44637850);

-- Llamado de una reserva a una funcion inexistente
CALL ReservarButacaConDNI(190, 15, 44637850);

-- Llamado de una reserva a una funcion cuando ese DNI ya tiene 4 reservas activas hechas para ese dia
SELECT * FROM Reservas WHERE DNI = 44556677;
CALL ReservarButacaConDNI(1, 3, 44556677);

-- Llamado de una reserva a una funcion cuando la butaca no pertenece a la sala de la funcion
CALL ReservarButacaConDNI(7, 1, 44556677);

/*SELECT * FROM Reservas r
	INNER JOIN Funciones f ON r.IdFuncion = f.IdFuncion
WHERE DNI = "44637850" AND r.EstaPagada = "S";

SELECT DATE(FechaInicio) FROM Funciones;

SELECT COUNT(f.FechaInicio) FROM Reservas AS r 
INNER JOIN Funciones AS f ON r.IdFuncion = f.IdFuncion
WHERE r.DNI = "44637850" AND r.EstaPagada = "S" AND r.FechaBaja IS NULL AND DATE(f.FechaInicio) = '2026-04-13'
GROUP BY DATE(f.FechaInicio);

SELECT COUNT(DATE(f.FechaProbableInicio))
FROM Reservas AS r
	INNER JOIN Funciones AS f ON r.IdFuncion = f.IdFuncion
WHERE  r.DNI = "44637850" AND r.EstaPagada = "S" AND r.FechaBaja IS NULL AND DATE(f.FechaProbableInicio) = '2026-04-11';*/

-- ===========================================================
-- Pruebas SP DameCartelera
-- ===========================================================
SELECT * FROM Funciones;
SELECT * FROM Butacas ORDER BY IdSala;
SELECT * FROM Reservas;

-- Llamado normal a la funcion
CALL DameCartelera("2026-01-01", "2026-05-01");

-- Llamado a la funcion con una butaca inactiva
UPDATE Butacas SET Estado = "I" WHERE IdButaca = 3;
CALL DameCartelera("2026-01-01", "2026-05-01");
UPDATE Butacas SET Estado = "A" WHERE IdButaca = 3;

