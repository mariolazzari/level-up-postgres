CREATE TABLE customers (
    customer_id serial PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_on TIMESTAMPTZ NOT NULL
);

INSERT INTO customers (firstname, lastname, username, password, email, created_on)
VALUES ('Alison', 'Riesher', 'alisoninthesun', 'l09+#k$nalA!', 'sunnysideup@myemail.com', CURRENT_TIMESTAMP),
    ('Edgar', 'Tobin', 'edgar163', 'BSI@uj0_qwT%', 'edgar163@email.com', CURRENT_TIMESTAMP),
    ('Frank', 'Lawson', 'frank_lawson', '32oktn*_WKn89', 'frank@lawsonhardware.com', CURRENT_TIMESTAMP),
    ('Kiara', 'Mendez', 'kiaradiamond', '9s9dSn$LStt', 'kdiamond@myemail.com', CURRENT_TIMESTAMP),
    ('Taylor', 'Hiu', 'taytay89', 'U09$hjqlaBM', 'taytay89@myemail.com', CURRENT_TIMESTAMP);


SELECT * FROM customers;
