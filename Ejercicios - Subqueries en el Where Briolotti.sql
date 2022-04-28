#BRIOLOTTILUCASGONZALO
use sakila;


# List all the actors that share the last name. Show them in order
select a1.actor_id,a1.last_name
from actor a1 , actor a2
where a1.last_name = a2.last_name AND a1.actor_id <> a2.actor_id
order by a1.last_name;


#Find actors that dont work in any film.
select a.first_name, a.last_name
from actor a
where not EXISTS  (select * 
    from film_actor fa
    where a.actor_id = fa.actor_id);


#Find customers that rented only one film.
select c.first_name, c.last_name
from customer c 
where 1 = (select count(*) from rental r where c.customer_id = r.customer_id);


#Find customers that rented more than one film
select c.first_name, c.last_name
from customer c 
where 1 < (select count(*) from rental r where c.customer_id = r.customer_id);


#List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'.
select a.first_name, a.last_name
from actor a
where actor_id in (select actor_id from film_actor fa where fa.film_id in (select f.film_id from film f where f.title like "BETRAYED REAR" or f.title like "CATCH AMISTAD"));


#List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'.
select a.first_name, a.last_name
from actor a
where actor_id in (
  select actor_id 
  from film_actor fa 
  where fa.film_id IN (
    select f1.film_id 
    from film f1 
    where f1.title 
    like 'BETRAYED REAR' 
    and f1.film_id not in (
      select f2.film_id 
      from film f2 
      where f2.title 
      like 'CATCH AMISTAD')));


#List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'.
select a.first_name, a.last_name
from actor a
where actor_id in (
  select actor_id 
  from film_actor fa 
  where fa.film_id in (
    select f1.film_id 
    from film f1 
    where f1.title 
    like 'BETRAYED REAR' 
    and f1.film_id in (
      select f2.film_id 
      from film f2 
      where f2.title 
      like 'CATCH AMISTAD')));

     
#List all the actors that didnt work in 'BETRAYED REAR' or 'CATCH AMISTAD'.
select a.first_name, a.last_name
from actor a
where actor_id not in (
  select actor_id 
  from film_actor fa 
  where fa.film_id IN (
    select f1.film_id 
    from film f1 
    where f1.title 
    like 'BETRAYED REAR' 
    or f1.film_id in (
      select f2.film_id 
      from film f2 
      where f2.title 
      like 'CATCH AMISTAD')));
      
     
     
     
     
#selallevaelquecopia