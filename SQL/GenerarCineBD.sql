--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      GeroSRL
-- Project :      ModeloERStudio.DM1
-- Author :       Gero
--
-- Date Created : Thursday, April 09, 2026 10:50:33
-- Target DBMS : MySQL 5.x
--

DROP DATABASE bdcine;
CREATE DATABASE IF NOT EXISTS bdcine;
USE bdcine;

DROP TABLE Reservas;
DROP TABLE Butacas;
DROP TABLE Funciones;
DROP TABLE Salas;
DROP TABLE Peliculas;
DROP TABLE Generos;

-- =========================================================================================================================================
-- CREACION DE TABLAS E INDICES
-- =========================================================================================================================================

-- 
-- TABLE: Butacas 
--
CREATE TABLE Butacas(
    IdButaca         INT             NOT NULL,
    IdSala           SMALLINT        NOT NULL,
    NroButaca        SMALLINT        NOT NULL,
    Fila             SMALLINT        NOT NULL,
    Columna          SMALLINT        NOT NULL,
    Estado           CHAR(1)         NOT NULL,
    Observaciones    VARCHAR(255),
    PRIMARY KEY (IdButaca, IdSala)
)ENGINE=INNODB;


-- 
-- TABLE: Funciones 
--
CREATE TABLE Funciones(
    IdFuncion              INT               AUTO_INCREMENT,
    IdPelicula             INT               NOT NULL,
    IdSala                 SMALLINT          NOT NULL,
    FechaProbableInicio    DATETIME          NOT NULL,
    FechaProbableFin       DATETIME          NOT NULL,
    FechaInicio            DATETIME,
    FechaFin               DATETIME,
    Precio                 DECIMAL(12, 2)    NOT NULL,
    Estado                 CHAR(1)           NOT NULL,
    Observaciones          VARCHAR(255),
    PRIMARY KEY (IdFuncion, IdPelicula, IdSala)
)ENGINE=INNODB;


-- 
-- TABLE: Generos 
--
CREATE TABLE Generos(
    IdGenero    SMALLINT       NOT NULL,
    Genero      VARCHAR(50)    NOT NULL,
    Estado      CHAR(1)        NOT NULL,
    PRIMARY KEY (IdGenero)
)ENGINE=INNODB;


-- 
-- TABLE: Peliculas 
--
CREATE TABLE Peliculas(
    IdPelicula       INT             NOT NULL,
    IdGenero         SMALLINT        NOT NULL,
    Pelicula         VARCHAR(100)    NOT NULL,
    Sinopsis         TEXT            NOT NULL,
    Duracion         SMALLINT        NOT NULL,
    Actores          TEXT            NOT NULL,
    Estado           CHAR(1)         NOT NULL,
    Observaciones    VARCHAR(255),
    PRIMARY KEY (IdPelicula)
)ENGINE=INNODB;


-- 
-- TABLE: Reservas 
--
CREATE TABLE Reservas(
    IdReserva        BIGINT          AUTO_INCREMENT,
    IdFuncion        INT             NOT NULL,
    IdPelicula       INT             NOT NULL,
    IdSala           SMALLINT        NOT NULL,
    IdButaca         INT             NOT NULL,
    DNI              VARCHAR(11)     NOT NULL,
    FechaAlta        DATETIME        NOT NULL,
    FechaBaja        DATETIME,
    EstaPagada       CHAR(1)         NOT NULL,
    Observaciones    VARCHAR(255),
    PRIMARY KEY (IdReserva, IdFuncion, IdPelicula, IdSala, IdButaca)
)ENGINE=INNODB;


-- 
-- TABLE: Salas 
--
CREATE TABLE Salas(
    IdSala           SMALLINT        NOT NULL,
    Sala             VARCHAR(60)     NOT NULL,
    TipoSala         CHAR(1)         NOT NULL,
    Direccion        VARCHAR(60)     NOT NULL,
    Estado           CHAR(1)         NOT NULL,
    Observaciones    VARCHAR(255),
    PRIMARY KEY (IdSala)
)ENGINE=INNODB;


-- 
-- INDEX: UI_IdButaca 
--
CREATE UNIQUE INDEX UI_IdButaca ON Butacas(IdButaca);

-- 
-- INDEX: UI_NroButaca_IdSala 
--
CREATE UNIQUE INDEX UI_NroButaca_IdSala ON Butacas(NroButaca, IdSala);

-- 
-- INDEX: Ref17 
--
CREATE INDEX Ref17 ON Butacas(IdSala);

