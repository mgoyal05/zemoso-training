SELECT film.* 
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE film.rating = 'PG-13' AND category.name = 'Comedy';

select * FROM film
where rating = "PG-13" AND film_id IN
(select film_id 
from film_category
Where category_id = "5");