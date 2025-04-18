
--DataProject: LógicaConsultaSQL--

/*1. Crea el esquema de la BBDD
 * 
 * Este punto lo presento dentro del README
 */

--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.--

SELECT TITLE AS "Nombre de Peli", RATING AS "Clasificación"
FROM film
WHERE RATING = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.--

SELECT concat(FIRST_NAME ,' ', LAST_NAME ) AS "Nombre del artista"
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.--

SELECT LANGUAGE_ID AS "Idioma", ORIGINAL_LANGUAGE_ID AS "Idioma Original"
FROM film
WHERE LANGUAGE_ID = ORIGINAL_LANGUAGE_ID ;

--5. Ordena las películas por duración de forma ascendente.--

SELECT TITLE AS "Nombre de Peli", LENGTH AS "Duración"
FROM film
ORDER BY LENGTH ASC;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.--

SELECT concat(FIRST_NAME ,' ', LAST_NAME ) AS "Nombre del artista"
FROM actor
WHERE last_name LIKE 'ALLEN';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.--

SELECT SPECIAL_FEATURES AS "Clasificación",COUNT (SPECIAL_FEATURES) AS "Recuento" 
FROM FILM AS F 
GROUP BY "Clasificación"
ORDER BY "Recuento" ASC;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.--

SELECT TITLE AS "Nombre de Peli", RATING "Clasificación", LENGTH AS "Duración"
FROM film
WHERE RATING = 'PG-13' OR LENGTH >180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.--

SELECT round (variance(REPLACEMENT_COST),2) AS "Variabilidad de coste"
FROM film;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.--

SELECT MAX(LENGTH)AS "duración máxima",
       MIN(LENGTH)AS "duración mínima"       
FROM film;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.--

SELECT RENTAL_RATE "Coste de alquiler", RENTAL_DURATION AS "Duración del alquiler"
FROM FILM AS F  
ORDER BY "Duración del alquiler" DESC
OFFSET 2 LIMIT 1;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.--

SELECT TITLE AS "Nombre de Peli", RATING  AS "Categorías"
FROM FILM AS F 
WHERE RATING NOT IN ('NC-17', 'G');

--13. Encuentra el promedio de duración de las películas para cada 
--clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.--

SELECT RATING AS "Clasificación", round (AVG(LENGTH),2) AS "Duración"
FROM film
GROUP BY RATING;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.--

SELECT TITLE AS "Título de Peli", LENGTH AS "duración"
FROM film
WHERE LENGTH >180;

--15. ¿Cuánto dinero ha generado en total la empresa?--

SELECT SUM(AMOUNT) AS "Total dinero generado"
FROM payment;

--16. Muestra los 10 clientes con mayor valor de id.--

SELECT concat("first_name",' ',"last_name")AS "Nombre de clientes", CUSTOMER_ID 
FROM CUSTOMER AS C 
ORDER BY C.CUSTOMER_ID DESC 
LIMIT 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.--

SELECT concat("first_name",' ',"last_name")AS "Nombre del actor/es"
FROM actor AS AC
INNER JOIN FILM_ACTOR AS FA  ON AC.ACTOR_ID = FA.ACTOR_ID 
INNER JOIN FILM AS F ON FA.FILM_ID = F.FILM_ID
WHERE F.TITLE ='EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.--

SELECT DISTINCT TITLE AS "Nombres de Pelis únicos"
FROM film
ORDER BY TITLE;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.--

SELECT TITLE AS "Nombre de Pelis", c."name", f.LENGTH
FROM FILM AS F
INNER JOIN FILM_CATEGORY AS FC ON FC.FILM_ID = F.FILM_ID
INNER JOIN CATEGORY AS C ON C.CATEGORY_ID = FC.CATEGORY_ID
WHERE C."name" ='Comedy' AND f.LENGTH >180;

--20. Encuentra las categorías de películas que tienen un promedio de 
--duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.--

SELECT "name" AS "Categorías", ROUND (AVG(F.LENGTH),2) AS "Duración promedio"
FROM CATEGORY AS C
INNER JOIN FILM_CATEGORY AS FC ON FC.CATEGORY_ID = C.CATEGORY_ID
INNER JOIN FILM AS F ON f.FILM_ID = FC.FILM_ID
WHERE F.LENGTH > 110
GROUP BY C."name"
ORDER BY "Duración promedio" desc;

