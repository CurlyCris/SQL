-- 2º Reto Guiado SQL: Queries Avanzadas.

-- 2.1. Ordena las películas por duración de forma ascendente
SELECT title, length FROM film
ORDER BY length ASC

-- 2.2. Muestra los 10 clientes con mayor valor de id
SELECT CONCAT(first_name, ' ', last_name) as nombre_completo, customer_id
FROM customer
ORDER BY customer_id
LIMIT 10

-- 2.3. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT payment_id, payment_date, amount FROM payment
ORDER BY payment_date DESC
LIMIT 1
OFFSET 3 --385	"2006-02-14 15:16:03"	4.99

-- 2.4. Qué películas se alquilan por encima del precio medio. Para este ejercicio tendrás que generar dos queries diferentes. Una primera para calcular la media y la segunda para obtener las películas que se alquilan por encima de ese valor.
SELECT  ROUND(AVG(rental_rate),2)     
FROM film

SELECT title, rental_rate     
FROM film
WHERE rental_rate > 2.98

-- 2.5. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT 
    name, 
    COUNT(film_category.film_id) AS Film_Count
FROM category
JOIN film_category
	ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY Film_Count DESC
--
SELECT      rating, 
            COUNT(film_id) 
FROM        film
GROUP BY    rating 

-- 2.6. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT      rating, 
            COUNT(film_id),
			AVG(length)
FROM        film
GROUP BY    rating 

-- 2.7. Números de alquileres por día. Ordenados por cantidad de alquileres de forma descendente.
SELECT      COUNT(rental_id), rental_date
FROM        rental
GROUP BY    rental_date 
ORDER BY rental_date DESC
--
SELECT      COUNT(payment_id), payment_date
FROM        payment
GROUP BY    payment_date 
ORDER BY payment_date DESC

-- 2.8. Averigua el número de alquileres registrados por mes.
SELECT      EXTRACT(MONTH FROM rental_date)   AS Mes_Alquiler,
            COUNT(rental_id)                  
FROM        rental
GROUP BY    Mes_Alquiler
ORDER BY    Mes_Alquiler

-- 2.9. Número de películas por categoría estrenadas en 2006
SELECT      EXTRACT(YEAR FROM last_update)   AS Fecha_año,
            COUNT(film_id)                  
FROM        film_category
GROUP BY    Fecha_año
ORDER BY    Fecha_año
--
SELECT      rating, 
            COUNT(film_id)    AS Total_Películas
FROM        film
WHERE       release_year = 2006 
GROUP BY    rating


-- 2.10. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT actor_id,
FROM film_actor
WHERE COUNT(actor_id)>40
GROUP BY film_actor -- WRONG!!
-- SELECT actor_id
FROM film_actor
GROUP BY actor_id
HAVING COUNT(DISTINCT(actor_id))>40
