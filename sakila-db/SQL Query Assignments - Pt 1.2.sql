SELECT film.film_id,film.title, count(film.film_id) AS no_of_times_rented
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE category.name = 'Horror'
GROUP BY film.title
ORDER BY no_of_times_rented DESC
LIMIT 3;

insert into Ticket(Reservation, PNR_No, Customer_User_Id) values('R',122,112);
select * from Ticket;
select * FROM Drives;
select * from Cab,Driver;
select * from Driver;
insert into Driver(Driver_id, Name) values(5, 'M');
insert into Cab(Cab_id, Driver_id) values(2,1);
drop table Employee;
alter table Driver
ADD Constraint ckt CHECK(Driver.License_No IS NOT NULL AND Driver.Sex(M/F) = 'M');
select * from ckt;
drop table Project;