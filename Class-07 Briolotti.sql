#Find the films with less duration, show the title and rating.
select title, rating, length
from film
where length = (select min(length) from film);

#Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.

select title, rating, length
from film
where length < ALL (select min(length) from film);


#Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.

SELECT c.first_name as nombre,c.last_name as apellido, a.address as Direccion,
	(SELECT min(amount) FROM payment p WHERE c.customer_id = p.customer_id ) as Paga
FROM customer c
JOIN address a on c.address_id = a.address_id
ORDER BY c.first_name
;

#Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.

SELECT c.first_name as nombre,c.last_name as apellido, a.address as Direccion,
	(SELECT MIN(amount) FROM payment p WHERE c.customer_id = p.customer_id ) as Paga_Minima, 
    (SELECT MAX(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS paga_maxima
FROM customer c
JOIN address a on c.address_id = a.address_id
ORDER BY c.first_name
;