--21. ¿Cuál es la media de duración del alquiler de las películas?--

SELECT Round(AVG(RENTAL_DURATION),2) AS "Duración media de alquiler" 
FROM FILM AS F ;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.--

SELECT concat("first_name", ' ', "last_name")AS "Nombre de los actores/actrices"
FROM ACTOR AS A 
ORDER BY  "Nombre de los actores/actrices" ASC;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.--

SELECT RENTAL_DATE AS "Fecha de alquiler", count(RENTAL_DATE ) AS "Número de alquileres"
FROM RENTAL AS R 
GROUP BY "Fecha de alquiler" 
ORDER BY "Número de alquileres" DESC;

--24. Encuentra las películas con una duración superior al promedio.--

SELECT TITLE AS "Nombre de Pelis ", LENGTH AS "Duración de la Peli"
FROM FILM AS F
WHERE f.LENGTH >(SELECT AVG(LENGTH)
                 FROM FILM AS F2 )
ORDER BY LENGTH ASC;

--25. Averigua el número de alquileres registrados por mes.--

SELECT DATE_TRUNC('month', rental_date) AS mes, COUNT(*) AS cantidad_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date)
ORDER BY mes;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.--

SELECT Round(AVG(AMOUNT),2) AS "promedio total de pago",
    Round(stddev(AMOUNT),2)AS "desviación estandar del total pagado",
   Round(variance(AMOUNT),2)AS "varianza del total pagado"
FROM PAYMENT AS P; 

--27. ¿Qué películas se alquilan por encima del precio medio?

SELECT TITLE AS "Nombre de Pelis ", RENTAL_RATE AS "Tasa de alquiler"
FROM FILM AS F
WHERE f.RENTAL_RATE >(SELECT AVG(RENTAL_RATE )
                 FROM FILM AS F2 )
ORDER BY RENTAL_RATE  ASC;

--28. Muestra el id de los actores que hayan participado en más de 40 películas.--

SELECT actor_id, COUNT(film_id) AS "cantidad_peliculas"
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40
ORDER BY cantidad_peliculas DESC;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.--

SELECT TITLE AS "Nombre de Pelis", COUNT(STORE_ID ) AS "inventario"
FROM FILM AS F 
INNER JOIN INVENTORY AS I ON I.FILM_ID = F.FILM_ID
GROUP by"Nombre de Pelis"
ORDER BY INVENTARIO DES;

-- 30. Obtener los actores y el número de películas en las que ha actuado.--

SELECT 
       concat(a.FIRST_NAME,' ', a.LAST_NAME) AS nombre_completo,
       COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY cantidad_peliculas DESC;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.--

SELECT TITLE AS "Nombres de Peli", concat(A.FIRST_NAME,' ', a.LAST_NAME) AS "Nombre de actores/actrices"
FROM FILM AS F
LEFT JOIN FILM_ACTOR AS FA 
ON f.FILM_ID = FA.FILM_ID
LEFT JOIN ACTOR AS A 
ON FA.ACTOR_ID = A.ACTOR_ID
ORDER BY "Nombre de actores/actrices" ;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.--

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME)AS "Nombre de actores/actrices",F.TITLE AS "Nombres de pelis"
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA 
ON A.ACTOR_ID =FA.ACTOR_ID
LEFT JOIN FILM AS F 
ON FA.FILM_ID =F.FILM_ID
ORDER BY "Nombres de pelis";

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f.film_id AS "ID de Pelis",
       f.title AS "Nombres de Pelis",
       r.rental_id AS "ID de Alquiler",
       r.rental_date AS "Fecha de Alquiler",
       r.return_date AS "fecha de devolución",
       r.customer_id AS "ID Cliente"
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title, r.rental_date;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.--

SELECT concat(C.FIRST_NAME,' ',C.LAST_NAME)AS "Nombres de clientes",SUM(AMOUNT) AS "total gastado"
FROM CUSTOMER AS C
INNER JOIN PAYMENT AS P 
ON c.CUSTOMER_ID =p.CUSTOMER_ID
GROUP BY "Nombres de clientes" 
ORDER BY "total gastado" DESC
LIMIT  5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.--

