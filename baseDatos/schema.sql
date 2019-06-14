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
drop table salones;
drop table incluye;
drop table requiere;
drop table realiza;

-- Esquema de Tablas
-- carreras = (id_carr,nom_carr)
-- profesores = (id_p,nom_p,dir_p,tel_p)
-- estudiantes = (cod_e,nom_e,dir_e,tel_e,f_nac,id_carr)
-- asignaturas = (cod_a,nom_a,ih,cred,modalidad)
-- salones = (id_salon,capacidad,tipo_salon)
-- autores = (id_a,nom_a,nacionalidad)
-- ejemplares = (num_ej,isbn)
-- libros = (isbn,titulo,edicion)
-- escribe= (isbn,id_a)
-- imparte = (id_p,cod_a,grupo,horario)
-- inscribe = (id_p,cod_a,grupo,cod_e)
-- requiere = (cod_a,cod_a_requerida)
-- realiza = (id_p,cod_a,grupo,id_salon,horario)
-- incluye = (id_carr,cod_a,semestre)
-- presta = (cod_e,isbn,num_ej,fecha_p,fecha_d)
-- referencia = (cod_a,isbn)

-- creacion roles 
--GROUP Rol estudiantes
CREATE ROLE estudiantes;
-- GROUP ROl profesores
CREATE ROLE profesores;
-- GROUP ROL Coordinadores
CREATE ROLE coordinadores;
-- GROUP ROL Bibliotecario
CREATE ROLE bibliotecario;

-- esquemas de facutades
CREATE schema ingenieria;
CREATE schema ciencias_educacion;

GRANT USAGE ON SCHEMA ingenieria TO estudiantes;
GRANT USAGE ON SCHEMA ingenieria TO profesores;
GRANT USAGE ON SCHEMA ingenieria TO coordinadores;
GRANT USAGE ON SCHEMA ingenieria TO bibliotecario;
GRANT USAGE ON SCHEMA ingenieria TO postgres;

GRANT USAGE ON SCHEMA ciencias_educacion TO estudiantes;
GRANT USAGE ON SCHEMA ciencias_educacion TO profesores;
GRANT USAGE ON SCHEMA ciencias_educacion TO coordinadores;
GRANT USAGE ON SCHEMA ciencias_educacion TO bibliotecario;
GRANT USAGE ON SCHEMA ciencias_educacion TO postgres;

SET search_path = Ingenieria;

CREATE TABLE carreras(
	id_carr integer PRIMARY KEY,
	nom_carr varchar(30) NOT NULL
);

CREATE TABLE profesores(
	id_p integer PRIMARY KEY,
	nom_p varchar(30) NOT NULL,
	dir_p varchar(30),
	tel_p bigint
);

CREATE TABLE estudiantes(
	cod_e bigint PRIMARY KEY,
	nom_e varchar(40) NOT NULL,
	dir_e varchar(30),
	tel_e varchar(10),
	cod_carr Integer NOT NULL references carreras(id_carr),
	f_nac Date NOT NULL
);
CREATE TABLE asignaturas(
	cod_a Integer PRIMARY KEY,
	nom_a varchar(50) NOT NULL,
	ih integer NOT NULL,
	cred smallint NOT NULL,
	modalidad varchar(17) NOT NULL CONSTRAINT modalidad_asignatura CHECK (modalidad IN ('teorico','teorico-practico'))
);
																																  
CREATE TABLE salones(
	id_salon Integer PRIMARY KEY,
	capacidad Integer NOT NULL,
	tipo_salon varchar(17) NOT NULL CONSTRAINT tipo_salon CHECK (tipo_salon IN ('teorico','teorico-practico'))
);

CREATE TABLE autores(
	id_a Integer PRIMARY KEY,
	nom_a varchar(30) NOT NULL,
	nacionalidad varchar(3) NOT NULL
);

																 																 
CREATE TABLE libros(
	isbn bigint PRIMARY KEY,
	titulo varchar(50) NOT NULL,
	edicion smallint NOT NULL
);																 

