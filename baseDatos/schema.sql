drop table estudiantes;
drop table asignaturas;
drop table autores;
drop table carreras;
drop table ejemplares;
drop table escribe;
drop table imparte;
drop table libros;
drop table presta;
drop table profesores;
drop table referencia;
drop table inscribe;


CREATE TABLE estudiantes(
	cod_e bigint,
	nom_e varchar(40),
	dir_e varchar(30),
	tel_e varchar(10),
	cod_carr Integer,
	f_nac Date
);
CREATE TABLE asignaturas(
	cod_a Integer,
	nom_a varchar(50),
	ih integer,
	cred smallint
);
CREATE TABLE autores(
	id_a Integer,
	nom_a varchar(30),
	nacionalidad varchar(3)
);
CREATE TABLE carreras(
	id_carr integer,
	nom_carr varchar(30)
);
CREATE TABLE ejemplares(
	num_ej smallint,
	isbn bigint
);
CREATE TABLE escribe(
	isbn bigint,
	id_a Integer
);
CREATE TABLE imparte(
	id_p integer,
	cod_a Integer,
	grupo smallint,
	horario varchar(30)
);
CREATE TABLE inscribe(
	cod_e bigint,
	id_p integer,
	cod_a integer,
	grupo smallint,
	n1 numeric(2,1),
	n2 numeric(2,1),
	n3 numeric(2,1)
);
CREATE TABLE libros(
	isbn bigint,
	titulo varchar(50),
	edicion smallint
);
CREATE TABLE presta(
	cod_e bigint,
	isbn bigint,
	num_ej smallint,
	fecha_p Date,
	fecha_d Date
);
CREATE TABLE profesores(
	id_p integer,
	nom_p varchar(30),
	dir_p varchar(30),
	tel_p bigint
);
CREATE TABLE referencia(
	cod_a integer,
	isbn bigint
);
