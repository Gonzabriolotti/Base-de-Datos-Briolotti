/* 
EXERCISE 1
*/
SELECT CONCAT_WS(" ",first_name,last_name) as name, address.address, city.city
FROM customer 
	INNER JOIN address USING(address_id)
	INNER JOIN city USING(city_id)
	INNER JOIN country USING(country_id)
WHERE country.country LIKE 'Argentina';

/*
EXERCISE 2
*/
SELECT title, `language`.name, 
CASE
	WHEN rating = 'G' THEN '(General Audiences) – All ages admitted.'
	WHEN rating = 'PG' THEN '(Parental Guidance Suggested) – Some material may not be suitable for children.'
	WHEN rating = 'PG-13' THEN '(Parents Strongly Cautioned) – Some material may be inappropriate for children under'
	WHEN rating = 'R' THEN '(Restricted) – Under 17 requires accompanying parent or adult guardian.'
	WHEN rating = 'NC-17' THEN '(Adults Only) – No one 17 and under admitted.'
END AS rating_description
  FROM film
 		INNER JOIN `language` USING (language_id);

/*
EXERCISE 3 
*/

SELECT title, release_year
  FROM film 
	INNER JOIN film_actor USING(film_id)
	INNER JOIN actor USING(actor_id)
WHERE CONCAT_WS(" ",first_name,last_name)
LIKE TRIM(UPPER("                                           ed chase                                                                                                                                    "));

/*
EXERCISE 4
*/
SELECT f.title,
	   CONCAT_WS(" ", c.first_name, c.last_name) as name,
	   CASE WHEN r.return_date IS NOT NULL THEN 'Yes'
	   		ELSE 'No'
	   	END AS was_returned,
	   MONTHNAME(r.rental_date) as month
  FROM film f
  	INNER JOIN inventory i USING(film_id)
  	INNER JOIN rental r USING(inventory_id)
  	INNER JOIN customer c USING(customer_id)
WHERE MONTHNAME(r.rental_date) LIKE 'May'
   OR MONTHNAME(r.rental_date) LIKE 'June';

/*
EXERCISE 5
*/

SELECT CAST(last_update AS DATE) as only_date FROM rental;

SELECT CONVERT("2003-10-01", DATETIME);
/*
6 EXERCISE 
*/


SELECT rental_id, IFNULL(return_date, 'Films not here') as return_date FROM rental;

/* ISNULL() function returns 1 if the expression passed is NULL, otherwise it returns 0.*/
SELECT rental_id, ISNULL(return_date) as pelicula_faltante FROM rental;

/* COALESCE() function returns the first non-NULL argument of the passed list.*/
SELECT COALESCE(NULL,
(SELECT return_date FROM rental WHERE rental_id = 12746),
(SELECT f.title FROM film f LIMIT 1)) AS 'da thing';