-- EJERCICIO 3 SQL - Relaciones de tablas (JOINS).

-- 2.1. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT      CONCAT(staff.first_name, ' ', staff.last_name), 
            store.store_id
FROM        staff
CROSS JOIN  store

-- 2.2. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT      CONCAT(customer.first_name, ' ', customer.last_name), 
            customer.customer_id,
			COUNT(rental.rental_id)
FROM        customer
CROSS JOIN  rental
GROUP BY customer.customer_id -- did NOT work

SELECT      CONCAT(customer.first_name, ' ', customer.last_name) AS Nombre, 
            customer.customer_id,
			COUNT(rental.inventory_id) AS Num_PeliculasAlquiladas
FROM        customer
LEFT JOIN rental ON customer.customer_id=rental.customer_id
GROUP BY customer.customer_id

-- 2.3 Obtener todas las películas y, si están disponibles en inventario, mostrar la cantidad disponible.
SELECT title, COUNT(inventory_id) 
	FROM film
LEFT JOIN inventory ON inventory.film_id=film.film_id
GROUP BY film.title

-- 2.4. Obtener los actores y el número de películas en las que ha actuado
SELECT 
    actor.first_name, actor.last_name, actor.actor_id,
    COUNT(film_actor.film_id)
FROM film_actor
RIGHT JOIN actor 
ON film_actor.actor_id = actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name

-- 2.5. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT film.title, film_actor.actor_id
FROM film
LEFT JOIN film_actor 
ON film_actor.film_id = film.film_id
GROUP BY film.title, actor_id -- weird solution

SELECT film.title, CONCAT(actor.first_name, ' ', actor.last_name)
	FROM film
LEFT JOIN film_actor 
ON film_actor.film_id = film.film_id
INNER JOIN actor 
ON film_actor.actor_id=actor.actor_id


-- 2.6. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT film.title, CONCAT(actor.first_name, ' ', actor.last_name) AS nombre_actor
	FROM film_actor
INNER JOIN actor 
ON film_actor.actor_id=actor.actor_id
RIGHT JOIN film
ON film.film_id=film_actor.film_id 

-- 2.7. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT film.film_id, film.title, inventory.inventory_id, rental.rental_date
FROM inventory
LEFT JOIN film ON film.film_id=inventory.film_id
LEFT JOIN rental ON rental.inventory_id=inventory.inventory_id
GROUP BY film.film_id, film.title, inventory.inventory_id, rental.rental_date
--

SELECT film.title, rental.rental_date 
FROM film
INNER JOIN inventory ON film.film_id=inventory.film_id
FULL JOIN rental ON rental.inventory_id=inventory.inventory_id
ORDER BY title ASC -- La película Academy Dinosaur sí se ha alquilado varias veces


-- 2.8. Encuentra el título de las películas que son de animación y tienen una duración mayor a 120 minutos en la tabla film.
SELECT film.title, category.name, film.length
FROM film
INNER JOIN film_category ON film.film_id=film_category.film_id
FULL JOIN category ON film_category.category_id=category.category_id
WHERE category.name ILIKE '%Animation'
AND film.length>=120 --YAYYY!

-- 2.9. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT category.name, AVG(film.length) AS Average_duration
FROM film
INNER JOIN film_category ON film.film_id=film_category.film_id
FULL JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name
HAVING AVG(film.length) >= 110
ORDER BY average_duration ASC


-- 2.10. Obtén los 5 clientes españoles que más dinero se hayan gastado con nosotros.
SELECT customer.customer_id, ROUND(SUM(payment.amount),2) AS Total_spent
FROM customer
LEFT JOIN payment ON payment.customer_id=customer.customer_id
GROUP BY customer.customer_id
ORDER BY Total_spent DESC
LIMIT 5

--Answer: 
526	221.55
148	216.54
144	195.58
137	194.61
178	194.61