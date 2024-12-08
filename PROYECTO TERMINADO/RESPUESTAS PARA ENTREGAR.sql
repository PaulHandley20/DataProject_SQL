--Punto 2: Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT title 
FROM film f 
WHERE rating = 'R'; 

--Punto 3: Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
SELECT first_name, last_name, actor_id 
FROM actor a 
WHERE actor_id BETWEEN 30 AND 40; 

--punto 4: Obtén las películas cuyo idioma coincide con el idioma original.
SELECT title 
FROM film f 
WHERE language_id = original_language_id  ; 
--Conte ambas columnas para ver si la respuesta era correcta.
SELECT COUNT(*) AS total_peliculas, 
       COUNT(original_language_id) AS peliculas_con_idioma_original
FROM film;

 --Punto 5: Ordena las películas por duración de forma ascendente.
SELECT title, length AS Duracion 
FROM film
ORDER BY length ASC;

--Punto 6: Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
SELECT first_name, last_name
FROM actor 
WHERE last_name IN ('ALLEN') ; 

--Punto 7: Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
SELECT rating AS clasificacion , COUNT(*) AS total_peliculas
FROM film
GROUP BY rating ;
--Para chequear que estan todas las peliculas...
SELECT COUNT(*) AS total_movies
FROM film;

--Punto 8: Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
SELECT title, rating AS clasificacion, length AS duracion 
FROM film
WHERE rating = 'PG-13' OR length > 180;
--para rechequear que esta bien la informacion...
SELECT COUNT(*) AS total_peliculas
FROM film
WHERE rating = 'PG-13' OR length > 180;

--Punto 9: Encuentra la variabilidad de lo que costaría reemplazar las películas.
--DESVIACION ESTANDAR: 
SELECT 
	AVG(replacement_cost) AS promedio_costo,
    STDDEV(replacement_cost) AS desviacion_estandar
FROM film;
--VARIANZA:
SELECT 
    AVG(replacement_cost) AS promedio_costo,
    VARIANCE(replacement_cost) AS varianza
FROM film;
--RANGO:
SELECT 
    MAX(replacement_cost),  MIN(replacement_cost) AS rango
FROM film;

--Punto 10: Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE(replacement_cost) AS variabilidad_reemplazo
FROM film;

--Punto 11: Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT rental_id AS costo_alquiler, rental_date 
FROM rental r
ORDER BY rental_date DESC 
LIMIT 1 OFFSET 2;

--Punto 12: Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
SELECT title
FROM film
WHERE rating <> 'NC-17' 
AND rating <> 'G';
--Otra manera de hacerlo 
SELECT title 
FROM film 
WHERE rating NOT IN ('NC-17', 'G');

/**Punto 13: Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.**/
SELECT rating AS Clasificacion, avg(length) AS Promedio_duracion  
FROM film f 
GROUP BY rating ;

--Punto 14: Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT title 
FROM film f 
WHERE length > 180; 

--Punto 15: ¿Cuánto dinero ha generado en total la empresa?
SELECT sum(amount) AS total_Generado   
FROM payment p ;

--Punto 16: Muestra los 10 clientes con mayor valor de id.
SELECT customer_id , first_name , last_name , email 
FROM customer c 
ORDER BY customer_id DESC 
LIMIT 10;

--Punto 17: Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
SELECT a.first_name , a.last_name 
FROM actor a 
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id 
INNER JOIN film f ON fa.film_id = f.film_id 
WHERE f.title = 'EGG IGBY';

--Punto 18: Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT title 
FROM film f ; 

--Punto 19: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
SELECT f.title 
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE f.length > 180
AND c.name = 'Comedy' ; 

/**Punto 20: Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.**/
SELECT c.name AS category_name, AVG(f.length)AS Promedio_duracion  
FROM film f 
INNER JOIN film_category fc ON f.film_id = fc.film_id 
INNER JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name 
HAVING AVG(f.length) >110; 

--Punto 21: ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(rental_duration) AS media_duracion_alquiler
FROM film;

--Punto 22: Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT concat(first_name, ' ', last_name) as nombre_completo 
FROM actor a 

--Punto 23: Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT rental_date, count(*) AS rental_count
FROM rental
GROUP BY rental_date
ORDER BY rental_count DESC ;

--punto 24: Encuentra las películas con una duración superior al promedio.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

--Punto 25: Averigua el número de alquileres registrados por mes.
SELECT 
    EXTRACT(MONTH FROM rental_date) AS meses,
    COUNT(*) AS renta_total 
FROM rental r 
GROUP BY 
    EXTRACT(MONTH FROM rental_date)
ORDER BY meses;