CREATE TABLE ejemplares(
	num_ej smallint,
	isbn bigint references libros(isbn) 
);	
ALTER TABLE ejemplares add PRIMARY KEY(num_ej,isbn);

CREATE TABLE escribe(
	isbn bigint NOT NULL references libros(isbn),
	id_a Integer NOT NULL references autores(id_a)
);
ALTER TABLE escribe add PRIMARY KEY(isbn,id_a);																 

CREATE TABLE imparte(
	id_p integer NOT NULL references profesores(id_p),
	cod_a Integer NOT NULL references asignaturas(cod_a) ,
	grupo smallint NOT NULL ,
	horario varchar(30) NOT NULL
);
ALTER TABLE imparte add PRIMARY KEY(id_p,cod_a,grupo,horario);																	 
													 
CREATE TABLE inscribe(
	cod_e bigint NOT NULL references estudiantes(cod_e),
	id_p integer NOT NULL references profesores(id_p),
	cod_a integer NOT NULL references asignaturas(cod_a),
	grupo smallint NOT NULL,
	n1 numeric(2,1),
	n2 numeric(2,1),
	n3 numeric(2,1)
);
ALTER TABLE inscribe add PRIMARY KEY(cod_e,id_p,cod_a,grupo);
--constrain de notas
alter table inscribe add constraint rangonotas check(n1<=5.0 and n1>=0.0 and n2<=5.0 and n2>=0.0 and n3<=5.0 and n3>=0.0);


CREATE TABLE requiere(
	cod_a Integer NOT NULL references asignaturas(cod_a),
	cod_a_requerida Integer NOT NULL references asignaturas(cod_a)
);
ALTER TABLE requiere add PRIMARY KEY(cod_a,cod_a_requerida);																	 

CREATE TABLE realiza(
	id_p Integer NOT NULL references profesores(id_p),
	cod_a Integer NOT NULL references asignaturas(cod_a),
	grupo smallint NOT NULL,
	horario varchar(30) NOT NULL,
	id_salon Integer NOT NULL references salones (id_salon)
);
ALTER TABLE realiza add PRIMARY KEY(id_p,cod_a,grupo,horario,id_salon);	
													 
CREATE TABLE incluye(
	id_carr integer NOT NULL references carreras(id_carr),
	cod_a integer NOT NULL references asignaturas(cod_a),
	semestre smallint NOT NULL CONSTRAINT numero_semestre CHECK (semestre  <= 10)
);
ALTER TABLE incluye add PRIMARY KEY(id_carr,cod_a);																	 

CREATE TABLE presta(
	cod_e bigint NOT NULL references estudiantes(cod_e),
	isbn bigint NOT NULL references libros(isbn),
	num_ej smallint NOT NULL,
	fecha_p Date NOT NULL,
	fecha_d Date CONSTRAINT fecha_devolucion CHECK (fecha_d  >= fecha_p)
);
ALTER TABLE presta add PRIMARY KEY(cod_e,isbn,num_ej,fecha_p);																	 

CREATE TABLE referencia(
	cod_a integer NOT NULL references asignaturas(cod_a),
	isbn bigint NOT NULL references libros(isbn)
);
ALTER TABLE referencia add PRIMARY KEY(cod_a,isbn);		


SET search_path = ciencias_educacion;

CREATE TABLE carreras(
	id_carr integer PRIMARY KEY,
	nom_carr varchar(30) NOT NULL
);

CREATE TABLE profesores(
	id_p integer PRIMARY KEY,
	nom_p varchar(30) NOT NULL,
	dir_p varchar(30),
	tel_p bigint
);

CREATE TABLE estudiantes(
	cod_e bigint PRIMARY KEY,
	nom_e varchar(40) NOT NULL,
	dir_e varchar(30),
	tel_e varchar(10),
	cod_carr Integer NOT NULL references carreras(id_carr),
	f_nac Date NOT NULL
);
CREATE TABLE asignaturas(
	cod_a Integer PRIMARY KEY,
	nom_a varchar(50) NOT NULL,
	ih integer NOT NULL,
	cred smallint NOT NULL,
	modalidad varchar(17) NOT NULL CONSTRAINT modalidad_asignatura CHECK (modalidad IN ('teorico','teorico-practico'))
);
																																  
