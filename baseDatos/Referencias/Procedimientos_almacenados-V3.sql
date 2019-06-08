--------------------------------------------------------------------------------Procedimientos almacenados--------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION crear_estudiante(cod_e integer)
RETURNS bit AS $$	
BEGIN
	IF(cod_e::varchar IN (SELECT usename FROM pg_user)) THEN
		return 0;
		
	ELSE
		EXECUTE 'CREATE USER "'||cod_e||'" WITH PASSWORD '''||cod_e||'''';
		EXECUTE 'GRANT estudiantes TO "'||cod_e||'"';
		return 1;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crear_estudiantes()
RETURNS bit AS $$
DECLARE cod_est integer;
BEGIN
	FOR cod_est IN SELECT cod_e FROM estudiantes LOOP
		PERFORM crear_estudiante(cod_est);
	END LOOP;
	RETURN 1;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION crear_profesor(id_p integer)
RETURNS bit AS $$	
BEGIN
	IF(id_p::varchar IN (SELECT usename FROM pg_user)) THEN
		return 0;
		
	ELSE
		EXECUTE 'CREATE USER "'||id_p||'" WITH PASSWORD '''||id_p||'''';
		EXECUTE 'GRANT profesores TO "'||id_p||'"';
		return 1;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crear_profesores()
RETURNS bit AS $$
DECLARE id_pro integer;
BEGIN
	FOR id_pro IN SELECT id_p FROM profesores LOOP
		PERFORM crear_profesor(id_pro);
	END LOOP;
	RETURN 1;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION crear_coordinador(id_carr integer)
RETURNS bit AS $$	
BEGIN
	IF(id_carr::varchar IN (SELECT usename FROM pg_user)) THEN
		return 0;
		
	ELSE
		EXECUTE 'CREATE USER "'||id_carr||'" WITH PASSWORD '''||id_carr||'''';
		EXECUTE 'GRANT coordinadores TO "'||id_carr||'"';
		return 1;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crear_coordinadores()
RETURNS bit AS $$
DECLARE id_carrera integer;
BEGIN
	FOR id_carrera IN SELECT id_carr FROM carreras LOOP
		PERFORM crear_coordinador(id_carrera);
		
	END LOOP;
	RETURN 1;
END;
$$ LANGUAGE plpgsql;


select crear_estudiantes();
select crear_profesores();
select crear_coordinadores();


CREATE OR REPLACE FUNCTION actualizar_nota_estudiante(cod_est bigint, cod_asi smallint, nota numeric(3,2), corte varchar)
RETURNS bit AS $$
BEGIN
	IF((SELECT COUNT(*) FROM inscribe i where id_p::varchar=current_user and cod_e= cod_est and cod_a=cod_asi)>0) THEN
		EXECUTE 'UPDATE inscribe SET '||corte||'='||nota||' WHERE id_p='||current_user||' AND cod_e='||cod_est||' AND cod_a='||cod_asi;
		return 1;
	ELSE
		return 0;
	END IF;
END;
$$ LANGUAGE plpgsql;

select actualizar_nota_estudiante(200001::bigint, 1001::smallint, 2.5::numeric, 'n1'::varchar);--Antes era 4.3


CREATE OR REPLACE FUNCTION actualizar_nota_estudiante_carrera(cod_est bigint, cod_asi smallint, nota numeric(3,2), corte varchar)
RETURNS bit AS $$
BEGIN
	IF((SELECT COUNT(*) FROM inscribe i NATURAL JOIN estudiantes where id_carr::varchar=current_user and cod_e= cod_est and cod_a=cod_asi)>0) THEN
		EXECUTE 'UPDATE inscribe SET '||corte||'='||nota||'FROM inscribe i NATURAL JOIN estudiantes e WHERE e.id_carr='||current_user||' AND i.cod_e='||cod_est||' AND i.cod_a='||cod_asi;
		return 1;
	ELSE
		return 0;
	END IF;
END;
$$ LANGUAGE plpgsql;

select actualizar_nota_estudiante_carrera(200001::bigint, 1001::smallint, 2.5::numeric, 'n1'::varchar);--Antes era 4.3