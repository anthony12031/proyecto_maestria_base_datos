/*
Accesos y Procedimientos almacenados para el coordinador
*/
--Ingresa, borra y actualiza información de los estudiantes y las carreras que estudian
GRANT INSERT ON estudiantes TO coordinadores;
GRANT UPDATE ON estudiantes TO coordinadores;
GRANT SELECT ON estudiantes TO coordinadores;
GRANT DELETE ON estudiantes TO coordinadores;

-- consultar los estudiantes de la carrera que coordina
CREATE VIEW consultar_estudiantes_carrera AS
	SELECT * FROM estudiantes WHERE cod_carr::varchar = USER;

CREATE OR REPLACE FUNCTION insert_student(
	pcod_e estudiantes.cod_e%TYPE,
	pnom_e estudiantes.nom_e%TYPE,
	pdir_e estudiantes.dir_e%TYPE,
	ptel_e estudiantes.tel_e%TYPE,
	pcod_carr estudiantes.cod_carr%TYPE,
	pf_nac estudiantes.f_nac%TYPE
) RETURNS void AS $$
BEGIN 
	-- Verificar que el usuario es el coordinador de la carrera
	assert user = pcod_carr::varchar;
 	INSERT INTO estudiantes (cod_e,nom_e,dir_e,tel_e,cod_carr,f_nac) 
 	VALUES
 	(pcod_e,pnom_e,pdir_e,ptel_e,pcod_carr,pf_nac);
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
GRANT INSERT ON profesores TO coordinadores;
GRANT UPDATE ON profesores TO coordinadores;
GRANT SELECT ON profesores TO coordinadores;
GRANT DELETE ON profesores TO coordinadores;
--Administra la información de las referencias
GRANT INSERT ON referencia TO coordinadores;
GRANT UPDATE ON referencia TO coordinadores;
GRANT SELECT ON referencia TO coordinadores;
GRANT DELETE ON referencia TO coordinadores;
--Puede ingresar Libros y sus autores
GRANT INSERT ON libros TO coordinadores;
GRANT UPDATE ON libros TO coordinadores;
--Consulta Libros, Autores
GRANT SELECT ON libros TO coordinadores;
-- Puede consultar sus prestamos
GRANT SELECT ON presta TO coordinadores;