-- 
-- INDEX: UI_IdFuncion 
--
CREATE UNIQUE INDEX UI_IdFuncion ON Funciones(IdFuncion);

-- 
-- INDEX: Ref35 
--
CREATE INDEX Ref35 ON Funciones(IdPelicula);

-- 
-- INDEX: Ref16 
--
CREATE INDEX Ref16 ON Funciones(IdSala);

-- 
-- INDEX: UI_Genero 
--
CREATE UNIQUE INDEX UI_Genero ON Generos(Genero);

-- 
-- INDEX: Ref24 
--
CREATE INDEX Ref24 ON Peliculas(IdGenero);

-- 
-- INDEX: UI_IdReserva 
--
CREATE UNIQUE INDEX UI_IdReserva ON Reservas(IdReserva);

-- 
-- INDEX: Ref48 
--
CREATE INDEX Ref48 ON Reservas(IdSala, IdPelicula, IdFuncion);

-- 
-- INDEX: Ref59 
--
CREATE INDEX Ref59 ON Reservas(IdSala, IdButaca);

-- 
-- INDEX: UI_Sala 
--
CREATE UNIQUE INDEX UI_Sala ON Salas(Sala);

-- 
-- TABLE: Butacas 
--
ALTER TABLE Butacas ADD CONSTRAINT RefSalas7 
    FOREIGN KEY (IdSala)
    REFERENCES Salas(IdSala);

-- 
-- TABLE: Funciones 
--
ALTER TABLE Funciones ADD CONSTRAINT RefPeliculas5 
    FOREIGN KEY (IdPelicula)
    REFERENCES Peliculas(IdPelicula);

ALTER TABLE Funciones ADD CONSTRAINT RefSalas6 
    FOREIGN KEY (IdSala)
    REFERENCES Salas(IdSala);

-- 
-- TABLE: Peliculas 
--
ALTER TABLE Peliculas ADD CONSTRAINT RefGeneros4 
    FOREIGN KEY (IdGenero)
    REFERENCES Generos(IdGenero);

-- 
-- TABLE: Reservas 
--
ALTER TABLE Reservas ADD CONSTRAINT RefFunciones8 
    FOREIGN KEY (IdFuncion, IdPelicula, IdSala)
    REFERENCES Funciones(IdFuncion, IdPelicula, IdSala);

ALTER TABLE Reservas ADD CONSTRAINT RefButacas9 
    -- FOREIGN KEY (IdSala, IdButaca)
    -- REFERENCES Butacas(IdButaca, IdSala)
    
    FOREIGN KEY (IdButaca, IdSala)
    REFERENCES Butacas(IdButaca, IdSala)
    
    -- ESTA SI QUE NO
    -- FOREIGN KEY (IdButaca)
    -- REFERENCES Butacas(IdButaca)
;

-- Reglas de itegridad de los datos
-- 1.
ALTER TABLE Funciones ADD CONSTRAINT checkPrecioMayorCero CHECK (precio > 0);

-- 2.
ALTER TABLE Butacas   ADD CONSTRAINT checkEstadoButacas   CHECK (estado = "A" OR estado = "I");
ALTER TABLE Funciones ADD CONSTRAINT checkEstadoFunciones CHECK (estado = "A" OR estado = "I");
ALTER TABLE Generos   ADD CONSTRAINT checkEstadoGeneros   CHECK (estado = "A" OR estado = "I");
ALTER TABLE Peliculas ADD CONSTRAINT checkEstadoPeliculas CHECK (estado = "A" OR estado = "I");
ALTER TABLE Salas     ADD CONSTRAINT checkEstadoSalas     CHECK (estado = "A" OR estado = "I");

-- 3.
ALTER TABLE Funciones ADD CONSTRAINT checkFecha CHECK (FechaInicio < FechaFin);
ALTER TABLE Funciones ADD CONSTRAINT checkFechaProbable CHECK (FechaProbableInicio < FechaProbableFin);

-- 4. Las constraints que faltarian para salas, generos y butacas no las puse aqui ya que al ser AK no pueden ser
-- repetidas de todas formas
ALTER TABLE Peliculas ADD CONSTRAINT UniquePelicula UNIQUE (Pelicula);

-- 5. Similar al punto 4 los indices que no agregue aqui es por que ya fueron creados 
ALTER TABLE Funciones ADD INDEX I_FechaInicio (FechaInicio);
ALTER TABLE Reservas ADD UNIQUE INDEX UI_IdFuncionIdButaca (IdFuncion, IdButaca);

