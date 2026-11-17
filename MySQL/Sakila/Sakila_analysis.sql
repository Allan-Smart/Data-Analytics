
/* ------------------------------------------------
 * -------------------- Sakila -------------------- 
 * ------------------------------------------------
 *
 * Purpose:
 * Analyse the Sakila database to practice writing
 * real-world SQL queries to uncover business insights
 * such as:
 *		- customer rental habits
 *		- store revenue
 *		- inventory performance
 *
 * By Allan Smart
 */

# Select the Sakila database:
USE sakila;

# Show all tables:
SHOW TABLES;
# OUTPUT: 23

/* -------------------- Descriptive Statistics -------------------- */

# Actor
# Count the number of rows:
SELECT 
    COUNT(1)
FROM
    actor;
# OUTPUT: 200

SELECT COUNT(*) FROM actor;

# Count the number of NULL rows
SELECT COUNT(*) 
FROM actor 
WHERE actor_id 		IS NULL
	OR first_name 	IS NULL
    OR last_name 	IS NULL
    OR last_update 	IS NULL;
# OUTPUT: 0

# Film and Film Category

# Count the number of rows for film:
SELECT
	COUNT(1)
FROM
	film;
# OUTPUT: 1000

# COUNT the number of rows for film category:
SELECT
	COUNT(1)
FROM
	film_category;
# OUTPUT: 1000

# Customer
# Count the number of rows:
SELECT
	COUNT(1)
FROM
	customer;
# OUTPUT: 599

/* -------------------- Analysis Statistics -------------------- */

	




