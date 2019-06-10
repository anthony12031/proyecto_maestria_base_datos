/*
Accesos y Procedimientos almacenados para el coordinador
*/
--Ingresa, borra y actualiza información de los estudiantes y las carreras que estudian
GRANT INSERT ON estudiantes TO coordinadores;
GRANT UPDATE ON estudiantes TO coordinadores;
GRANT SELECT ON estudiantes TO coordinadores;
GRANT DELETE ON estudiantes TO coordinadores;
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
$$ LANGUAGE plpgsql
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
$$ LANGUAGE plpgsql
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

/*
Accesos y Procedimientos almacenados para el profesor
*/
-- Ingresa y actualiza las notas de sus estudiantes y sus asignaturas
GRANT INSERT ON inscribe TO profesores;
GRANT SELECT ON inscribe TO profesores;
GRANT UPDATE ON inscribe TO profesores;
-- Procedimiento para cambiar la nota de un estudiante
CREATE OR REPLACE FUNCTION actualizar_notas(
	p_cod_e estudiantes.cod_e%TYPE,
 	p_cod_a asignaturas.cod_a%TYPE,
 	p_grupo inscribe.grupo%TYPE,
	p_nota inscribe.n1%TYPE,
	p_tipo_nota varchar
	) RETURNS varchar AS $$
BEGIN 
	EXECUTE format(
	'UPDATE inscribe 
	SET %s = 5
	WHERE 
	id_p::varchar = %L AND
	cod_e=%s AND
	grupo=%s AND
	cod_a=%s',p_tipo_nota,USER,p_cod_e,p_grupo,p_cod_a);
	RETURN 'Nota actualizada';
END;
$$ LANGUAGE plpgsql
--Ejemplo uso: 
--SELECT * FROM actualizar_notas(200001::bigint,1002::integer,1::smallint,3::numeric,'n2')
--Puede consultas la lista de estudiantes de sus cursos
GRANT SELECT ON estudiantes TO profesores;
CREATE OR REPLACE FUNCTION consultar_estudiantes() RETURNS SETOF estudiantes AS $$
BEGIN 
	SELECT cod_e,nom_e,dir_e,tel_e,cod_carr,f_nac FROM estudiantes NATURAL JOIN inscribe WHERE id_p::varchar = USER;
END;
$$ LANGUAGE plpgsql 
--Consulta Libros, Autores
GRANT SELECT ON libros TO profesores;
-- Puede consultar y actualizar su información en Profesores
GRANT SELECT ON profesores to profesores;
GRANT UPDATE ON profesores to profesores;

/*
Accesos y Procedimientos almacenados para el estudiantes
*/
--Puede consultar sus notas
CREATE VIEW notas_estudiante AS
SELECT n1,n2,n3 FROM inscribe WHERE cod_e::varchar = USER;
GRANT SELECT ON notas_estudiante TO estudiantes;
--Consulta Libros, Autores
GRANT SELECT ON libros TO estudiantes;
--Puede consultar sus prestamos
CREATE VIEW consulta_prestamos AS
SELECT * FROM presta WHERE cod_e::varchar = USER;
GRANT SELECT ON consulta_prestamos TO estudiantes;

/*
Accesos y Procedimientos almacenados para el bibliotecarios
*/
--GROUP Rol bibliotecario
CREATE ROLE bibliotecario;
-- Usuarios tipo bibliotecario que hereden los privilegios del role bibliotecario
CREATE ROLE "biblo1" INHERIT;
--Permiso de login 
ALTER USER "biblo1" LOGIN;
-- Definir una contraseña para el usuario
	ALTER ROLE "biblo1" WITH PASSWORD 'biblo1';
-- Darle el rol de estudiante a este usuario
	GRANT bibliotecario TO "biblo1";
-- Administra la información de los préstamos de libros
GRANT SELECT ON presta to bibliotecario;
GRANT UPDATE ON presta to bibliotecario;
GRANT INSERT ON presta to bibliotecario;
GRANT DELETE ON presta to bibliotecario;
-- Administra la información de los ejemplares
GRANT SELECT ON ejemplares to bibliotecario;
GRANT UPDATE ON ejemplares to bibliotecario;
GRANT INSERT ON ejemplares to bibliotecario;
GRANT DELETE ON ejemplares to bibliotecario;
-- Puede ingresar Libros y sus autores
GRANT INSERT ON libros to bibliotecario;