-- Correcciones de collation
ALTER TABLE Butacas   MODIFY Estado CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;
ALTER TABLE Funciones MODIFY Estado CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;
ALTER TABLE Generos   MODIFY Estado CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;
ALTER TABLE Peliculas MODIFY Estado CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;
ALTER TABLE Reservas  MODIFY Estado CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;
ALTER TABLE Salas 	  MODIFY Estado CHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;

-- Indices adicionales
ALTER TABLE Butacas ADD UNIQUE INDEX UI_IdSalaFilaColumna (IdSala, Fila, Columna);


-- =========================================================================================================================================
-- POBLAR TABLAS
-- =========================================================================================================================================

-- Poblar tabla de generos
INSERT INTO generos (IdGenero, Genero, Estado) VALUES
(1,  'Acción',         'A'),
(2,  'Aventura',       'A'),
(3,  'Comedia',        'A'),
(4,  'Drama',          'A'),
(5,  'Terror',         'A'),
(6,  'Ciencia Ficción','A'),
(7,  'Fantasía',       'A'),
(8,  'Romance',        'A'),
(9,  'Thriller',       'A'),
(10, 'Animación',      'A'),
(11, 'Documental',     'A'),
(12, 'Musical',        'A'),
(13, 'Western',        'I'),
(14, 'Film Noir',      'I'),
(15, 'Suspenso',       'A'),
(16, 'Estreno',        'A'),
(17, '3D',		       'A');


-- Poblar tabla de salas
INSERT INTO salas (IdSala, Sala, TipoSala, Direccion, Estado, Observaciones) VALUES
(1, 'Sala 1', 'C', 'Av. Mitre 1200'	, 'A', 'Sala principal grande'),
(2, 'Sala 2', 'C', 'Av. Mitre 1200'	, 'A', 'Sala clásica pequeña'),
(3, 'Sala 3', 'C', 'Av. Sarmiento 599'	, 'A', 'Sala principal grande'),
(4, 'Sala 4', '3', 'Av. Sarmiento 599'	, 'A', 'Sala 3D mas grande');


-- Poblar tabla de peliculas
INSERT INTO peliculas (IdPelicula, IdGenero ,Pelicula, Sinopsis, Duracion, Actores, Estado, Observaciones) VALUES
(1,  1, 'John Wick',
    'Un ex asesino vuelve al mundo del crimen para vengarse de quienes mataron a su perro.',
    101, 'Keanu Reeves, Michael Nyqvist, Alfie Allen', 'A', NULL),
(2,  1, 'Mad Max: Fury Road',
    'En un mundo postapocalíptico, un hombre ayuda a un grupo de mujeres a escapar de un tirano.',
    120, 'Tom Hardy, Charlize Theron, Nicholas Hoult', 'A', NULL),
(3,  2, 'Indiana Jones y el Arca Perdida',
    'Un arqueólogo compite contra los nazis para encontrar el Arca de la Alianza.',
    115, 'Harrison Ford, Karen Allen, Paul Freeman', 'A', NULL),
(4,  2, 'Jurassic Park',
    'Un parque temático con dinosaurios clonados se convierte en una trampa mortal.',
    127, 'Sam Neill, Laura Dern, Jeff Goldblum', 'A', NULL),
(5,  3, 'El Gran Lebowski',
    'Un hombre tranquilo es confundido con un millonario y se ve envuelto en un secuestro.',
    117, 'Jeff Bridges, John Goodman, Julianne Moore', 'A', NULL),
(6,  3, 'Superbad',
    'Dos amigos intentan conseguir alcohol para una fiesta antes de terminar la secundaria.',
    113, 'Jonah Hill, Michael Cera, Emma Stone', 'A', 'Apta para mayores de 16'),
(7,  4, 'El Padrino',
    'La saga de una familia mafiosa italiana que lucha por mantener su poder en Nueva York.',
    175, 'Marlon Brando, Al Pacino, James Caan', 'A', NULL),
(8,  4, 'Forrest Gump',
    'Un hombre de Alabama con baja inteligencia vive sin querer los momentos clave de la historia americana.',
    142, 'Tom Hanks, Robin Wright, Gary Sinise', 'A', NULL),
(9,  5, 'El Conjuro',
    'Dos investigadores paranormales ayudan a una familia aterrorizada por una presencia maligna.',
    112, 'Patrick Wilson, Vera Farmiga, Ron Livingston', 'A', 'Apta para mayores de 16'),
