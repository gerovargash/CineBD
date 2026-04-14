-- ===========================================================
-- Pruebas tabla Butacas
-- ===========================================================
SELECT * FROM Butacas;
DELETE FROM Butacas WHERE IdButaca = 100;

-- Prueba IdButaca
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (1 	 	 , 5	 , 100		, 9	  , 9	   , "A"   , NULL		  );
             
-- Prueba FK
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (70 	 , 500	 , 100		, 9	  , 9	   , "A"   , NULL	  	  );			             

-- Prueba NroButaca
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (100 	 , 1	 , 1		, 9	  , 9	   , "A"   , NULL		  );
             
-- Prueba Fila y Columna por sala             
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (100 	 , 1	 , 100		, 1	  , 1	   , "A"   , NULL		  );

-- Prueba Estado = "A" o "I"			
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (100 	 , 1	 , 100		, 9	  , 1	   , "C"   , NULL		  );     
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (100 	 , 1	 , 100		, 9	  , 1	   , "a"   , NULL		  );
INSERT INTO Butacas (IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones)
			 VALUES (100 	 , 1	 , 100		, 9	  , 1	   , "i"   , NULL		  );             
			

-- ======================================================================================================================
-- Pruebas tabla Funciones
-- ======================================================================================================================
SELECT * FROM Funciones;
DELETE FROM Funciones WHERE IdFuncion = 30;

-- Prueba PK
INSERT INTO funciones (IDFuncion ,IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1		 , 1	 	, 1		, "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	   , NULL	 , 1000  , "A"   , NULL			);

-- Prueba unicidad del IdFuncion
INSERT INTO funciones (IDFuncion ,IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (4		 , 1	 	, 1		, "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	   , NULL	 , 1000  , "A"   , NULL			);
               
-- Prueba FK               
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1000	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , 1000  , "A"   , NULL		 );
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 100	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , 1000  , "A"   , NULL		 );               

-- Prueba Estado = "A" o "I"
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , 1000  , "C"   , NULL		 );
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , 1000  , "a"   , NULL		 );
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , 1000  , "i"   , NULL		 );				

-- Prueba precio
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , 0000  , "A"   , NULL		 );
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", NULL	    , NULL	  , -100  , "A"   , NULL		 );
               
-- Prueba FechaInicio < FechaFin			
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio		  , FechaFin		     , Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", "2026-04-13 14:00:00", "2026-04-13 14:00:00", 0000  , "A"   , NULL		    );
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio		  , FechaFin		     , Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 15:41:00", "2026-04-13 14:00:00", "2026-04-12 14:00:00", 0000  , "A"   , NULL		    );
               
-- Prueba FechaProbableInicio <= FechaProbableFin
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-12 15:41:00", NULL	    , NULL	  , 0000  , "A"   , NULL		 );               
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio  , FechaProbableFin     , FechaInicio, FechaFin, Precio, Estado, Observaciones)
			   VALUES (1	 	 , 1	 , "2026-04-13 14:00:00", "2026-04-13 14:00:00", NULL	    , NULL	  , 0000  , "A"   , NULL		 );               
               
               
-- ======================================================================================================================
-- Pruebas tabla Generos
-- ======================================================================================================================
SELECT * FROM Generos;
DELETE FROM generos WHERE IdGenero = 50;

-- Prueba PK
INSERT INTO generos VALUES (1, "Romance", "A");

-- Prueba Estado = "A" o "I"
INSERT INTO generos VALUES (1, "Prueba", "C");
INSERT INTO generos VALUES (1, "Prueba", "a");
INSERT INTO generos VALUES (1, "Prueba", "i");

-- Prueba nombre Genero no repetido
INSERT INTO generos VALUES (50, "Romance", "A");
INSERT INTO generos VALUES (50, "romance", "A");
INSERT INTO generos VALUES (50, "Románce", "A");