SELECT concat(FIRST_NAME,' ', LAST_NAME) AS "Nombre de actores/actrices"
FROM ACTOR AS A
WHERE FIRST_NAME ILIKE 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.--

SELECT FIRST_NAME AS "Nombre",
       LAST_NAME AS "Apellido"
FROM ACTOR AS A;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.--
/*he incluido dos consultas porque me hace dudar el enunciado en cuanto a
 * como mostrar los resultados*/


SELECT 
  MIN(actor_id) AS id_mas_bajo,
  MAX(actor_id) AS id_mas_alto
FROM actor;


SELECT MIN(actor_id) AS actor_id
FROM actor
UNION ALL
SELECT MAX(actor_id)
FROM actor;

--38. Cuenta cuántos actores hay en la tabla “actor”.--

SELECT COUNT(ACTOR_ID) AS "Número de actores/actrices"
FROM ACTOR AS A ;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.--

SELECT concat(FIRST_NAME,' ', LAST_NAME) AS "Nombre de actores/actrices"
FROM ACTOR AS A
ORDER BY LAST_NAME ASC;

--40. Selecciona las primeras 5 películas de la tabla “film”.--

SELECT FILM_ID AS "ID de Pelis", TITLE AS "Nombre de Pelis"
FROM FILM AS F 
LIMIT 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?--

WITH Nombre_repetido AS (
SELECT A.FIRST_NAME AS "Nombre de actor/actriz", COUNT(a.FIRST_NAME)AS "Veces que se repite"
FROM ACTOR AS A 
GROUP BY "Nombre de actor/actriz")
SELECT "Nombre de actor/actriz" , "Veces que se repite" 
FROM Nombre_repetido
WHERE "Veces que se repite" = (SELECT MAX("Veces que se repite") FROM Nombre_repetido);

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.--

SELECT RENTAL_ID AS "Id de alquiler", concat(c.FIRST_NAME,' ', c.LAST_NAME) AS "Nombre de los clientes"
FROM RENTAL AS R 
INNER JOIN CUSTOMER AS C 
ON R.CUSTOMER_ID = c.CUSTOMER_ID;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.--

SELECT concat(c.FIRST_NAME,' ', c.LAST_NAME) AS "Nombre de los clientes", r.RENTAL_ID AS "Id de alquiler"
FROM CUSTOMER AS C 
LEFT JOIN RENTAL AS R 
ON c.CUSTOMER_ID = r.CUSTOMER_ID;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.--

SELECT *
FROM FILM AS F 
CROSS JOIN CATEGORY AS C ;

/*
 * No aporta valor, porque no hay una relación lógica entre las películas y categorías en esta consulta.
 * Solo estamos generando combinaciones de datos sin ningún significado real. 
 */

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.--

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Nombre del actor/actriz", c."name" AS "Categoría"
FROM ACTOR AS A 
INNER JOIN FILM_ACTOR AS FA 
ON a.ACTOR_ID = fa.ACTOR_ID
INNER JOIN FILM AS F 
ON fa.FILM_ID = f.FILM_ID
INNER JOIN FILM_CATEGORY AS FC 
ON f.FILM_ID = fc.FILM_ID
INNER JOIN CATEGORY AS C 
ON fc.CATEGORY_ID =c.CATEGORY_ID
WHERE c."name" ='Action';

--46. Encuentra todos los actores que no han participado en películas.--

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Nombre del actor/actriz", f.TITLE AS "Nombre de las pelis"
FROM ACTOR AS A 
LEFT JOIN FILM_ACTOR AS FA ON a.ACTOR_ID = fa.ACTOR_ID
LEFT JOIN FILM AS F ON fa.FILM_ID = f.FILM_ID
WHERE f.TITLE IS NULL;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.--

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Nombre del actor/actriz", COUNT(f.TITLE) AS "Pelis actuando"
FROM ACTOR AS A 
INNER JOIN FILM_ACTOR AS FA ON a.ACTOR_ID = fa.ACTOR_ID
INNER JOIN FILM AS F ON fa.FILM_ID = f.FILM_ID
GROUP BY "Nombre del actor/actriz" 
ORDER BY "Nombre del actor/actriz"asc;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.--

