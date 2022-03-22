#pelao
/* #Create tables: film (film_id, title, description, release_year); actor (actor_id, first_name, last_name) , film_actor (actor_id, film_id)
 */
create table film(
    film_id int not null AUTO_INCREMENT,
    title VARCHAR(25),
    descripcion varchar(25),
    release_year int 
    PRIMARY KEY(film_id)
);
create table actor(
    actor_id int not null AUTO_INCREMENT,
    first_name varchar(25),
    last_name varchar(25),
    PRIMARY KEY(actor_id)
);
CREATE TABLE film_actor(
	actor_id int NOT NULL,
	film_id int NOT NULL 
);


/* #Alter table add column last_update to film and actor
 */
alter table film
ADD COLUMN last_update TIMESTAMP
	DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP 
;

alter table actor
	ADD COLUMN last_update TIMESTAMP 
		DEFAULT CURRENT_TIMESTAMP 
		ON UPDATE CURRENT_TIMESTAMP
;	
	
/* #Alter table add foreign keys to film_actor table
 */
alter table film_actor
	add foreing key actor_id REFERENCES (actor)actor_id
	add foreing key film_id REFERENCES (film)film_id
;

	
/* #Insert some actors, films and who acted in each film	
 */
insert into actor (first_name, last_name)
values (saca, kk)
values (numa, cunado)
values (mati, tata)
;

insert into film (title, descripcion, release_year)
values (peter pan, pan peter, 2003-04-27)
values (bambi, bambi, 2001-03-12)
;