--punto 26:  Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT
    avg(amount) AS average_amount, 
    stddev(amount) AS stddev_amount, 
    variance(amount) AS variance_amount
FROM payment;

--Punto 27:  ¿Qué películas se alquilan por encima del precio medio?
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT avg(rental_rate) FROM film);

--Punto 28: Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT actor_id 
FROM film_actor fa 
GROUP BY actor_id 
HAVING count(film_id) > 40; 

--Punto 29: Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT f.title, 
       (SELECT count(*) 
        FROM inventory i 
        WHERE i.film_id = f.film_id) AS cantidad_disponible
FROM film f;
--2 maneras de hacerlo 
select f.title, COUNT(i.inventory_id) as cantidad_disponible
from film f
left join inventory i on f.film_id = i.film_id
group by f.title;

--Punto 30: Obtener los actores y el número de películas en las que ha actuado.
SELECT a.actor_id, 
       concat(a.first_name, ' ', a.last_name) AS nombre_del_actor, 
       count(fa.film_id) AS numero_de_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, nombre_del_actor 
ORDER BY  numero_de_peliculas DESC ;

--Punto 31: Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT f.title, concat(a.first_name, ' ', a.last_name) AS nombre_del_actor 
FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
LEFT JOIN actor a ON fa.actor_id = a.actor_id 
ORDER BY f.title, nombre_del_actor; 

--Punto 32: Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT concat(a.first_name, ' ', a.last_name) AS nombre_del_actor, 
       f.title AS film_title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
ORDER BY nombre_del_actor, film_title;

--Punto 33: Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT f.title AS titulo_de_pelicula, 
       r.rental_id, 
       r.rental_date, 
       r.return_date, 
       r.customer_id
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title, r.rental_date;

--Punto 34: Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT c.customer_id, 
       concat(c.first_name, ' ', c.last_name) as nombre_del_customer, 
       sum(p.amount) AS total_spent
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, nombre_del_customer
ORDER BY total_spent DESC 
LIMIT 5;

--punto 35: Selecciona todos los actores cuyo primer nombre es 'Johnny'
SELECT actor_id, 
       first_name, 
       last_name
FROM actor
WHERE first_name = 'JOHNNY';

--Punto 36: Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
SELECT actor_id, 
       first_name AS Nombre, 
       last_name AS Apellido
FROM actor a ;

--Punto 37: Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT 
    min(actor_id) AS actor_id_minimo, 
    max(actor_id) AS actor_id_maximo
FROM actor;
--si se quiere saber quienes son especificamente.
SELECT actor_id, 
       first_name, 
       last_name
FROM actor
WHERE actor_id = (SELECT MIN(actor_id) FROM actor)
   OR actor_id = (SELECT MAX(actor_id) FROM actor);
   
  --Punto 38: Cuenta cuántos actores hay en la tabla “actor”.
SELECT COUNT(*) AS total_actores
FROM actor;

--Punto 39: Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT actor_id, 
       first_name, 
       last_name
FROM actor
ORDER BY last_name ASC;

--Punto 40: Selecciona las primeras 5 películas de la tabla “film”.
SELECT title 
FROM film
LIMIT 5;

