INSERT INTO customers(firstname, lastname, username, password, email, created_on)
VALUES('Mario', 'Lazzari', 'mario', 'mypassword', 'mario.lazzari@gmail.com', CURRENT_TIMESTAMP);

INSERT INTO customers(firstname, lastname, username, password, email, created_on)
VALUES('Mariarosa', 'Sbardellati', 'mary', 'mypassword', 'mariarosa.sbardellati@gmail.com', CURRENT_TIMESTAMP),
('Maria', 'Lazzari', 'maria', 'mypassword', 'mariafilippinilazzari@gmail.com', CURRENT_TIMESTAMP);

SELECT * FROM customers;