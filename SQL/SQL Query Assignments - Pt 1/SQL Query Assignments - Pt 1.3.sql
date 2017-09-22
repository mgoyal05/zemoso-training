select distinct customer.*, country.country, category.name 
FROM film 
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join customer on  rental.customer_id = customer.customer_id
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
where category.name = 'Sports' AND country.country = 'India'
ORDER BY customer.customer_id;