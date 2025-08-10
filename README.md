# Level up PostgreSQL

## Basics

### Creating table

```sh
psql linkedin
```

```sql
CREATE TABLE customers (
    customer_id serial PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_on TIMESTAMPTZ NOT NULL
);
```

### Inserting records

```sql
INSERT INTO customers (firstname, lastname, username, password, email, created_on)
VALUES ('Alison', 'Riesher', 'alisoninthesun', 'l09+#k$nalA!', 'sunnysideup@myemail.com', CURRENT_TIMESTAMP),
    ('Edgar', 'Tobin', 'edgar163', 'BSI@uj0_qwT%', 'edgar163@email.com', CURRENT_TIMESTAMP),
    ('Frank', 'Lawson', 'frank_lawson', '32oktn*_WKn89', 'frank@lawsonhardware.com', CURRENT_TIMESTAMP),
    ('Kiara', 'Mendez', 'kiaradiamond', '9s9dSn$LStt', 'kdiamond@myemail.com', CURRENT_TIMESTAMP),
    ('Taylor', 'Hiu', 'taytay89', 'U09$hjqlaBM', 'taytay89@myemail.com', CURRENT_TIMESTAMP);
```

### Altering records

```sql
UPDATE customers
SET username = 'sunnysideup'
WHERE email = 'sunnysideup@myemail.com';

SELECT * 
FROM customers
WHERE username = 'sunnysideup'
```

### Locating records

```sql
CREATE TABLE usernames AS 
SELECT username
FROM customers
WHERE email like '%@myemail.com';

SELECT *
from usernames
```

### Sorting records

```sql
SELECT firstname || ' ' || lastname as fullname, email
FROM customers
WHERE length(password) < 12
ORDER BY length(password)
```

### Deleting records

```sql
DELETE 
FROM usernames
WHERE username = 'kiaradiamond'
RETURNING *;

DELETE 
FROM usernames
RETURNING *;
```

### Readonly user

```sql
CREATE USER tmpuser
WITH PASSWORD 'tmppassword'
VALID UNTIL '2025-01-01'

GRANT pg_real_all_data to tmpuser
```

## Leveling up

### Foreign key

```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,  -- Auto-incrementing primary key
    pirchase_total NUMERIC(10, 2) NOT NULL,  -- Money-like number, 2 decimal places
    order_datetime TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE
);
```

### Top totals

```sql
SELECT customer_id, SUM(purchase_total) as purchases
FROM orders
GROUP BY customer_id
ORDER BY purchases DESC
LIMIT 2
```

### Subquery to insert

```sql
INSERT INTO orders(purchase_total, timestamp, customer_id)
VALUES (100, CURRENT_TIMESTAMP, (SELECT customer_id from customers where email = 'edgar163@email.com'))
RETURNING *;
```

### Handling duplicates

```sql
DELETE FROM bookmarks
WHERE id in (
    SELECT id FROM bookmarks
    EXCEPT SELECT MAX(id) 
    FROM bookmarks
    GROUP BY url, name, description)
RETURNING *;
```