--Punto 41: Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT first_name, 
       count(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC ;

--Punto 42: Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r.rental_id AS Alquileres, 
       c.first_name, 
       c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id;

--Punto 43: Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT c.customer_id, 
       c.first_name, 
       c.last_name, 
       r.rental_id as alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;

--Punto 44: Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT f.title AS titulo_pelicula, 
       c.name AS nombre_categoria
FROM film f
CROSS JOIN category c;
/**El uso de un CROSS JOIN puede no ser muy útil en la mayoría de los contextos prácticos, especialmente si las tablas son grandes. 
 Esto se debe a que generará un número muy elevado de combinaciones que no necesariamente tienen sentido, 
 ya que cada película se listará con cada categoría independientemente de si corresponde a esa película o no.**/

--Punto 45: Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT DISTINCT a.first_name, 
                a.last_name, c."name" 
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action'; 

--Punto 46: Encuentra todos los actores que no han participado en películas.
SELECT a.actor_id, 
       a.first_name, 
       a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL ;

--Punto 47: Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT a.first_name, 
       a.last_name, 
       COUNT(fa.film_id) AS total_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_peliculas DESC;

--Punto 48: Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW actor_num_peliculas AS
SELECT a.first_name, 
       a.last_name, 
       COUNT(fa.film_id) AS total_films
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

--Para ejecutarla:
SELECT * FROM actor_num_peliculas;

--Punto 49: Calcula el número total de alquileres realizados por cada cliente.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       count(r.rental_id) AS total_rentas
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentas DESC;

--Punto 50: Calcula la duración total de las películas en la categoría 'Action'.
SELECT sum(f.length) AS total_duracion
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';
--si quiero saber cuanto dura cada pelicula especificamente:
SELECT f.title, f.length
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

--Punto 51: Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       count(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

select * from cliente_rentas_temporal;

--Punto 52: Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id,
       f.title,
       count(r.rental_id) AS total_alquileres
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id, f.title
HAVING count(r.rental_id) >= 10;

SELECT * 
FROM peliculas_alquiladas;

/**Punto 53: Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.**/
SELECT f.title 
FROM film f 
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
INNER JOIN customer c ON r.customer_id = c.customer_id 
WHERE c.first_name = 'TAMMY' 
AND c.last_name = 'SANDERS' 
AND r.return_date IS NULL 
ORDER BY f.title ASC;

/**Punto 54: Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.**/
SELECT DISTINCT a.first_name, a.last_name 
FROM actor a 
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id 
INNER JOIN film f ON fa.film_id = f.film_id 
INNER JOIN film_category fc ON f.film_id = fc.film_id 
INNER JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Sci-Fi' 
ORDER BY a.last_name ASC;

/**Punto 55: Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido. **/
SELECT DISTINCT a.first_name, a.last_name 
FROM actor a 
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id 
INNER JOIN film f ON fa.film_id = f.film_id 
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE r.rental_date > (
    SELECT min(rental_date) 
    FROM rental r2 
    INNER JOIN inventory i2 ON r2.inventory_id = i2.inventory_id 
    INNER JOIN film f2 ON i2.film_id = f2.film_id 
    WHERE f2.title = 'SPARTACUS CHEAPER'
) 
ORDER BY a.last_name ASC;

--Punto 56: Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’
SELECT DISTINCT 
    a.first_name, 
    a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa ON a.actor_id = fa.actor_id
LEFT JOIN film AS f ON fa.film_id = f.film_id
LEFT JOIN film_category AS fc ON f.film_id = fc.film_id
LEFT JOIN category AS c ON fc.category_id = c.category_id AND c.name = 'Music'
WHERE c.name IS NULL
ORDER BY 
    a.last_name, 
    a.first_name;

   --Punto 57: Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT f.title 
FROM film f 
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE EXTRACT(DAY FROM (r.return_date - r.rental_date)) > 8;

--Punto 58: Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
SELECT DISTINCT f.title 
FROM film f 
JOIN inventory i ON f.film_id = i.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Animation';

/**Punto 59: Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. 
Ordena los resultados alfabéticamente por título de película.**/
SELECT f.title 
FROM film f 
WHERE f.length = (SELECT f2.length FROM film f2 WHERE f2.title = 'DANCING FEVER') 
ORDER BY f.title;

--Punto 60: Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT c.first_name, c.last_name 
FROM customer c 
INNER JOIN rental r ON c.customer_id = r.customer_id 
INNER JOIN inventory i ON r.inventory_id = i.inventory_id 
GROUP BY c.customer_id 
HAVING COUNT(DISTINCT i.film_id) >= 7 
ORDER BY c.last_name;

-- ESTO ES PARA SABER QUE PELICULAS ALQUILARON.
SELECT c.first_name, c.last_name, f.title 
FROM customer c 
INNER JOIN rental r ON c.customer_id = r.customer_id 
INNER JOIN inventory i ON r.inventory_id = i.inventory_id 
INNER JOIN film f ON i.film_id = f.film_id 
WHERE c.customer_id IN ( 
    SELECT c.customer_id 
    FROM customer c 
    INNER JOIN rental r ON c.customer_id = r.customer_id 
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id 
    GROUP BY c.customer_id 
    HAVING count(DISTINCT i.film_id) >= 7 
) 
ORDER BY c.last_name, f.title;

--Punto 61: Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name AS nombre_categoria, count(r.rental_id) AS recuento_alquileres
FROM category c 
INNER JOIN film_category fc ON c.category_id = fc.category_id 
INNER JOIN film f ON fc.film_id = f.film_id 
INNER JOIN inventory i ON f.film_id = i.film_id 
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY c.name 
ORDER BY recuento_alquileres DESC ;

--Punto 62: Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c.name AS category_name, count(f.film_id) AS numero_peliculas 
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
WHERE f.release_year = 2006 
GROUP BY c.name 
ORDER BY numero_peliculas  DESC;

--Punto 63: Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT s.first_name, s.last_name, st.store_id 
FROM staff s 
CROSS JOIN store st;

--Punto 64: Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals 
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id 
ORDER BY total_rentals DESC;

