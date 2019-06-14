-- enconding para poder leer caracteres especiales --
SET search_path = ingenieria;
SET client_encoding = 'LATIN1';
COPY asignaturas FROM 'C:\csv\asignaturas.csv' DELIMITERS ';' CSV HEADER;
COPY autores FROM 'C:\csv\autores.csv' DELIMITERS ';' CSV HEADER;
COPY carreras FROM 'C:\csv\carreras.csv' DELIMITERS ';' CSV HEADER;
COPY estudiantes FROM 'C:\csv\estudiantes.csv' DELIMITERS ';' CSV HEADER;
COPY libros FROM 'C:\csv\libros.csv' DELIMITERS ';' CSV HEADER;
COPY profesores FROM 'C:\csv\profesores.csv' DELIMITERS ';' CSV HEADER;
COPY ejemplares FROM 'C:\csv\ejemplares.csv' DELIMITERS ';' CSV HEADER;
COPY escribe FROM 'C:\csv\escribe.csv' DELIMITERS ';' CSV HEADER;
COPY imparte FROM 'C:\csv\imparte.csv' DELIMITERS ';' CSV HEADER;
COPY inscribe FROM 'C:\csv\inscribe.csv' DELIMITERS ';' CSV HEADER;
COPY presta FROM 'C:\csv\presta.csv' DELIMITERS ';' CSV HEADER;
COPY referencia FROM 'C:\csv\referencia.csv' DELIMITERS ';' CSV HEADER;
COPY salones FROM 'C:\csv\salones.csv' DELIMITERS ';' CSV HEADER;
COPY requiere FROM 'C:\csv\requiere.csv' DELIMITERS ';' CSV HEADER;
COPY realiza FROM 'C:\csv\realiza.csv' DELIMITERS ';' CSV HEADER;
COPY incluye FROM 'C:\csv\incluye.csv' DELIMITERS ';' CSV HEADER;
-- resetear enconding para poder mostrar los datos
SET client_encoding = 'UTF8';

