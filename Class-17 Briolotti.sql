/*EJER1*/
SELECT *
FROM address ad
INNER JOIN city ci USING(city_id)
INNER JOIN country
WHERE ad.postal_code IN(
SELECT postal_code
FROM address
WHERE
address LIKE '%y'
AND postal_code IN(
SELECT
postal_code
FROM address
WHERE
postal_code LIKE '%9'
)
);


CREATE INDEX addressIndex ON address(postal_code);
DROP INDEX addressIndex ON address;


/*The response speed of the query is faster when creating an index, SQL uses it to select a table in a certain place instead of scanning the whole*/

/*EJER2*/

SELECT first_name
FROM actor;
SELECT last_name FROM actor;

/*The query is faster because last name has an index*/

/*EJER3*/ 

CREATE FULLTEXT INDEX descIndex ON film(description);
DROP INDEX descIndex ON film;


SELECT f.description
FROM film f
WHERE
f.description LIKE '%Epic%';



SELECT f.description
FROM film f
WHERE
MATCH(f.description) AGAINST('Epic' IN NATURAL LANGUAGE MODE);
