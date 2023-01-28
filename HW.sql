-- Question 1: List all customers who live in Texas with JOINS.
SELECT customer.first_name, customer.last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
--INNER JOIN address
--ON address.district = district.district
WHERE district = 'Texas';

--Question 2: Get all payments above $6.99 with full customer name
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING COUNT(amount) > 6.99
	ORDER BY COUNT(amount) DESC
);

--Question 3: Show all customers name who have made payments over 175 using subqueries
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC 
);

--Question 4: List all customers that live in Napal using city table
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
			WHERE country = 'Nepal'
		)
	)
);

--Question 5: Which staff member had the most transactions?
SELECT staff_id
FROM staff
WHERE staff_id IN(
	SELECT staff_id
	FROM rental
	WHERE staff.staff_id = rental.staff_id and rental.rental_date = rental.rental_date
); --need help

--Question 6: How many movies of each rating are there?
SELECT inventory.inventory_id, film.rating
FROM inventory
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE film_id IS rating;

--Question 7: Show all customers who have made a single payment above $6.99 using subqueries
SELECT first_name,last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING COUNT(amount) > 6.99
)
GROUP BY store_id,first_name,last_name;

--Question 8: How many free rentals did our stores give away. --not understanding question.



