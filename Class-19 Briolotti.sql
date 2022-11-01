/*
Exercise 1
Create a user data_analyst
*/
CREATE USER data_analyst IDENTIFIED BY 'password';

SELECT user, host FROM mysql.user;

/*
Exercise 2
Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
*/
SHOW GRANTS FOR 'data_analyst'@'%';

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'%';

/
*Exercise 3
Login with this user and try to create a table. Show the result of that operation.
*/
USE sakila;

CREATE TABLE test(
    test_id INT(11) NOT NULL AUTO_INCREMENT
);  


/*
Exercise 4
Try to update a title of a film. Write the update script.
*/
SELECT * FROM film LIMIT 10;

UPDATE film SET title = 'Relatos Salvajes' WHERE film_id = 10;

SELECT * FROM film LIMIT 10;

/*
Exercise 5
With root or any admin user revoke the UPDATE permission. Write the command
*/
SHOW GRANTS FOR 'data_analyst'@'%';

REVOKE UPDATE ON sakila.* FROM data_analyst;

SHOW GRANTS FOR 'data_analyst'@'%';

/*
Exercise 6
Login again with data_analyst and try again the update done in step 4. Show the result.
*/
USE sakila;

SELECT * FROM film LIMIT 10;

UPDATE film SET title = 'Misterio a Bordo' WHERE film_id = 10;

/*Pelado Briolotti*/