CREATE VIEW "actor_num_peliculas" AS 
SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Nombre del actor/actriz", COUNT(f.TITLE) AS "Pelis actuando"
FROM ACTOR AS A 
INNER JOIN FILM_ACTOR AS FA ON a.ACTOR_ID = fa.ACTOR_ID
INNER JOIN FILM AS F ON fa.FILM_ID = f.FILM_ID
GROUP BY "Nombre del actor/actriz" 
ORDER BY "Nombre del actor/actriz"asc;

--49. Calcula el número total de alquileres realizados por cada cliente.--

SELECT concat(c.FIRST_NAME,' ',c.LAST_NAME)AS "Nombre de cliente", COUNT(r.RENTAL_ID)AS "Número de alquileres"
FROM CUSTOMER AS C 
INNER JOIN RENTAL AS R ON c.CUSTOMER_ID = r.CUSTOMER_ID
GROUP BY "Nombre de cliente" 
ORDER BY "Nombre de cliente" asc;

--50. Calcula la duración total de las películas en la categoría 'Action'.--
/*
 * hago el ejercicio con una subconsulta que va más directa al resultado, pero que sinceramente
 * me está costando incluir columna al lado para mostrar las categorías, por este hecho
 * hago otra consulta con un inner join que puede mostrar otras categorías 
 */

SELECT SUM(length) AS "Total duración"
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_category fc
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Action');

  
SELECT 
  c.name AS category,
  SUM(f.length) AS total_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c."name" ='Action'
GROUP BY c.name;

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.--

CREATE TEMPORARY TABLE cliente_rentas_temporal AS 
SELECT CUSTOMER_ID AS "Id Clientes", COUNT( RENTAL_ID) AS "Total alquileres x clientes" 
FROM RENTAL AS R 
GROUP BY CUSTOMER_ID
ORDER BY "Total alquileres x clientes" ;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.--

CREATE TEMPORARY TABLE peliculas_alquiladas AS 
SELECT TITLE AS "Nombre de Pelis", COUNT(r.RENTAL_ID) AS "Número de alquileres"
FROM FILM AS F 
INNER JOIN INVENTORY AS I ON f.FILM_ID = I.FILM_ID
INNER JOIN RENTAL AS R ON i.INVENTORY_ID = r.INVENTORY_ID
GROUP BY "Nombre de Pelis" 
HAVING COUNT(r.RENTAL_ID) >=10
ORDER BY "Número de alquileres" ASC;

/*-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.--
 */

SELECT f.title AS "Nombre de Pelis no devuelta", concat(c.FIRST_NAME,' ',c.LAST_NAME)AS "Nombre de cliente"
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE c.first_name ILIKE'Tammy' 
  AND c.last_name ILIKE  'Sanders'
  AND r.return_date IS NULL
ORDER BY f.title;

/*--54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.--
 */

SELECT DISTINCT ANP."Nombre del actor/actriz", c."name" AS "Categoria"
FROM ACTOR_NUM_PELICULAS AS ANP 
INNER JOIN film_category fc ON ANP."Pelis actuando" = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY ANP."Nombre del actor/actriz" asc;

/*--55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.--
 */

SELECT concat(a.FIRST_NAME ,' ',a.LAST_NAME) AS "Nombre del actor/actriz"
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM film f2
    INNER JOIN inventory i2 ON f2.film_id = i2.film_id
    INNER JOIN rental r2 ON i2.inventory_id = r2.inventory_id
    WHERE f2.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name;

/*entiendo que no me da resultado porque nunca fue alquilada
 *o por lo menos es el dato que me arroja la siguiente consulta.
 *de todos modos espero vuestra respuesta, gracias,
 */

SELECT f.title, r.rental_date
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Spartacus Cheaper';

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.--

