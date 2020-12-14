--JOINS
SELECT * FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE unit_price > .99;


SELECT invoice_date, first_name, last_name, total FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id;


SELECT c.first_name, c.last_name, e.first_name, e.last_name FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;


SELECT al.title, ar.name FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;


SELECT track_id FROM playlist_track pt
JOIN playlist p ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';


SELECT t.name FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
WHERE playlist_id = 5;


SELECT t.name, p.name FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;


SELECT t.name, al.title FROM track t
JOIN album al ON t.album_id = al.album_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk';

--NESTED QUERIES
SELECT * FROM invoice
WHERE invoice_id IN (
  SELECT invoice_id FROM invoice_line 
  WHERE unit_price > .99);


SELECT * FROM playlist_track
WHERE playlist_id IN (
  SELECT playlist_id FROM playlist
  WHERE name = 'Music');


SELECT name FROM track
WHERE track_id IN (
  SELECT track_id FROM playlist
  WHERE playlist_id = 5);


SELECT * FROM track
WHERE genre_id IN (
  SELECT genre_id FROM genre
  WHERE name = 'Comedy');


SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE name = 'Fireball');


SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE artist_id IN (
    SELECT artist_id FROM artist
    WHERE name = 'Queen'));


--UPDATING ROWS
UPDATE customer
SET fax = null
WHERE fax IS NOT null;


UPDATE customer
SET company = 'Self'
WHERE company IS null;


UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';


UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';


UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (SELECT genre_id FROM genre
                   WHERE name = 'Metal');
                   

--GROUP BY
SELECT COUNT (*), genre.name FROM track
JOIN genre ON track.genre_id = genre.genre_id 
GROUP BY genre.name;

SELECT COUNT (*), g.name FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name IN ('Pop', 'Rock')
GROUP BY g.name

SELECT name, COUNT(*) FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
GROUP BY ar.name

--USE DISTINCT
SELECT DISTINCT composer
FROM track;


SELECT DISTINCT billing_postal_code
FROM invoice;


SELECT DISTINCT company
FROM customer;


--DELETE ROWS
DELETE FROM practice_delete WHERE type = 'bronze';

DELETE FROM practice_delete WHERE type = 'silver';

DELETE FROM practice_delete WHERE value = 150;


--





INSERT INTO products (name, price)
VALUES ('PS5', 499.99),
	   ('RTX 3090', 1299.99),
       ('Lego Colloseum', 399.99),
       ('Red Bull', 3.99),
       ('Cyberpunk 2077', 69.99)

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  quantity INT,
  products INT REFERENCES products(id)  
)

INSERT INTO orders (quantity, products)
	VALUES (2, 4),
  (1, 3),
  (4, 2),
  (1, 1),
  (7, 2),
  (2, 1),
  (4, 3),
  (3, 4)

SELECT * FROM orders
JOIN products ON products.id = orders.products
WHERE orders.id = 1

SELECT * FROM orders o
JOIN products p ON o.products = p.id


SELECT p.name, p.price, o.quantity, (p.price * o.quantity) FROM products p
JOIN orders o ON p.id = o.products
WHERE o.id = 3

ALTER TABLE orders
	ADD column user_id INT REFERENCES users(id)

UPDATE orders
SET user_id = 2
WHERE id = 1
--etc


SELECT *, u.name FROM orders o
JOIN users u ON o.user_id = u.id


SELECT COUNT(*), u.name FROM orders o
JOIN users u ON o.user_id = u.id
GROUP BY u.name