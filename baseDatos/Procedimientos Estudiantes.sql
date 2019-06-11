--------------------------Procedimientos Estudiantes
--consulta Notas
CREATE OR REPLACE FUNCTION consultar_notas_estudiante(cod_est int)
RETURNS table(n1 numeric(2,1), n2 numeric(2,1), n3 numeric(2,1), notaFinal numeric(2,1))  AS $$
BEGIN
	return query
	select i.n1, i.n2, i.n3, round((i.n1+i.n2+i.n3)/3,1) notaFinal from inscribe i where cod_est=cod_e;
END;
$$ LANGUAGE plpgsql;

select * from consultar_notas_estudiante(200008)

--consulta librosAutores
CREATE OR REPLACE FUNCTION consultar_libros(isbn_libro bigint = null, titulo_libro varchar(50) = null, edicion_libro int = null, nombre_autor varchar(50) = null)
RETURNS table(isbn bigint, titulo varchar(50), edicion smallint, autores text)  AS $$
BEGIN
	return query
	select l.isbn, l.titulo, l.edicion, string_agg(nom_a,',') autores from libros l inner join escribe esc on l.isbn=esc.isbn inner join autores a on a.id_a=esc.id_a
	where ((l.isbn = isbn_libro) or ( l.titulo like '%'||titulo_libro||'%') or (a.nom_a like '%'||nombre_autor||'%') or edicion_libro is not null) and (edicion_libro is null or l.edicion =edicion_libro)
	group by l.isbn , l.titulo, l.edicion;
END;
$$ LANGUAGE plpgsql;

select * from consultar_libros(null,null,null,null)


--consultaPrestamos
CREATE OR REPLACE FUNCTION consultar_prestamos(cod_est bigint)
RETURNS table(cod_e bigint, isbn bigint, num_ej smallint, fecha_p date, fecha_d date, titulo varchar(50), edicion smallint)  AS $$
BEGIN
	return query
	select * from presta natural join libros where cod_est=presta.cod_e;
END;
$$ LANGUAGE plpgsql;

select * from consultar_prestamos(200008)

drop function consultar_prestamos(bigint)

--------------------------Procedimientos Profesores

--constrain de notas
alter table inscribe add constraint rangonotas check(n1<=5.0 and n1>=0.0 and n2<=5.0 and n2>=0.0 and n3<=5.0 and n3>=0.0)

--actualizarNotas
CREATE OR REPLACE FUNCTION actualizar_notas(id_prof int, cod_est int, cod_asig int, grupo_asig int, nota1 numeric(2,1), nota2 numeric(2,1), nota3 numeric(2,1))
RETURNS void  AS $$
BEGIN
	update inscribe set n1=(case when nota1 is null then n1 else nota1 end), n2=(case when nota2 is null then n2 else nota2 end), n3=(case when nota3 is null then n3 else nota3 end) where cod_e=cod_est and id_p=id_prof and cod_a=cod_asig and grupo=grupo_asig;
END;
$$ LANGUAGE plpgsql;

select * from actualizar_notas(11003,200008,1003,1,5.0,null,null)

drop function actualizar_notas(int,bigint,int,smallint,numeric(2,1),numeric,numeric)

