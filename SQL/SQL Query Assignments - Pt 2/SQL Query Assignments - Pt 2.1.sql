SELECT COUNT(film.film_id) AS number_of_documentaries
FROM film
WHERE film.description LIKE '%Documentary%' AND film.special_features LIKE '%Deleted Scenes%';