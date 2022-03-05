USE sakila;

# 1. List each pair of actors that have worked together.
SELECT 
    first.actor_id AS actor_1, second.actor_id AS actor_2, title
FROM
    film_actor AS first
        JOIN
    film_actor AS second ON first.actor_id = second.film_id
        JOIN
    film ON first.film_id = film.film_id;

# 2. For each film, list actor that has acted in more films. 
SELECT film_actor_count.film_id, film_actor_count.actor_id, first_name, last_name FROM
(SELECT 
	film_id, actor_id, COUNT(film_id) OVER (PARTITION BY actor_id) AS number_of_films
FROM
	film_actor
GROUP BY
	film_id, actor_id
ORDER BY
	film_id ASC) AS film_actor_count
JOIN actor
ON actor.actor_id = film_actor_count.actor_id
WHERE 
	number_of_films > 1;