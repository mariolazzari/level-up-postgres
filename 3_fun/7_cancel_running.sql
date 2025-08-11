CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL
);

INSERT INTO products (product_name, quantity)
VALUES
    ('Product A', 10),
    ('Product B', 5),
    ('Product C', 3);

-- locked transaction 1
BEGIN;

-- Select and update Product A
SELECT * FROM products WHERE product_name = 'Product A' FOR UPDATE;
UPDATE products SET quantity = quantity - 1 WHERE product_name = 'Product A';

-- Wait for 300 seconds
SELECT pg_sleep(300);

COMMIT;

-- locked transaction 2
BEGIN;

-- Select and update Product B
SELECT * FROM products WHERE product_name = 'Product B' FOR UPDATE;
UPDATE products SET quantity = quantity - 1 WHERE product_name = 'Product B';

-- Select and update Product A (which is already locked by Connection 1)
SELECT * FROM products WHERE product_name = 'Product A' FOR UPDATE;
UPDATE products SET quantity = quantity - 1 WHERE product_name = 'Product A';

COMMIT;

-- show running
SELECT pid, query, xact_start, wait_event, wait_event_type
FROM pg_stat_activity
WHERE backend_type = 'client backend' AND wait_event is NOT NULL;

SELECT pg_cancel_backend(82619);


