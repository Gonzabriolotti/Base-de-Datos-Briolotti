use sakila;

/* ACTIVIDADES:
Show title and special_features of films that are PG-13
Get a list of all the different films duration.
Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
Show title, category and rating of films that have 'Behind the Scenes' as special_features
Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
Show the address, city and country of the store with id 1
Show pair of film titles and rating of films that have the same rating.
Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
 */

select title, special_features 
From film where rating = 'PG-13' 
order by length;

select title, legth as 'Largo en minutos' 
from film 
order by length
;

select title, rental_rate, replacement_cost 
from film 
order by length
;

select title, rental_rate, replacement_cost
from film
where replacement_cost 
between 20 AND 24
order by replacement_cost
;

select title,category.name ,rating
from film,category
where special_features =  'Behind the Scenes'
order by title
;


select actor.first_name as 'NOMBRE',actor.last_name as 'APELLIDO'
from actor,film
where film.title = 'ZOOLANDER FICTION'
;

select country as 'Nombre Pais', city as 'Nombre cuidad', address as 'Direcion'
from store 
join address on store.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where store_id = 1
;

select f1.title, f2.title, f1.rating
from film f1, film f2
where f1.rating = f2.rating AND f1.film_id <> f2.film_id
order by f1.title
;

select film.title as 'Nombre de la Pelicula'
from store
join inventory on store.store_id = inventory.store_id
join film on inventory.film_id = film.film_id
where store.store_id = 2
;