(10, 5, 'Hereditary',
    'Tras la muerte de la abuela, una familia descubre oscuros secretos sobre su linaje.',
    127, 'Toni Collette, Alex Wolff, Milly Shapiro', 'A', 'Apta para mayores de 18'),
(11, 6, 'Interstellar',
    'Un grupo de astronautas viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad.',
    169, 'Matthew McConaughey, Anne Hathaway, Jessica Chastain', 'A', NULL),
(12, 6, 'Matrix',
    'Un programador descubre que la realidad es una simulación controlada por máquinas.',
    136, 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss', 'A', NULL),
(13, 7, 'El Señor de los Anillos: La Comunidad del Anillo',
    'Un hobbit emprende un peligroso viaje para destruir un anillo de poder que amenaza al mundo.',
    178, 'Elijah Wood, Ian McKellen, Viggo Mortensen', 'A', NULL),
(14, 7, 'Harry Potter y la Piedra Filosofal',
    'Un niño descubre que es mago y comienza su educación en una escuela de hechicería.',
    152, 'Daniel Radcliffe, Emma Watson, Rupert Grint', 'A', 'Apta para todo público'),
(15, 8, 'Titanic',
    'Un romance imposible entre dos jóvenes de clases sociales distintas a bordo del famoso transatlántico.',
    195, 'Leonardo DiCaprio, Kate Winslet, Billy Zane', 'A', NULL),
(16, 8, 'Orgullo y Prejuicio',
    'Una joven inglesa del siglo XIX debe equilibrar el amor y las expectativas sociales de su época.',
    129, 'Keira Knightley, Matthew Macfadyen, Judi Dench', 'A', NULL),
(17, 9, 'El Silencio de los Inocentes',
    'Una agente del FBI busca a un asesino en serie con la ayuda de un psiquiatra caníbal encarcelado.',
    118, 'Jodie Foster, Anthony Hopkins, Scott Glenn', 'A', 'Apta para mayores de 18'),
(18, 9, 'Gone Girl',
    'Un hombre se convierte en el principal sospechoso tras la misteriosa desaparición de su esposa.',
    149, 'Ben Affleck, Rosamund Pike, Neil Patrick Harris', 'A', NULL),
(19, 10, 'El Rey León',
    'Un cachorro de león debe reclamar su reino tras la muerte de su padre.',
    88, 'Voces: Matthew Broderick, Jeremy Irons, James Earl Jones', 'A', 'Apta para todo público'),
(20, 10, 'Toy Story',
    'Los juguetes de un niño cobran vida y deben aprender a convivir cuando llega uno nuevo.',
    81, 'Voces: Tom Hanks, Tim Allen, Don Rickles', 'A', 'Apta para todo público'),
(21, 11, 'Free Solo',
    'El escalador Alex Honnold intenta escalar el El Capitan en Yosemite sin cuerdas ni equipo de seguridad.',
    100, 'Alex Honnold, Tommy Caldwell', 'A', NULL),
(22, 11, 'El Planeta Azul',
    'David Attenborough guía un recorrido visual por los ecosistemas más asombrosos de los océanos.',
    99, 'Narrador: David Attenborough', 'A', NULL),
(23, 12, 'La La Land',
    'Un pianista de jazz y una actriz aspirante se enamoran mientras persiguen sus sueños en Los Ángeles.',
    128, 'Ryan Gosling, Emma Stone, John Legend', 'A', NULL),
(24, 12, 'Bohemian Rhapsody',
    'La historia del ascenso de Freddie Mercury y la banda Queen hasta convertirse en leyendas del rock.',
    134, 'Rami Malek, Lucy Boynton, Gwilym Lee', 'A', NULL),
(25, 15, 'Vértigo',
    'Un detective con acrofobia es contratado para seguir a una mujer y queda obsesionado con ella.',
    128, 'James Stewart, Kim Novak, Barbara Bel Geddes', 'A', NULL),
(26, 6, "Star Wars: Episodio IV - Una nueva esperanza (1977)",
	'Pelicula sobre la guerra de las galaxias',
    121, 'Mark Hamill, Harrison Ford, Carrie Fisher', 'A', NULL),
(27, 16, "El Eternauta",
	'El Eternauta es un sobreviviente...',
    125, 'Ricardo Darin', 'A', NULL),
(28, 17, "Mafalda",
	'Mafalda es una ninia...',
    125, 'Guillermo Francella', 'A', NULL);


-- Poblar tabla de butacas
INSERT INTO butacas (IdButaca, IdSala ,NroButaca, Fila, Columna, Estado, Observaciones) VALUES
(1	, 1, 1, 1, 1, "A", NULL),
(2	, 1, 2, 1, 2, "A", NULL),
(3	, 1, 3, 1, 3, "A", NULL),
(4	, 1, 4, 1, 4, "A", NULL),
(5	, 1, 5, 1, 5, "A", NULL),
(6	, 1, 6, 2, 1, "A", NULL),
(7	, 1, 7, 2, 2, "A", NULL),

(8	, 2, 1, 1, 1, "A", NULL),
(9	, 2, 2, 1, 2, "A", NULL),
(10	, 2, 3, 1, 3, "A", NULL),
(11	, 2, 4, 1, 4, "A", NULL),
(12	, 2, 5, 2, 1, "A", NULL),
(13	, 2, 6, 2, 2, "A", NULL),
(14	, 2, 7, 2, 3, "A", NULL),

(15	, 3, 1, 1, 1, "A", NULL),
(16	, 3, 2, 1, 2, "A", NULL),
(17	, 3, 3, 1, 3, "A", NULL),
(18	, 3, 4, 1, 4, "A", NULL),
(19	, 3, 5, 2, 1, "A", NULL),
(20	, 3, 6, 2, 2, "A", NULL),
(21	, 3, 7, 2, 3, "A", NULL),

(22	, 4, 1, 1, 1, "A", NULL),
(23	, 4, 2, 1, 2, "A", NULL),
(24	, 4, 3, 1, 3, "A", NULL),
(25	, 4, 4, 1, 4, "A", NULL),
(26	, 4, 5, 1, 5, "A", NULL),
(27	, 4, 6, 1, 6, "A", NULL),
(28	, 4, 7, 1, 7, "A", NULL);


-- Poblar tabla de funciones
INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio, FechaProbableFin, FechaInicio, FechaFin, Precio, Estado, Observaciones) VALUES

