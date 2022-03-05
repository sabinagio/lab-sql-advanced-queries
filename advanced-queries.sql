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

# 2. For each film, list actor that has acted in the most films. 
SELECT 
	film_id, first_name, last_name
FROM 
	actor
JOIN
(SELECT 
	film_id, actor_id 
FROM
	(SELECT 
		film_id, actor_id, RANK() OVER (PARTITION BY film_id ORDER BY number_of_films DESC) AS actor_ranking
	FROM    
		(SELECT 
			film_id, actor_id, COUNT(*) OVER (PARTITION BY actor_id) AS number_of_films
		FROM
			film_actor) 
		AS film_actors) 
	AS film_rankings
WHERE 
	actor_ranking = 1)
AS selected_actors
ON selected_actors.actor_id = actor.actor_id;