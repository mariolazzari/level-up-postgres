CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,  -- Auto-incrementing primary key
    pirchase_total NUMERIC(10, 2) NOT NULL,  -- Money-like number, 2 decimal places
    order_datetime TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE
);

INSERT INTO orders (purchase_total, timestamp, customer_id)
VALUES 
(77.96, CURRENT_DATE - 5, 4),
(500.13, CURRENT_DATE - 1, 4),
(24.14, CURRENT_DATE - 10, 5),
(123.45, CURRENT_DATE - 5, 5),
(90.90, CURRENT_DATE, 4),
(45.01, CURRENT_DATE, 1),
(72.83, CURRENT_DATE - 7, 2),
(11.21, CURRENT_DATE - 2, 3),
(86.23, CURRENT_DATE - 3, 4),
(224.35, CURRENT_DATE, 1);