SELECT a.FIRST_NAME AS "Nombre actor/actriz", a.LAST_NAME AS "Apellidos actor/actriz"
FROM ACTOR AS A 
WHERE a.ACTOR_ID NOT IN (
        SELECT FA.ACTOR_ID
        FROM FILM_ACTOR AS FA
        INNER JOIN FILM_CATEGORY AS FC ON fa.FILM_ID = fc.FILM_ID 
        INNER JOIN CATEGORY AS C ON fc.CATEGORY_ID = c.CATEGORY_ID 
        WHERE c."name" ='Music')
ORDER BY a.LAST_NAME;

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.--
/*
 * incluyo dos consultas, una con join para que haya mayor detalle x fila y veces alquilada aunque se repita
 * y otra con subconsulta para que nos muestre fila por película alquilada más de 8 días.
 */

SELECT count(TITLE)AS "Nombre de Pelis"
FROM FILM AS F 
WHERE f.FILM_ID IN (
        SELECT i.FILM_ID
        FROM INVENTORY AS I
        INNER JOIN RENTAL AS R ON i.INVENTORY_ID = r.INVENTORY_ID 
        WHERE DATE(r.RETURN_DATE) - DATE(r.RENTAL_DATE) >8);
        

SELECT 
    f.title AS "Nombre de Pelis",
    DATE(r.return_date) - DATE(r.rental_date) AS "Días de alquiler"
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE DATE(r.return_date) - DATE(r.rental_date) > 8;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

SELECT TITLE AS "Nombre de Pelis", c."name"
FROM FILM AS F 
INNER JOIN FILM_CATEGORY AS FC ON f.FILM_ID = fc.FILM_ID
INNER JOIN CATEGORY AS C ON fc.CATEGORY_ID = c. CATEGORY_ID 
WHERE c."name" ='Animation'
ORDER BY "Nombre de Pelis" ASC;

/*--59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.--
 */

SELECT TITLE AS "Nombres de pelis"
FROM FILM AS F 
WHERE LENGTH =(
    SELECT LENGTH 
    FROM FILM AS F 
    WHERE TITLE ILIKE'Dancing Fever')
ORDER BY F.TITLE ASC;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.--


SELECT concat(c.FIRST_NAME,' ', c.LAST_NAME)AS "Nombre de los clientes", count(DISTINCT i.FILM_ID )AS "Pelis distintas"
FROM CUSTOMER AS C 
INNER JOIN RENTAL AS R ON c.CUSTOMER_ID = r.CUSTOMER_ID
INNER JOIN INVENTORY AS I ON r.INVENTORY_ID = i.INVENTORY_ID
GROUP BY c.FIRST_NAME, c.LAST_NAME
HAVING COUNT(DISTINCT i.FILM_ID) >= 7
ORDER BY C.LAST_NAME;

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.--

SELECT 
  c.name AS "Categoría", 
  COUNT(r.rental_id) AS "Recuento de alquileres"
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
INNER JOIN inventory AS i ON fc.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY "Recuento de alquileres" DESC;

--62. Encuentra el número de películas por categoría estrenadas en 2006.--

SELECT c."name" AS "Categoría", count(f.FILM_ID) AS "Número de pelis estrenadas en 2006"
FROM CATEGORY AS C 
INNER JOIN FILM_CATEGORY AS FC ON c.CATEGORY_ID = fc.CATEGORY_ID
INNER JOIN FILM AS F ON fc.FILM_ID = f.FILM_ID
WHERE f.RELEASE_YEAR = 2006
GROUP BY "Categoría"
ORDER BY "Número de pelis estrenadas en 2006" DESC ;
                    
--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.--

SELECT *
FROM STAFF AS S 
CROSS JOIN STORE AS S2 ;
                    
/*--64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.--
 */

SELECT c.CUSTOMER_ID AS "Id cliente", 
        concat(c.FIRST_NAME,' ', c.LAST_NAME) AS "Nombre del cliente", 
        count( r.RENTAL_ID ) AS "Nº pelis alquiladas"
FROM CUSTOMER AS C 
INNER JOIN RENTAL AS R ON c.CUSTOMER_ID = r.CUSTOMER_ID
INNER JOIN INVENTORY AS I ON r.INVENTORY_ID = i.INVENTORY_ID
GROUP BY c.CUSTOMER_ID,"Nombre del cliente" 
ORDER BY c.CUSTOMER_ID;

