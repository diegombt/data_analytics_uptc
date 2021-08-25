------------------------------------------------------------------------------------------------------------
-- Consulta de ejemplo
select iden, id, name, age, photo, nationality, overall, position, wage
  from fifa19
 where (nationality in ('Colombia', 'Ecuador', 'Argentina', 'Brazil')
   and position in ('RF', 'CAM', 'CB', 'CDF'))
    or (nationality = ('United States')
   and wage between 50000 and 100000)
 order by overall desc, age desc

------------------------------------------------------------------------------------------------------------
-- 1. Seleccionar el nombre, edad, nacionalidad, overall y wage de los jugadores ordenado de mayor a menor wage y limitarlo a 100 registros
select name, age, nationality, overall, wage
  from fifa19
 order by wage desc
 limit 100

------------------------------------------------------------------------------------------------------------
-- 2. Hacer lo mismo, pero para los jugadores en las posiciones LW, CF, RW
select name, age, nationality, overall, wage
  from fifa19
 where position in ('LW', 'CF', 'RW')
 order by wage desc
 limit 100

------------------------------------------------------------------------------------------------------------
-- 3. Seleccionar overall y position para el top 50 jugadores con mejor Acceleration
select name, overall, position, acceleration
  from fifa19
 where acceleration is not null
   and acceleration <> ''
 order by acceleration desc
 limit 50;

------------------------------------------------------------------------------------------------------------
-- 4. Cual es el top 5 de los jugadores menores de 18 años con mejor wage
select name, club, wage, overall, age
  from fifa19
 where age < 18
 order by wage desc
 limit 5

------------------------------------------------------------------------------------------------------------
-- 5. Cual es el top 5 de los jugadores sobre los 35 años con mejor overall
select name, club, wage, overall, age
  from fifa19
 where age >= 35
 order by overall desc
 limit 5

------------------------------------------------------------------------------------------------------------
-- 6. Seleccione 5 clubes y liste el nombre, wage y overall de todos sus jugadores, ordenado por overall de menor a mayor
select club, name, wage, overall
  from fifa19
 where club in (select distinct club from fifa19 limit 5)
 order by club, overall;

-- Lo mismo pero más raro y con un CTE
with five_clubes as (select distinct club from fifa19 limit 5)
select club, name, wage, overall
  from fifa19
 where club in (select club from five_clubes)
 union
select *
  from (select club, name, wage, overall
          from fifa19
         where club not in (select club from five_clubes) -- Agrego un NOT IN
         limit 1
        ) o -- Agrego la subconsulta solo como ejemplo
 order by club, overall;

------------------------------------------------------------------------------------------------------------
-- 7. Cual es el top 10 de jugadores cuyo potential es alto pero tienen con wage por debajo de la media general
select name, potential, wage, club, overall, nationality
  from fifa19
 where wage < (select avg(wage) from fifa19)
 order by potential desc;

------------------------------------------------------------------------------------------------------------
-- Funciones de agregación
select club
      ,nationality
      ,avg(overall) as avg_overall
      ,avg(wage) as avg_wage
      ,count(*) as players
      ,min(wage) as min_wage
      ,max(wage) as max_wage
      ,sum(wage) as total_wage
  from fifa19
 where club like '%club%'
 group by club, nationality
 order by club, total_wage desc;