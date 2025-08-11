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

### Inner join

```sql
SELECT o.order_id, o.purchase_total, c.email 
FROM orders AS o
INNER JOIN customers AS c on o.customer_id = c.customer_id 
```

### Outer join

```sql
SELECT p.program_name, count(s.student_id)
FROM programs as p
LEFT OUTER JOIN students s on p.program_id = s.program_id
GROUP BY p.program_name
```

### Temporary table

```sql
CREATE TEMPORARY TABLE sales AS
SELECT c.customer_id, c.email, sum(o.purchase_total) as total
FROM customers as c
INNER JOIN orders as o on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.email;
```

## Just for fun

### Pattern matching

```sql
UPDATE customers
SET phone_number = REGEXP_REPLACE(phone_number, '[^0-9]','','g')
WHERE phone_number ~ '[^0-9]';
```

### Filtering sensitive data

```sql
SELECT firstname || ' ' || LEFT(lastname,1) || '.' as fullname, email, 
    LEFT(phone_number, LENGTH(phone_number) - 4) || '****' as phone
FROM customers;
```

### Update order status

```sql
UPDATE orders
SET status = CASE
    WHEN order_id < 15 or TIMESTAMP < '2025-08-01' 
        THEN 'Shipped'
    ELSE 'Preparing for shipment'
END
```

### Data cleanup

```sql
UPDATE orders
set street = INITCAP(TRIM(street)), 
    city = INITCAP(TRIM(city)), 
    state = UPPER(TRIM(state))
```

### Fictious data

```sql
INSERT INTO bookmarks(url, name, description)
SELECT 'https://site.com' || generate_series as url, 
    'Site' || generate_series as name,
    'Description' || generate_series as description
FROM generate_series(1,50);
```

### Encrypting password

```sql
ALTER TABLE users 
    ADD COLUMN hash VARCHAR(255),
    ADD COLUMN salt VARCHAR(255);

UPDATE users
set salt = substr(md5(random()::text),1,16);

UPDATE users
set hash = md5(concat(salt, password));
```

### Cancel running query

```sql
SELECT pid, query, xact_start, wait_event, wait_event_type
FROM pg_stat_activity
WHERE backend_type = 'client backend' AND wait_event is NOT NULL;

SELECT pg_cancel_backend(82619);
```
