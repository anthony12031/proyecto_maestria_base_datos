SET search_path = Ingenieria;
CREATE EXTENSION dblink;

-- creación servidor nodo ciencias de la educacion
CREATE SERVER ciencias_educacion_2
	FOREIGN DATA WRAPPER dblink_fdw
	OPTIONS (host '192.168.43.90',
			 dbname 'universidad', port '5432');
			 
-- Mapeo de usuarios locales a la base de datos remota
CREATE USER MAPPING FOR "postgres"
                SERVER ciencias_educacion_2
                OPTIONS (user 'postgres', password 'juegosxbox');

-- Mapeo de usuarios locales a remotos
-- Mapeo de estudiantes
CREATE OR REPLACE FUNCTION map_student_users() RETURNS void AS $$
DECLARE 
	estudiante estudiantes%rowtype;
BEGIN 
	FOR estudiante in EXECUTE 'SELECT * FROM estudiantes' LOOP
		EXECUTE FORMAT ('CREATE USER MAPPING FOR "%s" SERVER ciencias_educacion_2 OPTIONS (user %L, password %L)',estudiante.cod_e,estudiante.cod_e,estudiante.cod_e);
		EXECUTE FORMAT ('GRANT USAGE ON FOREIGN SERVER ciencias_educacion_2 TO "%s"',estudiante.cod_e);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Mapeo de profesores
CREATE OR REPLACE FUNCTION map_teacher_users() RETURNS void AS $$
DECLARE 
	profesor profesores%rowtype;
BEGIN 
	FOR profesor in EXECUTE 'SELECT * FROM profesores' LOOP
		EXECUTE FORMAT ('CREATE USER MAPPING FOR "%s" SERVER ciencias_educacion_2 OPTIONS (user %L, password %L)',profesor.id_p,profesor.id_p,profesor.id_p);
		EXECUTE FORMAT ('GRANT USAGE ON FOREIGN SERVER ciencias_educacion_2 TO "%s"',profesor.id_p);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

--SELECT * FROM map_teacher_users();

-- Mapeo de coordinadores
CREATE OR REPLACE FUNCTION map_coordinadores_users() RETURNS void AS $$
DECLARE 
	coordinador carreras%rowtype;
BEGIN 
	FOR coordinador in EXECUTE 'SELECT * FROM carreras where id_carr <> 10001' LOOP
		EXECUTE FORMAT ('CREATE USER MAPPING FOR "%s" SERVER ciencias_educacion_2 OPTIONS (user %L, password %L)',coordinador.id_carr,coordinador.id_carr,coordinador.id_carr);
		EXECUTE FORMAT ('GRANT USAGE ON FOREIGN SERVER ciencias_educacion_2 TO "%s"',coordinador.id_carr);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

--SELECT * FROM map_coordinadores_users();

-- permiso de acceso a la conexion remote
GRANT USAGE ON FOREIGN SERVER ciencias_educacion TO "postgres";

-- conectarse a la base de datos remota
SELECT dblink_connect('ciencias_educacion_conn', 'ciencias_educacion_2');

-- consulta a ciencias
SELECT * FROM dblink('ciencias_educacion_conn','SELECT n1 FROM ciencias_educacion.inscribe') AS t(n1 float);