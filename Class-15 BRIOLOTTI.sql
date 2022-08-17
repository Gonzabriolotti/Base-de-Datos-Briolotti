/*EJER1*/ 
CREATE
OR
REPLACE
VIEW list_of_customers AS
SELECT
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name),
a.address,
a.postal_code,
a.phone,
ci.city,
co.country,
CASE
WHEN c.active = 1 THEN 'Active'
ELSE 'Inactive'
END 'Status'
FROM customer c
INNER JOIN address a USING(address_id)
INNER JOIN city ci USING(city_id)
INNER JOIN country co USING(country_id);

SELECT * FROM list_of_customers;

SELECT
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name),
a.address,
a.postal_code,
a.phone,
ci.city,
co.country,
CASE
WHEN c.active = 1 THEN 'Active'
ELSE 'Inactive'
END 'Status'
FROM customer c
INNER JOIN address a USING(address_id)
INNER JOIN city ci USING(city_id)
INNER JOIN country co USING(country_id);

/*EJER2*/ 
CREATE
OR
REPLACE VIEW film_details AS
SELECT
f.film_id,
f.title,
f.description,
ca.name AS 'Category',
f.rental_rate AS 'Price',
f.length,
f.rating,
GROUP_CONCAT(
CONCAT(a.first_name, ' ', a.last_name)
) AS 'Actors'
FROM film f
INNER JOIN film_category USING(film_id)
INNER JOIN category ca USING(category_id)
INNER JOIN film_actor USING(film_id)
INNER JOIN actor a USING(actor_id)
GROUP BY film_id, ca.name;

SELECT * FROM film_details;

/*EJER3*/ 
CREATE
OR
REPLACE
VIEW sales_by_film_category AS
SELECT
ca.name,
COUNT(r.rental_id) AS total_rental
FROM film
INNER JOIN film_category USING(film_id)
INNER JOIN category ca USING(category_id)
INNER JOIN inventory USING(film_id)
INNER JOIN rental r USING(inventory_id)
GROUP BY ca.name;

SELECT * FROM sales_by_film_category;

/*EJER4*/ 
CREATE
OR
REPLACE
VIEW actor_information AS
SELECT
a.actor_id,
CONCAT(a.first_name, ' ', a.last_name) AS 'Actor',
COUNT(film_id) AS 'Films Acted'
FROM actor a
INNER JOIN film_actor USING(actor_id)
INNER JOIN film USING(film_id)
GROUP BY a.actor_id
ORDER BY a.last_name;

SELECT * FROM actor_information;

/*EJER5*/ 
SELECT VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'actor_info';

select
`a`.`actor_id` AS `actor_id`,
`a`.`first_name` AS `first_name`,
`a`.`last_name` AS `last_name`,
group_concat(
distinct concat(
 `c`.`name`,
': ', (
select
group_concat(
`f`.`title`
order by
`f`.`title` ASC separator ', '
)
from ( (
`sakila`.`film` `f`
join `sakila`.`film_category` `fc` on( (`f`.`film_id` = `fc`.`film_id`)
)
)
join `sakila`.`film_actor` `fa` on( (`f`.`film_id` = `fa`.`film_id`)
)
)
where ( (
`fc`.`category_id` = `c`.`category_id`
)
and (
`fa`.`actor_id` = `a`.`actor_id`
)
)
)
)
order by
`c`.`name` ASC separator '; '
) AS `film_info`
from ( ( (
 `sakila`.`actor` `a`
left join `sakila`.`film_actor` `fa` on( (
 `a`.`actor_id` = `fa`.`actor_id`
)
)
)
left join `sakila`.`film_category` `fc` on( (
`fa`.`film_id` = `fc`.`film_id`
)
)
)
left join `sakila`.`category` `c` on( (
`fc`.`category_id` = `c`.`category_id`
)
)
)
group by
`a`.`actor_id`,
`a`.`first_name`,
`a`.`last_name`;

/*
TAKE DATA FROM THE ACTOR TABLE AND ASSIGN THEM A NAME BY WHICH IT WILL BE REPRESENTATIVE
WE FOUND THE FIRST CONCAT GROUP WITH A SUBQUERY TO SHOW THE INFORMATION OF THE MOVIES IN REFERENCE TO THE ACTOR.
THEN IN THE WHERE YOU USE IT TO VERIFY IF YOU ARE THE CORRECT ACTOR AND CATEGORY.
*/

/*EJER16*/ 
/*Views
They evaluate the data in the tables underlying the view definition at the time the view is queried. It is a logical view of your tables, with no data stored anywhere else.
The upside of a view is that it will always return the latest data to you. The downside of a view is that its performance depends on how good a select statement the view is based on. If the select statement used by the view joins many tables, or uses joins based on non-indexed columns, the view could perform poorly.
Materialized views
They are similar to regular views, in that they are a logical view of your data (based on a select statement), however, the underlying query result set has been saved to a table. The upside of this is that when you query a materialized view, you are querying a table, which may also be indexed.
In addition, because all the joins have been resolved at materialized view refresh time, you pay the price of the join once (or as often as you refresh your materialized view), rather than each time you select from the materialized view. In addition, with query rewrite enabled, Oracle can optimize a query that selects from the source of your materialized view in such a way that it instead reads from your materialized view. In situations where you create materialized views as forms of aggregate tables, or as copies of frequently executed queries, this can greatly speed up the response time of your end user application. The downside though is that the data you get back from the materialized view is only as up to date as the last time the materialized view has been refreshed.
View: View is just a named query. It doesn't store anything. When there is a query on view, it runs the query of the view definition. Actual data comes from table.
Materialised views: Stores data physically and get updated periodically. While querying MV, it gives data from MV.
https://stackoverflow.com/questions/93539/what-is-the-difference-between-views-and-materialized-views-in-oracle
*/