-- John Wick en Sala 1
(1,  1, '2026-04-10 14:00:00', '2026-04-10 15:41:00', '2026-04-10 14:05:00', '2026-04-10 15:45:00', 2500.00, 'A', NULL),
(1,  1, '2026-04-10 18:00:00', '2026-04-10 19:41:00', NULL,                  NULL,                  2500.00, 'A', NULL),
(1,  1, '2026-04-10 21:00:00', '2026-04-10 22:41:00', NULL,                  NULL,                  2500.00, 'A', NULL),

-- Mad Max en Sala 2
(2,  2, '2026-04-10 15:00:00', '2026-04-10 17:00:00', '2026-04-10 15:10:00', '2026-04-10 17:05:00', 2800.00, 'A', NULL),
(2,  2, '2026-04-10 20:00:00', '2026-04-10 22:00:00', NULL,                  NULL,                  2800.00, 'A', NULL),

-- Indiana Jones en 3
(3,  3, '2026-04-11 13:00:00', '2026-04-11 14:55:00', NULL,                  NULL,                  2200.00, 'A', NULL),
(3,  3, '2026-04-11 17:00:00', '2026-04-11 18:55:00', NULL,                  NULL,                  2200.00, 'A', NULL),
(3,  3, '2026-04-17 13:00:00', '2026-04-17 14:55:00', '2026-04-17 13:00:00', '2026-04-17 14:55:00', 2200.00, 'A', NULL),

-- Jurassic Park en Sala 4
(4,  4, '2026-04-11 16:00:00', '2026-04-11 18:07:00', NULL,                  NULL,                  2400.00, 'A', NULL),
(4,  4, '2026-04-11 20:00:00', '2026-04-11 22:07:00', NULL,                  NULL,                  2400.00, 'A', NULL),

-- Interstellar en Sala 1
(11, 1, '2026-04-13 15:00:00', '2026-04-13 17:49:00', NULL,                  NULL,                  3500.00, 'A', 'Función IMAX'),
(11, 1, '2026-04-13 20:00:00', '2026-04-13 22:49:00', NULL,                  NULL,                  3500.00, 'A', 'Función IMAX'),

-- Matrix en Sala 4
(12, 4, '2026-04-13 18:00:00', '2026-04-13 20:16:00', NULL,                  NULL,                  3200.00, 'A', 'Función Dolby Atmos'),

-- El Señor de los Anillos en Sala 3
(13, 3, '2026-04-14 14:00:00', '2026-04-14 16:58:00', NULL,                  NULL,                  2600.00, 'A', NULL),
(13, 3, '2026-04-14 19:00:00', '2026-04-14 21:58:00', NULL,                  NULL,                  2600.00, 'A', NULL),