-- ======================================================================================================================
-- Pruebas tabla Peliculas
-- ======================================================================================================================
SELECT * FROM Peliculas;
DELETE FROM Peliculas WHERE IdPelicula = 100;

-- Prueba PK
INSERT INTO peliculas (IdPelicula, IdGenero, Pelicula, Sinopsis, Duracion, Actores, Estado, Observaciones)
			   VALUES (1		 , 1	   , "Prueba", "Prueba", 100	 , "Geron", "A"	  , NULL		 );
               
-- Prueba FK
INSERT INTO peliculas (IdPelicula, IdGenero, Pelicula, Sinopsis, Duracion, Actores, Estado, Observaciones)
			   VALUES (100		 , 100	   , "Prueba", "Prueba", 100	 , "Geron", "A"	  , NULL		 );            
               
-- Prueba nombre Pelicula no repetido               
INSERT INTO peliculas (IdPelicula, IdGenero, Pelicula	, Sinopsis, Duracion, Actores, Estado, Observaciones)
			   VALUES (100		 , 1 	   , "John Wick", "Prueba", 100	 	, "Geron", "A"	 , NULL		    );


-- ======================================================================================================================
-- Pruebas tabla Reserva
-- ======================================================================================================================
SELECT * FROM Reservas;
DELETE FROM Reservas WHERE IdReserva =52;

-- Prueba PK (Da error primero la UI_IdFuncionIdButaca)
INSERT INTO reservas (IdFuncion, IdPelicula, IdSala, IdButaca, DNI	   , FechaAlta			  , FechaBaja, EstaPagada, Observaciones)
			  VALUES (1	   	   , 1		   , 1	   , 1	     , 44666777, "2026-02-16 19:00:00", NULL	 , "S" 		 , NULL			);	                

-- Prueba IdReserva
INSERT INTO reservas (IdReserva, IdFuncion, IdPelicula, IdSala, IdButaca, DNI	  , FechaAlta			 , FechaBaja, EstaPagada, Observaciones)
			  VALUES (1		   , 1		  , 1		  , 1	  , 1	    , 44666777, "2026-02-16 19:00:00", NULL		, "S" 		, NULL		   );
              
-- Prueba FK
INSERT INTO reservas (IdFuncion, IdPelicula, IdSala, IdButaca, DNI	   , FechaAlta			  , FechaBaja, EstaPagada, Observaciones)
			  VALUES (100	   , 1		   , 1	   , 6	     , 44666777, "2026-02-16 19:00:00", NULL	 , "S" 		 , NULL			);			
INSERT INTO reservas (IdFuncion, IdPelicula, IdSala, IdButaca, DNI	   , FechaAlta			  , FechaBaja, EstaPagada, Observaciones)
			  VALUES (1	   	   , 2		   , 1	   , 6	     , 44666777, "2026-02-16 19:00:00", NULL	 , "S" 		 , NULL			);			              
INSERT INTO reservas (IdFuncion, IdPelicula, IdSala, IdButaca, DNI	   , FechaAlta			  , FechaBaja, EstaPagada, Observaciones)
			  VALUES (1	   	   , 1		   , 2	   , 6	     , 44666777, "2026-02-16 19:00:00", NULL	 , "S" 		 , NULL			);	              
INSERT INTO reservas (IdFuncion, IdPelicula, IdSala, IdButaca, DNI	   , FechaAlta			  , FechaBaja, EstaPagada, Observaciones)
			  VALUES (1	   	   , 1		   , 1	   , 10	     , 44666777, "2026-02-16 19:00:00", NULL	 , "S" 		 , NULL			);	      


-- ======================================================================================================================
-- Pruebas tabla Salas
-- ======================================================================================================================          
SELECT * FROM Salas;

-- Prueba nombre Sala no repetido
INSERT INTO salas (IdSala, Sala	   , TipoSala, Direccion   , Estado, Observaciones)
		   VALUES (20 	 , "Sala 1", "C"	 , "Quito 2599", "A"   , NULL);
