/*E1*/
SELECT
    co.country_id,
    co.country, (
        SELECT COUNT(*)
        FROM city ci
        WHERE
            ci.country_id = co.country_id
    )
FROM country co
GROUP BY
    co.country,
    co.country_id;


/*E2*/
SELECT
    co.country_id,
    co.country, (
        SELECT COUNT(*)
        FROM city ci
        WHERE
            ci.country_id = co.country_id
    ) AS city_quant
FROM country co
GROUP BY
    co.country,
    co.country_id
HAVING city_quant > 10
ORDER BY city_quant DESC;


/*E3*/
SELECT
    CONCAT(c.first_name, ' ', c.last_name), (
        SELECT a.address
        FROM address a
        WHERE
            a.address_id = c.address_id
    ) AS 'address', (
        SELECT COUNT(*)
        FROM rental r
        WHERE
            r.customer_id = c.customer_id
    ) AS 'films quantity', (
        SELECT SUM(p.amount)
        FROM payment p
        WHERE
            p.customer_id = c.customer_id
    ) AS 'total'
FROM customer c
ORDER BY total DESC;


/*E4*/
SELECT ca.name, (
        SELECT AVG(f.length)
        FROM film f
        WHERE f.film_id IN(
                SELECT
                    fc.film_id
                FROM
                    film_category fc
                WHERE
                    fc.category_id = ca.category_id
            )
    ) AS average_length
FROM category ca
ORDER BY average_length DESC;


/*E5 PREGUNTARLE AL TEO SI ESTA BIEN*/
SELECT f.rating, (
        SELECT COUNT(*)
        FROM rental r
        WHERE
            r.inventory_id IN (
                SELECT
                    i.inventory_id
                FROM
                    inventory i
                WHERE
                    i.film_id IN (
                        SELECT f2.film_id
                        FROM film f2
                        WHERE f2.rating = f.rating
                    )
            )
    )
FROM film f
GROUP BY f.rating;
