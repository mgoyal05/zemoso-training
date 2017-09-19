SELECT COUNT(film.film_id) AS total_no_of_movies
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'SEAN' AND actor.last_name = 'WILLIAMS';