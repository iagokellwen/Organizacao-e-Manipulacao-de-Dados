// Fun��es de Agrega��o - comandos Select.
// Autor: Ricardo Roberto de Lima.

01 - Qual � a receita total da loja at� o momento?
SELECT SUM(amount) AS receita_total
FROM payment;
Resposta: A receita total da loja at� o momento � [valor].

02 - Quantos clientes est�o registrados na loja?
SELECT COUNT(customer_id) AS total_clientes
FROM customer;
Resposta: H� um total de [n�mero] clientes registrados na loja.

03 - Qual � o filme mais longo na loja?
SELECT title, MAX(length) AS duracao_maxima
FROM film;
Resposta: O filme mais longo na loja � "[t�tulo]" com uma dura��o de [dura��o] minutos.

04 - Quantos filmes cada categoria possui?
SELECT category.name AS categoria, COUNT(film_category.film_id) AS total_filmes
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
GROUP BY categoria;
Resposta: A categoria "[categoria]" possui [n�mero] filmes.

05 - Qual � a m�dia de alugu�is por cliente?
SELECT AVG(rentals_per_customer) AS media_alugueis_por_cliente
FROM (
    SELECT customer_id, COUNT(rental_id) AS rentals_per_customer
    FROM rental
    GROUP BY customer_id
) AS subquery;
Resposta: A m�dia de alugu�is por cliente � [valor].

06 - Qual � o n�mero total de atores no banco de dados?
SELECT COUNT(*) AS total_atores
FROM actor;

07 - Qual � a soma total de alugu�is de filmes at� o momento?
SELECT SUM(amount) AS total_alugueis
FROM payment;

08 - Qual � a dura��o m�dia de todos os filmes na loja?
SELECT AVG(length) AS duracao_media
FROM film;

09 - Quantos filmes foram alugados no m�s de janeiro de 2006?

SELECT COUNT(*) AS total_alugueis_janeiro_2006
FROM rental
WHERE rental_date BETWEEN '2006-01-01' AND '2006-01-31';

10 - Qual � o valor m�dio dos alugu�is por categoria de filme?
SELECT category.name AS categoria, AVG(payment.amount) AS valor_medio_aluguel
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY categoria;

11 - Qual � o ator que mais aparece em filmes?
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS total_filmes_atuados
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY total_filmes_atuados DESC
LIMIT 1;

12 - Quantos filmes t�m uma classifica��o indicativa (rating) de 'PG-13'?
SELECT COUNT(*) AS total_filmes_PG13
FROM film
WHERE rating = 'PG-13';

13 - Qual � o dia mais movimentado em termos de alugu�is de filmes?
SELECT DATE(rental_date) AS data_aluguel, COUNT(*) AS total_alugueis
FROM rental
GROUP BY data_aluguel
ORDER BY total_alugueis DESC
LIMIT 1;

14 - Qual � o valor total gasto por cada cliente em alugu�is de filmes?
SELECT customer_id, SUM(amount) AS total_gasto
FROM payment
GROUP BY customer_id;

15 - Quantos atores diferentes atuaram em filmes do g�nero "Com�dia"?
SELECT COUNT(DISTINCT actor.actor_id) AS total_atores_comedia
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_actor.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy';

16 - Qual � o filme mais recente dispon�vel para aluguel?
SELECT title, release_year
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT inventory.film_id
    FROM inventory
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    WHERE rental.return_date IS NULL
)
ORDER BY release_year DESC
LIMIT 1;

17 - Quantos clientes alugaram mais de 10 filmes?
SELECT customer_id, COUNT(rental_id) AS total_alugueis
FROM rental
GROUP BY customer_id
HAVING total_alugueis > 10;

18 - Qual � o valor total dos alugu�is de cada m�s em 2005?
SELECT DATE_FORMAT(rental_date, '%Y-%m') AS mes, SUM(amount) AS total_alugueis
FROM payment
WHERE DATE_FORMAT(rental_date, '%Y') = '2005'
GROUP BY mes;

19 - Quantos filmes cada ator principal atuou em?
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS total_filmes_atuados
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.ordem = 1
GROUP BY actor.actor_id
ORDER BY total_filmes_atuados DESC;

20 - Qual � o filme mais alugado da categoria 'Horror'?
SELECT film.title, COUNT(rental.rental_id) AS total_alugueis
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE category.name = 'Horror'
GROUP BY film.title
ORDER BY total_alugueis DESC
LIMIT 1;

Certifique-se de ajustar os nomes das tabelas e campos conforme necess�rio, caso tenha feito modifica��es na estrutura do banco de dados Sakila.



