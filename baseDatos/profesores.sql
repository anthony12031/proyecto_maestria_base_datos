SET search_path = ingenieria;
-- actualizarNotas
-- Procedimiento para cambiar la nota de un estudiante
CREATE OR REPLACE FUNCTION actualizar_notas_profesor(
	p_cod_e estudiantes.cod_e%TYPE,
 	p_cod_a asignaturas.cod_a%TYPE,
 	p_grupo inscribe.grupo%TYPE,
	p_id_p inscribe.id_p%TYPE,
	p_n1 inscribe.n1%TYPE,
	p_n2 inscribe.n2%TYPE,
	p_n3 inscribe.n3%TYPE
	) RETURNS VOID AS $$
BEGIN 	
	IF p_id_p::varchar = USER THEN
		EXECUTE format(
		'UPDATE inscribe 
		SET n1 = %s , n2 = %s , n3 = %s
		WHERE 
		id_p = %s AND
		cod_e=%s AND
		grupo=%s AND
		cod_a=%s',p_n1,p_n2,p_n3,p_id_p,p_cod_e,p_grupo,p_cod_a);
	ELSE RAISE EXCEPTION 'No es el profesor de la asignatura';
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_notas(id_prof int, cod_est int, cod_asig int, grupo_asig int, nota1 numeric(2,1), nota2 numeric(2,1), nota3 numeric(2,1))
RETURNS void  AS $$
BEGIN
	update inscribe set n1=(case when nota1 is null then n1 else nota1 end), n2=(case when nota2 is null then n2 else nota2 end), n3=(case when nota3 is null then n3 else nota3 end) where cod_e=cod_est and id_p=id_prof and cod_a=cod_asig and grupo=grupo_asig;
END;
$$ LANGUAGE plpgsql;

-- select * from actualizar_notas(11003,200008,1003,1,5.0,null,null)
-- drop function actualizar_notas(int,bigint,int,smallint,numeric(2,1),numeric,numeric)

-- consultar asignaturas que dicta
CREATE VIEW asignaturas_profesor AS
	SELECT cod_a,nom_a,grupo,horario,modalidad FROM imparte NATURAL JOIN asignaturas 
	WHERE id_p::varchar = USER;
GRANT SELECT ON asignaturas,imparte TO profesores;
GRANT SELECT ON asignaturas_profesor TO profesores;

--ConsultarEstudiantes de una asignatura especifica
CREATE OR REPLACE FUNCTION consultar_estudiantes_asignatura(
	l_cod_a imparte.cod_a%TYPE,
	l_grupo imparte.grupo%TYPE,
	l_horario imparte.horario%TYPE)
RETURNS table(
	cod_e inscribe.cod_e%TYPE,
	nom_e  estudiantes.nom_e%TYPE,
	grupo inscribe.grupo%TYPE,
	id_p inscribe.id_p%TYPE,
	cod_a inscribe.cod_a%TYPE,
	n1 inscribe.n1%TYPE,
	n2 inscribe.n2%TYPE,
	n3 inscribe.n3%TYPE)  AS $$
BEGIN
	return query
	SELECT estu.cod_e,estu.nom_e,ins.grupo,ins.id_p,
	ins.cod_a,ins.n1,ins.n2,ins.n3 
	FROM imparte imp NATURAL JOIN inscribe ins NATURAL JOIN estudiantes estu
	WHERE 
	ins.id_p::varchar = USER AND
	ins.cod_a = l_cod_a AND
	ins.grupo = l_grupo AND
	imp.horario = l_horario AND
	imp.id_p::varchar = USER;
END;
$$ LANGUAGE plpgsql;
GRANT SELECT,UPDATE ON inscribe TO profesores;
GRANT SELECT,UPDATE ON estudiantes TO profesores;

--ConsultarInformaciónPersonalProfesor
CREATE VIEW datos_personales_profesor AS
 select p.id_p, p.nom_p, p.dir_p, p.tel_p from profesores p where p.id_p::varchar=USER;
GRANT SELECT ON datos_personales_profesor TO profesores;
 
CREATE OR REPLACE FUNCTION consultar_info_profesores(id_prof int)
RETURNS table(id_p int ,nom_p varchar(30), dir_p  varchar(30), tel_p bigint)  AS $$
BEGIN
	IF id_p::varchar = USER THEN
		return query
		select p.id_p, p.nom_p, p.dir_p, p.tel_p from profesores p where p.id_p=id_prof;
	ELSE RAISE EXCEPTION 'No puede consultar datos personales';
	END IF;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM imparte;
--select * from consultar_info_profesores(11008)

--actualizarInformaciónPersonalProfesor
CREATE OR REPLACE FUNCTION actualizar_info_profesores(
	nombre_p profesores.nom_p%TYPE, 
	dir_prof profesores.dir_p%TYPE, 
	tel_prof profesores.tel_p%TYPE)
RETURNS void  AS $$
BEGIN
		update profesores set 
		nom_p = (case when nombre_p is null then nom_p else nombre_p end), 
		dir_p=(case when dir_prof is null then dir_p else dir_prof end), 
		tel_p=(case when tel_prof is null then tel_p else tel_prof end)
		WHERE id_p::varchar = USER;
END;
$$ LANGUAGE plpgsql;
--select * from actualizar_info_profesores(11008,'nueva direcc',123456)
GRANT SELECT, UPDATE ON profesores TO profesores;

--Consulta Libros, Autores
GRANT SELECT ON libros TO profesores;
GRANT SELECT ON autores TO profesores;
GRANT SELECT ON escribe TO profesores;

-- libros referenciados por una asignatura
SELECT * FROM referencia;