-- Titanic en Sala 2
(15, 2, '2026-04-14 17:00:00', '2026-04-14 20:15:00', NULL,                  NULL,                  2800.00, 'A', NULL),

-- El Silencio de los Inocentes en Sala 4
(17, 4, '2026-04-15 21:00:00', '2026-04-15 22:58:00', NULL,                  NULL,                  2500.00, 'A', 'Apta para mayores de 18'),

-- Toy Story en Sala 1
(20, 1, '2026-04-16 10:00:00', '2026-04-16 11:21:00', NULL,                  NULL,                  1800.00, 'A', 'Función familiar'),

-- Bohemian Rhapsody en Sala 2
(24, 2, '2026-04-17 19:00:00', '2026-04-17 21:14:00', NULL,                  NULL,                  2600.00, 'A', NULL),

-- Función cancelada
(10, 3, '2026-04-20 21:00:00', '2026-04-20 23:07:00', NULL,                  NULL,                  2500.00, 'I', 'Función cancelada por mantenimiento de sala'),

-- Función estreno
(26, 3, '2026-04-17 19:00:00', '2026-04-17 21:14:00', NULL,                  NULL,                  2600.00, 'A', NULL),

-- Función 3D
(27, 4, '2026-04-17 19:00:00', '2026-04-17 21:14:00', NULL,                  NULL,                  2600.00, 'A', NULL),

-- Función 3D Sala VIP
(27, 1, '2026-04-17 19:00:00', '2026-04-17 21:14:00', NULL,                  NULL,                  2600.00, 'A', NULL),

-- Funciones de Jurassic Park
(4, 2, '2026-02-17 19:00:00', '2026-02-17 21:14:00', '2026-02-17 19:00:00', '2026-02-17 21:14:00',  2600.00, 'A', NULL),
(4, 1, '2026-02-22 19:00:00', '2026-02-22 21:14:00', '2026-02-22 19:00:00', '2026-02-22 21:14:00',  2600.00, 'A', NULL),
(4, 4, '2026-03-05 19:00:00', '2026-03-05 21:14:00', '2026-03-05 19:00:00', '2026-03-05 21:14:00',  2600.00, 'A', NULL);

/*INSERT INTO funciones (IdPelicula, IdSala, FechaProbableInicio, FechaProbableFin, FechaInicio, FechaFin, Precio, Estado, Observaciones) VALUES*/


-- Poblar tabla de reservas
/*SELECT * FROM Funciones;
SELECT * FROM Butacas;
SELECT * FROM Reservas;*/

INSERT INTO reservas (IdFuncion, IdPelicula, IdSala, IdButaca, DNI, FechaAlta, FechaBaja, EstaPagada, Observaciones) VALUES 
(23, 4, 2, 8 , "44637850", '2026-02-16 19:00:00', NULL, "S", NULL),
(23, 4, 2, 9 , "44637950", '2026-02-16 19:00:00', NULL, "S", NULL),
(23, 4, 2, 10, "44638050", '2026-02-16 19:00:00', NULL, "S", NULL),
(24, 4, 1, 1 , "44637850", '2026-02-21 19:00:00', NULL, "S", NULL),
(24, 4, 1, 2 , "44637950", '2026-02-21 19:00:00', NULL, "S", NULL),
(24, 4, 1, 3 , "44638050", '2026-02-21 19:00:00', NULL, "S", NULL),
(24, 4, 1, 4 , "44638150", '2026-02-21 19:00:00', NULL, "S", NULL),
(24, 4, 1, 5 , "44637850", now()				, NULL, "N", NULL),
(1 , 1, 1, 1 , "44556677", now()				, NULL, "S", NULL),
(2 , 1, 1, 2 , "44556677", now()				, NULL, "S", NULL),
(3 , 1, 1, 3 , "44556677", now()				, NULL, "S", NULL),
(4 , 2, 2, 10, "44556677", now()				, NULL, "S", NULL);


-- =========================================================================================================================================
-- CREAR FUNCIONES
-- =========================================================================================================================================

DROP function IF EXISTS `DeterminarPrecioDeEntrada`;

DELIMITER $$
USE `bdcine`$$
CREATE FUNCTION `DeterminarPrecioDeEntrada`(
	pIdFuncion INT
) RETURNS decimal(12,2)
    READS SQL DATA
