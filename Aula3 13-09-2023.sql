// Select com Junções entre Tabelas, INNER JOIN, LEFT JOIN, RIGHT JOIN. (Banco SAKILA).
// Autor: Ricardo Roberto de Lima.

// INNER JOIN:

01 - Liste os filmes e seus atores: Este comando exibe todos os filmes e os atores que atuaram neles.

SELECT film.title, actor.first_name, actor.last_name
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id;


02 - Mostre os clientes que alugaram filmes e seus respectivos endereços: Este comando lista todos os clientes que alugaram filmes e seus endereços correspondentes.

SELECT customer.first_name, customer.last_name, address.address
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN rental ON customer.customer_id = rental.customer_id;
LEFT JOIN:

03 - Liste todos os filmes e seus atores (incluindo filmes sem atores): Este comando exibe todos os filmes, mesmo aqueles que não têm atores listados.

SELECT film.title, actor.first_name, actor.last_name
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id;

04 - Mostre todos os atores e seus filmes (incluindo atores que não atuaram em filmes): Este comando lista todos os atores, mesmo aqueles que não atuaram em nenhum filme.

SELECT actor.first_name, actor.last_name, film.title
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id;
RIGHT JOIN:

05 - Liste todos os atores e seus filmes (incluindo filmes sem atores): Este comando exibe todos os atores, mesmo aqueles que não atuaram em nenhum filme.

SELECT actor.first_name, actor.last_name, film.title
FROM actor
RIGHT JOIN film_actor ON actor.actor_id = film_actor.actor_id
RIGHT JOIN film ON film_actor.film_id = film.film_id;

06 - Mostre todos os clientes e seus aluguéis (incluindo clientes que não alugaram nada): Este comando lista todos os clientes, mesmo aqueles que não fizeram nenhum aluguel.

SELECT customer.first_name, customer.last_name, rental.rental_date
FROM customer
RIGHT JOIN rental ON customer.customer_id = rental.customer_id;
FULL JOIN (Não suportado pelo MySQL):

07 - Liste todos os atores e seus filmes (incluindo filmes sem atores) usando UNION de LEFT JOIN e RIGHT JOIN:

SELECT actor.first_name, actor.last_name, film.title
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
UNION
SELECT actor.first_name, actor.last_name, film.title
FROM actor
RIGHT JOIN film_actor ON actor.actor_id = film_actor.actor_id
RIGHT JOIN film ON film_actor.film_id = film.film_id;

08 - Mostre todos os clientes e seus aluguéis (incluindo clientes que não alugaram nada) usando UNION de LEFT JOIN e RIGHT JOIN:

SELECT customer.first_name, customer.last_name, rental.rental_date
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
UNION
SELECT customer.first_name, customer.last_name, rental.rental_date
FROM customer
RIGHT JOIN rental ON customer.customer_id = rental.customer_id;



