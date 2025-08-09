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
```

### Altering records

```sql
UPDATE customers
SET username = 'mario.lazzari'
WHERE email = 'mario.lazzari@gmail.com';
```

### 