BEGIN
	DECLARE precioFinal DECIMAL(12,2) DEFAULT NULL;
    DECLARE fIdGenero	SMALLINT	  DEFAULT NULL;
    DECLARE fIdSala 	SMALLINT      DEFAULT NULL;
    
    SELECT Precio INTO precioFinal FROM Funciones WHERE IdFuncion = pIdFuncion;
    
    SELECT p.IdGenero INTO fIdGenero FROM Funciones AS f
		INNER JOIN Peliculas AS p ON f.IdPelicula = p.IdPelicula
    WHERE f.IdFuncion = pIdFuncion;
    
    IF fIdGenero IN (16, 17) THEN 
		SET precioFinal = precioFinal * 1.10;
    END IF;
    
    SELECT IdSala INTO FIdSala FROM Funciones WHERE IdFuncion = pIdFuncion;
    IF fIdSala = 1 THEN 
		SET precioFinal = precioFinal * 1.05;
    END IF;
    
RETURN precioFinal;
END$$
DELIMITER ;


-- =========================================================================================================================================
-- CREAR STORED PROCEDURES
-- =========================================================================================================================================

-- SP DeterminarPrecioDeEntrada
DROP procedure IF EXISTS `DeterminarPrecioDeEntrada`;
DELIMITER $$
USE `bdcine`$$
CREATE PROCEDURE `DeterminarPrecioDeEntrada`(
	IN pIdFuncion INT
)
BEGIN
    DECLARE precioFinal DECIMAL(12,2) DEFAULT NULL;
	DECLARE fEstado 	CHAR(1)       DEFAULT NULL;
    DECLARE fFechaFin 	DATETIME      DEFAULT NULL;
    
	SELECT Precio INTO precioFinal FROM Funciones WHERE IdFuncion = pIdFuncion;
    IF precioFinal IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcion inexistente';
    END IF;
    
	SELECT Estado INTO fEstado FROM Funciones WHERE IdFuncion = pIdFuncion;
    IF fEstado != "A" THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcion inactiva';
    END IF;
    
    SELECT FechaFin INTO fFechaFin FROM Funciones WHERE IdFuncion = pIdFuncion;
    IF fFechaFin IS NOT NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La funcion ya ha acabado';
    END IF;
    
    SELECT DeterminarPrecioDeEntrada(pIdFuncion) prueba; 
END$$
DELIMITER ;


