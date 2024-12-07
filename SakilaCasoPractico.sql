-- 1º Reto Guiado SQL: Queries Básicas

-- 3.1. Crea el esquema de la BBDD de sakila


-- 3.2. Selecciona todos los nombres de las películas úncos.
SELECT DISTINCT title FROM film

-- 3.3. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT first_name, last_name FROM actor

-- 3.4 Muestra los nombres de todas las películas con una clasificación por edades de "R".
SELECT title FROM film
WHERE rating = 'R'

-- 3.5. Obtén las películas que tenemos cuyo idioma conicide con el idioma original
SELECT title FROM film
WHERE language_id=original_language_id

-- 3.6. Encuentra el nombre y apellido de los actores que tengan "Allen"" en su apellido.
SELECT first_name, last_name FROM actor
WHERE last_name ILIKE '%Allen%'

-- 3.7. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT title FROM film
WHERE length >= 180

-- 3.8. Encuentra los nombres de los actores que tengan un actor_id entre 30 y 40
SELECT first_name, last_name FROM actor
WHERE actor_id BETWEEN 30 AND 40

-- 3.9. Encuentra el título de las películas en la tabla film que no sean ni "NC-17" ni "G" en cuanto a su clasificación
SELECT title, rating FROM film
WHERE rating <> 'NC-17' AND rating <> 'G'

-- 3.10. Encuentra el título de todas las películas que son "PG-13" o tienen una duración mayor a 3 horas en la tabla film.
SELECT title, rating, length as duracion FROM film
WHERE rating = 'PG-13' OR length > 180

-- 3.11. Encuentra la mayor y menor duración de una película de nuestra BBDD
SELECT MAX(length) as duration_max, MIN(length) as duration_min FROM film

-- 3.12. ¿Cuántas películas distintas tenemos?
SELECT DISTINCT COUNT(film) FROM film -- Resultado : 1000 films

-- 3.13. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM(amount) FROM payment -- Total = 67416.51

-- 3.14. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(rental_duration) FROM film -- Resultado : 4.985

-- 3.15. Encuentra la variabilidad de los que costaría reemplazar las películas
SELECT STDDEV_SAMP(replacement_cost) as Coste_reemplazamiento FROM film -- Resultado: 6.05