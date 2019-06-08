-- creacion roles 
--GROUP Rol estudiantes
CREATE ROLE estudiantes;
-- GROUP ROl profesores
CREATE ROLE profesores;
-- GROUP ROL Coordinadores
CREATE ROLE coordinadores;
-- GROUP ROL Bibliotecario
CREATE ROLE bibliotecario;

--Creación usuarios estudiantes
CREATE OR REPLACE FUNCTION create_all_students_users() RETURNS void AS $$
DECLARE 
	estudiante estudiantes%rowtype;
BEGIN 
	FOR estudiante in EXECUTE 'SELECT * FROM estudiantes' LOOP
		EXECUTE FORMAT('CREATE USER "%s" INHERIT LOGIN PASSWORD %L', estudiante.cod_e, estudiante.cod_e);
		EXECUTE FORMAT('GRANT estudiantes TO "%s"',estudiante.cod_e);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

--Creación usuarios profesores
CREATE OR REPLACE FUNCTION create_all_teachers_users() RETURNS void AS $$
DECLARE 
	profesor profesores%rowtype;
BEGIN 
	FOR profesor in EXECUTE 'SELECT * FROM profesores' LOOP
		EXECUTE FORMAT('CREATE USER "%s" INHERIT LOGIN PASSWORD %L', profesor.id_p, profesor.id_p);
		EXECUTE FORMAT('GRANT profesores TO "%s"',profesor.id_p);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

--Creación usuarios coordinadores
CREATE OR REPLACE FUNCTION create_all_coordinator_users() RETURNS void AS $$
DECLARE 
	coordinador carreras%rowtype;
BEGIN 
	FOR coordinador in EXECUTE 'SELECT * FROM carreras' LOOP
		EXECUTE FORMAT('CREATE USER "%s" INHERIT LOGIN PASSWORD %L', coordinador.id_carr, coordinador.id_carr);
		EXECUTE FORMAT('GRANT coordinadores TO "%s"',coordinador.id_carr);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

-- ejecutar los procedimientos para crear los usuarios
SELECT * FROM create_all_students_users();
SELECT * FROM create_all_teachers_users();
SELECT * FROM create_all_coordinator_users();

-- usuarios bibliotecarios 
CREATE USER "bibliotecario_ingenieria" INHERIT LOGIN PASSWORD 'bibliotecario_ingenieria';
GRANT bibliotecario TO "bibliotecario_ingenieria";
CREATE USER "bibliotecario_ciencias" INHERIT LOGIN PASSWORD 'bibliotecario_ciencias';
GRANT bibliotecario TO "bibliotecario_ciencias";