-- SP ReporteDeOcupacion
DROP procedure IF EXISTS `ReporteDeOcupacionPorPelicula`;
DELIMITER $$
USE `bdcine`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReporteDeOcupacionPorPelicula`(
	IN pIdPelicula INT,
    IN pFechaInicio DATE,
    IN pFechaFin DATE
)
BEGIN
	DECLARE fIdPelicula	INT DEFAULT NULL;
    DECLARE variableAuxiliar 	DATE DEFAULT pFechaInicio;

	SELECT IdPelicula INTO fIdPelicula FROM Peliculas WHERE IdPelicula = pIdPelicula;
    IF fIdPelicula IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pelicula inexistente';
    END IF; 
    
	IF pFechaInicio > pFechaFin THEN		
		SET pFechaInicio = pFechaFin;
        SET pFechaFin = variableAuxiliar;
	END IF;

    SELECT
		f.IdFuncion, 
        f.FechaInicio,
        f.IdSala,
        s.Sala,
        COUNT(r.IdButaca) AS "Butacas vendidas",
        DeterminarPrecioDeEntrada(f.IdFuncion) * COUNT(r.IdButaca) AS "Recaudacion"	
    FROM Funciones AS f
		INNER JOIN Salas 	AS s ON f.IdSala = s.IdSala
		LEFT JOIN  Reservas AS r ON f.IdFuncion = r.IdFuncion
    WHERE
		f.Estado = "A"
        AND f.IdPelicula = pIdPelicula
        AND f.FechaInicio BETWEEN pFechaInicio AND pFechaFin 
    GROUP BY f.IdFuncion;
END$$
DELIMITER ;


-- SP ReservarButacaConDNI
DROP procedure IF EXISTS `ReservarButacaConDNI`;
DELIMITER $$
USE `bdcine`$$
CREATE PROCEDURE `ReservarButacaConDNI`(
	IN pIdFuncion INT,
    IN pIdButaca INT,
    IN pDNI VARCHAR(11)
)
BEGIN
	DECLARE funcionActiva		 CHAR(1)	DEFAULT NULL;
    DECLARE fIdButaca			 SMALLINT   DEFAULT NULL;
	DECLARE reservaRepetida 	 INT 		DEFAULT NULL;
    DECLARE fIdPelicula 		 INT 		DEFAULT NULL;
    DECLARE fIdSala				 INT 		DEFAULT NULL;
    DECLARE fechaReserva 		 DATE 		DEFAULT NULL;
    DECLARE nroReservasEnLaFecha SMALLINT 	DEFAULT 0;
    
    SELECT Estado INTO funcionActiva FROM Funciones WHERE IdFuncion = pIdFuncion;
    IF funcionActiva IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcion inexistente';
	ELSEIF funcionActiva != "A" THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcion inactiva'; 
    END IF;
    
    SELECT b.IdButaca INTO fIdButaca FROM Butacas b INNER JOIN Funciones f ON b.IdSala = f.IdSala WHERE f.IdFuncion = pIdFuncion AND b.IdButaca = pIdButaca;
    IF fIdButaca IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La butaca no pertenece a la sala de la funcion';
    END IF;
    
    SELECT IdReserva INTO reservaRepetida FROM Reservas WHERE (IdFuncion = pIdFuncion AND IdButaca = pIdButaca);
    IF reservaRepetida IS NOT NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Butaca ocupada';
    END IF;

    SELECT IdPelicula 		 		 INTO fIdPelicula  FROM Funciones WHERE IdFuncion = pIdFuncion;
    SELECT IdSala 			 		 INTO fIdSala 	   FROM Funciones WHERE IdFuncion = pIdFuncion;	
    SELECT DATE(FechaProbableInicio) INTO fechaReserva FROM Funciones WHERE IdFuncion = pIdFuncion;
    
    SELECT COUNT(DATE(f.FechaProbableInicio)) INTO nroReservasEnLaFecha 
	FROM Reservas AS r
		INNER JOIN Funciones AS f ON r.IdFuncion = f.IdFuncion
	WHERE 
		r.DNI = pDNI
        AND r.EstaPagada = "S"
        AND r.FechaBaja IS NULL
        AND DATE(f.FechaProbableInicio) = fechaReserva;
    
    IF nroReservasEnLaFecha >= 4 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Numero de reservas para ese dia agotado';
    END IF;
    
	INSERT Reservas (IdFuncion , IdPelicula , IdSala , IdButaca , DNI , FechaAlta, FechaBaja, EstaPagada, Observaciones)
			 VALUES (pIdFuncion, fIdPelicula, fIdSala, pIdButaca, pDNI, now()	 , NULL	  	, "S"		, NULL		   );
END$$
DELIMITER ;


-- SP Dame Cartelera
DROP procedure IF EXISTS `DameCartelera`;
DELIMITER $$
USE `bdcine`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `DameCartelera`(
	IN pFechaInicio	DATE, 
    IN pFechaFin 	DATE
)
BEGIN
	DECLARE variableAuxiliar 	DATE DEFAULT pFechaInicio;
    
    IF (pFechaInicio IS NULL OR pFechaFin IS NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ingresar dos fechas';
    END IF;
    
	IF pFechaInicio > pFechaFin THEN		
		SET pFechaInicio = pFechaFin;
        SET pFechaFin = variableAuxiliar; 
	END IF;

    SELECT 
		f.IdFuncion,
		p.Pelicula,
		g.Genero,
		f.FechaProbableInicio 					 AS "Fecha y hora",
		CONCAT(p.Duracion, " minutos") 			 AS "Duracion",
		f.IdSala,
		s.Sala,
		DeterminarPrecioDeEntrada(f.IdFuncion) 	 AS "Precio",
		(COUNT(b.IdButaca) - COUNT(r.IdReserva)) AS "Entradas disponibles"
	FROM Funciones AS f
		INNER JOIN Salas 	 s ON f.IdSala = s.IdSala
		INNER JOIN Butacas   b ON s.IdSala = b.IdSala AND b.Estado = "A"
		LEFT  JOIN Reservas  r ON b.IdButaca = r.IdButaca AND r.IdFuncion <=> f.IdFuncion AND r.FechaBaja IS NULL
		INNER JOIN Peliculas p ON f.IdPelicula = p.IdPelicula
		INNER JOIN Generos   g ON p.IdGenero = g.IdGenero
	WHERE 
		f.Estado = "A" 
        AND f.FechaProbableInicio BETWEEN pFechaInicio AND pFechaFin 
	GROUP BY f.IdFuncion, s.IdSala;
END$$
DELIMITER ;
