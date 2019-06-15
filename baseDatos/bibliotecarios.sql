SET search_path = ingenieria;

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
GRANT SELECT,INSERT,UPDATE ON libros to bibliotecario;
GRANT SELECT,INSERT,UPDATE ON autores to bibliotecario;

-- ejemplares
CREATE OR REPLACE FUNCTION consultar_ejemplares(isbn_libro libros.isbn%TYPE)
RETURNS table(isbn libros.isbn%TYPE, num_ej ejemplares.num_ej%TYPE)  AS $$
BEGIN
	return query
	select * FROM ejemplares ej WHERE ej.isbn = isbn_libro;
END;
$$ LANGUAGE plpgsql;

-- libros y sus autores
CREATE VIEW libros_autores AS
	SELECT * FROM autores NATURAL JOIN escribe NATURAL JOIN libros ORDER BY ISBN;
GRANT SELECT ON libros_autores TO bibliotecario;