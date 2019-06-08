--Kevin Camilo Díaz Monje, Código 20191495010
--Ejercicio de cuentas de usuarios y permisos de acceso a la información

--Rol Estudiante
create role estudiantes;

--Creación de vista notaFinal_estudiantes
create or replace view notaFinal_estudiantes
 as select cod_e, asignaturas.*, nom_e, n1, n2, n3,(coalesce(n1,0)*0.35+coalesce(n2,0)*0.35+coalesce(n3,0)*0.3)as notaDefinitiva, 
 case when (coalesce(n1,0)*0.35+coalesce(n2,0)*0.35+coalesce(n3,0)*0.3)<3
	then 'Perdio'
	else 'Aprobo'
	end as final, nom_p
 from asignaturas 
	 natural join inscribe
	 natural join estudiantes
	 natural join profesores
 where cod_e::varchar = current_user;

--Asignación de la vista al rol estudiante
grant select on notaFinal_estudiantes to estudiantes;

--Creación de un usuario
create user "200005" with password '200005';

--Asignación del rol de estudiantes al usuario 200005
grant estudiantes to "200005";

--Consultar de la vista
select * from notaFinal_estudiantes ;

------------------------------------------------------------------------------------------------------------
--Rol Profesores
create role profesores;

--Creación de vista estudiantesInscritos_profesor
create or replace view estudiantesInscritos_profesor
 as select cod_e, nom_e, cod_a, nom_a, n1, n2, n3,(coalesce(n1,0)*0.35+coalesce(n2,0)*0.35+coalesce(n3,0)*0.3) as notaDefinitiva, 
 case when (coalesce(n1,0)*0.35+coalesce(n2,0)*0.35+coalesce(n3,0)*0.3)<3
	then 'Perdio'
	else 'Aprobo'
	end as final
 from asignaturas 
	 natural join inscribe
	 natural join estudiantes
 where id_p::varchar = current_user;
 
--Asignación de la vista al rol profesores
grant select on estudiantesInscritos_profesor to profesores;
 
--Creación de un usuario 
create user "11008" with password '11008';
 
--Asignación del rol de profesores al usuario 11008
grant profesores to "11008";

--Consultar la vista
select * from estudiantesInscritos_profesor;

------------------------------------------------------------------------------------------------------------

--Rol Coordinadores
create role coordinadores;

--Creación de vista estudiantesInscritos_carrera
create or replace view estudiantesInscritos_carrera as select distinct est.*
  from estudiantes est
 natural join carreras
 where id_carr::varchar = current_user;

--Creación de vista informaciónProfesores
create or replace view info_profesores as select distinct prof.*
 from profesores prof
	   natural join inscribe
	   natural join estudiantes
 where id_carr::varchar = current_user;

--Creación de vista notas_carrera
create or replace view notas_carrera as select cod_e, cod_a, nom_a, id_p, n1, n2, n3, (coalesce(n1,0)*0.35+coalesce(n2,0)*0.35+coalesce(n3,0)*0.3)
 as notaDefinitiva, 
 case when (coalesce(n1,0)*0.35+coalesce(n2,0)*0.35+coalesce(n3,0)*0.3)<3
	then 'Perdio'
	else 'Aprobo'
	end as final
 from asignaturas 
	 natural join inscribe
	 natural join estudiantes
 where id_carr::varchar = current_user;

--Creación de vista profe_asig_estu
create or replace view profe_asig_estu as select cod_e, id_p, cod_a, nom_a, n1, n2, n3, notaDefinitiva, final, nom_p, nom_e
  from notas_por_carrera 
	 natural join info_profesores
	 natural join estudiantes_inscritos_carr;

--Agregar vistas al rol coordinadores
grant select on estudiantesInscritos_carrera to coordinadores;
grant select on informaciónProfesores to coordinadores;
grant select on notas_carrera to coordinadores;
grant select on profe_asig_estu to coordinadores;

--Creación del usuario 
create user "10004" with password '10004';

--Asignación del rol de coordinadores al usuario 10004
grant coordinadores to "10004";

--Consultar de las vistas
select * from estudiantesInscritos_carrera;
select * from informaciónProfesores;
select * from notas_carrera;
select * from profe_asig_estu;