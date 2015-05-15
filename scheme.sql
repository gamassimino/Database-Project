DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id INT(11) NOT NULL AUTO_INCREMENT,
    email VARCHAR(60) UNIQUE,
    first_name VARCHAR(56),
    last_name VARCHAR(56),
  CONSTRAINT users_pk PRIMARY KEY (id)
);


DROP TABLE IF EXISTS grids;
CREATE TABLE grids(
	codigo integer NOT NULL,
	fecha date,
	hora_inicio varchar(50),
	hora_fin varchar(50),
	ganador varchar(50),
	email varchar(50) NOT NULL,
	FOREIGN KEY (email) REFERENCES Usuario (email),
	PRIMARY KEY (codigo)
);

DROP TABLE IF EXISTS cells;
CREATE TABLE cells(
	pos_x integer NOT NULL,
	pos_y integer NOT NULL,
	PRIMARY KEY (pos_x,pos_y)
);

DROP TABLE IF EXISTS compuesta;
CREATE TABLE compuesta(
	pos_x integer NOT NULL,
	pos_y integer NOT NULL,
	codigo integer NOT NULL,
	orden_jugada varchar(50) NOT NULL,
	FOREIGN KEY (pos_x) REFERENCES Celda (pos_x),
	FOREIGN KEY (pos_y) REFERENCES Celda (pos_y),
	FOREIGN KEY (codigo) REFERENCES Partida (codigo),
	PRIMARY KEY (pos_x,pos_y,codigo)
);