CREATE TABLE salones(
	id_salon Integer PRIMARY KEY,
	capacidad Integer NOT NULL,
	tipo_salon varchar(17) NOT NULL CONSTRAINT tipo_salon CHECK (tipo_salon IN ('teorico','teorico-practico'))
);

CREATE TABLE autores(
	id_a Integer PRIMARY KEY,
	nom_a varchar(30) NOT NULL,
	nacionalidad varchar(3) NOT NULL
);

																 																 
CREATE TABLE libros(
	isbn bigint PRIMARY KEY,
	titulo varchar(50) NOT NULL,
	edicion smallint NOT NULL
);																 

CREATE TABLE ejemplares(
	num_ej smallint,
	isbn bigint references libros(isbn) 
);	
ALTER TABLE ejemplares add PRIMARY KEY(num_ej,isbn);

CREATE TABLE escribe(
	isbn bigint NOT NULL references libros(isbn),
	id_a Integer NOT NULL references autores(id_a)
);
ALTER TABLE escribe add PRIMARY KEY(isbn,id_a);																 

CREATE TABLE imparte(
	id_p integer NOT NULL references profesores(id_p),
	cod_a Integer NOT NULL references asignaturas(cod_a) ,
	grupo smallint NOT NULL ,
	horario varchar(30) NOT NULL
);
ALTER TABLE imparte add PRIMARY KEY(id_p,cod_a,grupo,horario);																	 
													 
CREATE TABLE inscribe(
	cod_e bigint NOT NULL references estudiantes(cod_e),
	id_p integer NOT NULL references profesores(id_p),
	cod_a integer NOT NULL references asignaturas(cod_a),
	grupo smallint NOT NULL,
	n1 numeric(2,1),
	n2 numeric(2,1),
	n3 numeric(2,1)
);
ALTER TABLE inscribe add PRIMARY KEY(cod_e,id_p,cod_a,grupo);																	 

CREATE TABLE requiere(
	cod_a Integer NOT NULL references asignaturas(cod_a),
	cod_a_requerida Integer NOT NULL references asignaturas(cod_a)
);
ALTER TABLE requiere add PRIMARY KEY(cod_a,cod_a_requerida);																	 

CREATE TABLE realiza(
	id_p Integer NOT NULL references profesores(id_p),
	cod_a Integer NOT NULL references asignaturas(cod_a),
	grupo smallint NOT NULL,
	horario varchar(30) NOT NULL,
	id_salon Integer NOT NULL references salones (id_salon)
);
ALTER TABLE realiza add PRIMARY KEY(id_p,cod_a,grupo,horario,id_salon);	
													 
CREATE TABLE incluye(
	id_carr integer NOT NULL references carreras(id_carr),
	cod_a integer NOT NULL references asignaturas(cod_a),
	semestre smallint NOT NULL CONSTRAINT numero_semestre CHECK (semestre  <= 10)
);
ALTER TABLE incluye add PRIMARY KEY(id_carr,cod_a);																	 

CREATE TABLE presta(
	cod_e bigint NOT NULL references estudiantes(cod_e),
	isbn bigint NOT NULL references libros(isbn),
	num_ej smallint NOT NULL,
	fecha_p Date NOT NULL,
	fecha_d Date CONSTRAINT fecha_devolucion CHECK (fecha_d  >= fecha_p)
);
ALTER TABLE presta add PRIMARY KEY(cod_e,isbn,num_ej,fecha_p);																	 

CREATE TABLE referencia(
	cod_a integer NOT NULL references asignaturas(cod_a),
	isbn bigint NOT NULL references libros(isbn)
);
ALTER TABLE referencia add PRIMARY KEY(cod_a,isbn);																 

