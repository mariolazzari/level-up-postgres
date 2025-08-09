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
INSERT INTO customers(firstname, lastname, username, password, email, created_on)
VALUES('Mario', 'Lazzari', 'mario', 'mypassword', 'mario.lazzari@gmail.com', CURRENT_TIMESTAMP);

INSERT INTO customers(firstname, lastname, username, password, email, created_on)
VALUES('Mariarosa', 'Sbardellati', 'mary', 'mypassword', 'mariarosa.sbardellati@gmail.com', CURRENT_TIMESTAMP),
('Maria', 'Lazzari', 'maria', 'mypassword', 'mariafilippinilazzari@gmail.com', CURRENT_TIMESTAMP);

SELECT * 
FROM customers
```

### Altering records

```sql
UPDATE customers
SET username = 'mario.lazzari'
WHERE email = 'mario.lazzari@gmail.com';

SELECT * 
FROM customers
WHERE username = 'mario.lazzari'
```

### Locating records

```sql
CREATE TABLE usernames AS 
SELECT username
FROM customers
WHERE email like '%@gmail.com';

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
WHERE username = 'mario.lazzari'
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

```