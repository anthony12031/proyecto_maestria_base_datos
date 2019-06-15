SET search_path = ingenieria;
--consulta Notas
CREATE VIEW consultar_notas_estudiante AS
	select nom_a,n1, n2, n3,  COALESCE(n1,0)*0.35+COALESCE(n2,0)*0.35+COALESCE(n3,0)*0.3 notaFinal
	from inscribe
	NATURAL JOIN asignaturas
	where cod_e::Varchar=USER;
GRANT SELECT ON consultar_notas_estudiante TO estudiantes;

--consulta librosAutores
GRANT SELECT ON libros TO estudiantes;
GRANT SELECT ON autores TO estudiantes;
CREATE VIEW consulta_libros_autores AS
 SELECT isbn,titulo,edicion,nom_a FROM libros NATURAL JOIN escribe NATURAL JOIN autores;
GRANT SELECT ON consulta_libros_autores TO estudiantes;

--busqueda libros por parametros
CREATE OR REPLACE FUNCTION consultar_libros(isbn_libro bigint = null, titulo_libro varchar(50) = null, edicion_libro int = null, nombre_autor varchar(50) = null)
RETURNS table(isbn bigint, titulo varchar(50), edicion smallint, autores text)  AS $$
BEGIN
	return query
	select l.isbn, l.titulo, l.edicion, string_agg(nom_a,',') autores from libros l inner join escribe esc on l.isbn=esc.isbn inner join autores a on a.id_a=esc.id_a
	where ((l.isbn = isbn_libro) or ( l.titulo like '%'||titulo_libro||'%') or (a.nom_a like '%'||nombre_autor||'%') or edicion_libro is not null) and (edicion_libro is null or l.edicion =edicion_libro)
	group by l.isbn , l.titulo, l.edicion;
END;
$$ LANGUAGE plpgsql;

--consultaPrestamos
CREATE VIEW consultar_prestamos AS
	select num_ej,titulo,fecha_p,fecha_d from presta natural join libros where cod_e::varchar=USER;
GRANT SELECT ON consultar_prestamos TO estudiantes;
