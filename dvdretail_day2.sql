-- queries to check out staff and rental table
SELECT *
FROM staff;

SELECT *
FROM rental;

--query to check
SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL OUTER JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id;

SELECT *
FROM actor;

SELECT *
FROM film_actor;

--inner join to see which actors were in which films by id
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

--double inner join to see which actors were in which films by film title
SELECT actor.actor_id, first_name, last_name, film.film_id, title
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL and last_name IS NULL;

--query for actors who are not in any movies
--full join
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
FULL JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_id IS NULL;

--join to find customers who live in Angola
SELECT customer.first_name, customer.last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id -- primary key for address
INNER JOIN city
ON address.city_id = city.city_id -- rpimary key for city
INNER JOIN country
ON city.country_id = country.country_id --primary key for country
WHERE country.country = 'Angola';


INSERT INFO customer(customer_id, store_id, first_name, last_name)
VALUES(601, 1, 'Frodo', 'Baggins');

--subqueries
--kind of like 2 queries split apart and then combine to return the data
--find a customer_id that has an amount greater than 175 in total payments

SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id = 148 OR customer_id = 526 OR customer_id = 178;

--subquery version
SELECT first_name, last_name, store_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC --optional
)
GROUP BY store_id, first_name, last_name; --not necessary in this 

SELECT *
FROM language;

SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM "language"
	WHERE name != 'English'
);

--customer whol live in Dallas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'
	)
);

SELECT * 
FROM category;

-- Grab all movies from the action category
SELECT title, film_id
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = 'Action'
		
	)
)

-- Use subquery to find customers who live in Angola
SELECT first_name, last_name
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Angola'
		)
	)
);


-- Grab the staff_id of the staff who has made the most rental transactions for 
-- customer who's name is Barbara Jones. 
-- Bonus points if you can bring back the staff name.
SELECT staff_id, COUNT(staff_id)
FROM rental
WHERE customer_id IN (
	SELECT customer_id
	FROM customer
	WHERE first_name = 'Barber' AND last_name = 'Jones'
)
GROUP BY staff_id
ORDER BY COUNT (staff_id) DESC
LIMIT 1;

SELECT first_name, last_name. staff_id
FROM staff
WHERE staff_id = (
	SELECT staff_id
	FROM rental
	WHERE customer_id IN (
		SELECT customer_id
		FROM customer
		WHERE first_name = 'Barbara' AND last_name = 'jones'
	)
	GROUP BY staff_id
	ORDER BY COUNT*staff_id
	LIMIT; 1
)



--
SELECT staff_id, fist_name, last_name
FROM staff
WHERE staff_id IN (
	SELECT staff_id, COUNT(customer_id)
	FROM payment
	WHERE customer_id IN (
		SELECT customer_id
		FROM customer
		WHERE first_name = 'Barbara' AND last_name = 'Jones'
	)
)
