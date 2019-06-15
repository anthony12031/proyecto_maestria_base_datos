/*
Accesos y Procedimientos almacenados para el coordinador
*/
SET search_path = Ingenieria;
--Ingresa, borra y actualiza información de los estudiantes y las carreras que estudian
GRANT INSERT,UPDATE,SELECT,DELETE ON estudiantes TO coordinadores;

-- consultar los estudiantes de la carrera que coordina
CREATE VIEW consultar_estudiantes_carrera AS
	SELECT * FROM estudiantes WHERE cod_carr::varchar = USER;
GRANT SELECT ON consultar_estudiantes_carrera TO coordinadores;

CREATE VIEW estudiantes_ciencias AS
	SELECT * FROM dblink('ciencias_educacion_conn','SELECT * FROM ciencias_educacion.estudiantes') 
	AS t(cod_e bigint,nom_e varchar,dir_e varchar,tel_e varchar,cod_carr integer, f_nac date);
GRANT SELECT ON estudiantes_ciencias TO coordinadores;

-- Consultar las notas de los estudiantes de su carrera
CREATE VIEW notas_estudiantes_carrera AS
SELECT  * FROM inscribe 
NATURAL JOIN profesores
NATURAL JOIN estudiantes
INNER JOIN carreras ON id_carr = cod_carr
NATURAL JOIN asignaturas
WHERE cod_carr::varchar = USER;
GRANT SELECT ON notas_estudiantes_carrera TO coordinadores;

GRANT UPDATE,SELECT,INSERT ON inscribe TO coordinadores;

-- Procedimiento para cambiar la nota de un estudiante
CREATE OR REPLACE FUNCTION actualizar_notas_coordinadores(
	p_cod_e estudiantes.cod_e%TYPE,
 	p_cod_a asignaturas.cod_a%TYPE,
 	p_grupo inscribe.grupo%TYPE,
	p_id_p inscribe.id_p%TYPE,
	p_n1 inscribe.n1%TYPE,
	p_n2 inscribe.n2%TYPE,
	p_n3 inscribe.n3%TYPE
	) RETURNS VOID AS $$
DECLARE 
 l_estu_cod_carr estudiantes.cod_carr%TYPE;
BEGIN 	
	SELECT cod_carr into l_estu_cod_carr FROM estudiantes WHERE cod_carr::varchar = USER;
	IF l_estu_cod_carr::varchar = USER THEN
	EXECUTE format(
	'UPDATE inscribe 
	SET n1 = %s , n2 = %s , n3 = %s
	WHERE 
	id_p = %s AND
	cod_e=%s AND
	grupo=%s AND
	cod_a=%s',p_n1,p_n2,p_n3,p_id_p,p_cod_e,p_grupo,p_cod_a);
	ELSE RAISE EXCEPTION 'No es el coordinador de la carrera';
	END IF;
END;
$$ LANGUAGE plpgsql;

-- Registra estudiantes en la carrera
CREATE OR REPLACE FUNCTION insert_student(
	pcod_e estudiantes.cod_e%TYPE,
	pnom_e estudiantes.nom_e%TYPE,
	pdir_e estudiantes.dir_e%TYPE,
	ptel_e estudiantes.tel_e%TYPE,
	pcod_carr estudiantes.cod_carr%TYPE,
	pf_nac estudiantes.f_nac%TYPE
) RETURNS void AS $$
BEGIN 
	IF pcod_carr::varchar = USER THEN
		INSERT INTO estudiantes (cod_e,nom_e,dir_e,tel_e,cod_carr,f_nac) 
		VALUES
		(pcod_e,pnom_e,pdir_e,ptel_e,pcod_carr,pf_nac);
	ELSE RAISE EXCEPTION 'No es el coordinador de la carrera';
	END IF;
END;
$$ LANGUAGE plpgsql;

-- ejemplo de uso
--select * FROM insert_student(300001::bigint,'Anthony','cra 45'::varchar,'3102329814',10001,to_date('19940615','YYYYMMDD'));

CREATE OR REPLACE FUNCTION delete_student(
	pcod_e estudiantes.cod_e%TYPE
) RETURNS void AS $$
DECLARE
lid_carr carreras.id_carr%TYPE;
BEGIN 
	SELECT cod_carr into lid_carr FROM estudiantes WHERE pcod_e = cod_e;
	-- Verificar que el usuario es el coordinador de la carrera
	assert user = lid_carr::varchar;
 	DELETE FROM estudiantes WHERE cod_e = pcod_e;
END;
$$ LANGUAGE plpgsql;
-- ejemplo de uso
--SELECT * FROM delete_student(300001::bigint);
--Administra la información de las asignaturas que imparten los profesores y los grupos
GRANT INSERT,UPDATE,SELECT,DELETE ON profesores TO coordinadores;

-- Consulta asignaturas que imparten los profesores de su carrera
CREATE VIEW asignaturas_profesor_coordinador AS
SELECT nom_p,grupo,horario,nom_a,modalidad,id_salon FROM imparte imp 
NATURAL JOIN realiza real
INNER JOIN asignaturas asig ON imp.cod_a = asig.cod_a
INNER JOIN profesores pro ON imp.id_p = pro.id_p ;
GRANT SELECT ON asignaturas_profesor TO coordinadores;

--Administra la información de las referencias
GRANT INSERT,UPDATE,SELECT,DELETE ON referencia TO coordinadores;

--Puede ingresar Libros y sus autores
GRANT INSERT,UPDATE ON libros TO coordinadores;

--Consulta Libros, Autores
GRANT SELECT ON libros TO coordinadores;
GRANT SELECT ON autores TO coordinadores;
GRANT SELECT ON escribe TO coordinadores;

-- Puede consultar sus prestamos
GRANT SELECT ON presta TO coordinadores;

-- Consulta las referencias de las asignaturas a libros
CREATE VIEW referencias AS
	SELECT distinct(esc.isbn),titulo,COALESCE(cod_a::varchar,'No referenciado')asignatura FROM libros lib 
	NATURAL JOIN escribe esc 
	LEFT OUTER JOIN referencia ref ON  lib.isbn = ref.isbn
	ORDER BY esc.isbn;
GRANT SELECT ON referencias TO coordinadores;


