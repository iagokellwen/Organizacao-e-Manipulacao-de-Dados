// Aluno: Iago kellwen
// CD - Banco de dados

01 - Liste os clientes que alugaram o filme 'BULL DURHAM' e suas informações de contato:

SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    WHERE title = 'BULL DURHAM'
);

02 - Mostre todos os filmes alugados pelo cliente 'MARY SMITH':

SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE customer_id = (
            SELECT customer_id
            FROM customer
            WHERE first_name = 'MARY' AND last_name = 'SMITH'
        )
    )
);

03 - Obtenha a lista de atores que atuaram em pelo menos um filme da categoria 'Horror':

SELECT DISTINCT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film_category
        WHERE category_id = (
            SELECT category_id
            FROM category
            WHERE name = 'Horror'
        )
    )
);

04 - Encontre os títulos dos filmes que foram alugados mais de 10 vezes:

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM rental
    GROUP BY film_id
    HAVING COUNT(rental_id) > 10
);


05 - Mostre os clientes que não alugaram nenhum filme desde o início do banco de dados (clientes inativos):

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM rental
);

06 - Liste os atores que atuaram em filmes lançados após 2005:

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE release_year > 2005
    )
);

07 - Obtenha os filmes que ainda não foram alugados:

SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT film_id
    FROM rental
);

08 - Mostre os clientes que mais alugaram filmes e quantos aluguéis eles fizeram:

SELECT customer_id, first_name, last_name, total_alugueis
FROM customer
JOIN (
    SELECT customer_id, COUNT(rental_id) AS total_alugueis
    FROM rental
    GROUP BY customer_id
    ORDER BY total_alugueis DESC
    LIMIT 5
) AS top_customers ON customer.customer_id = top_customers.customer_id;

09 - Liste os filmes que não foram alugados nos últimos 30 dias:

SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT film_id
    FROM rental
    WHERE rental_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
);

10 - Mostre os filmes que foram alugados mais de uma vez pelo mesmo cliente:

SELECT title, customer_id, COUNT(*) AS total_alugueis
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental_id IN (
    SELECT rental_id
    FROM rental
    GROUP BY rental_id
    HAVING COUNT(*) > 1
)
GROUP BY title, customer_id
ORDER BY title, customer_id;



