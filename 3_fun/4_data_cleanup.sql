ALTER TABLE orders
ADD COLUMN street VARCHAR,
ADD COLUMN city VARCHAR,
ADD COLUMN state VARCHAR,
ADD COLUMN zip_code VARCHAR;

WITH address_data AS (
    VALUES
        (11, '123 Main Street', 'Springfield ', 'CA', '12345'),
        (12, '234 Elm Avenue', 'lexington', 'ky', '23456'),
        (13, '35 Oak Street ', 'Greenville', 'SC ', '34567'),
        (14, '46 maple drive', 'austin', 'tx', ' 45678'),
        (15, '786 Pine Street', 'Portland', 'OR', '56789-0987'),
        (16, '987 Cedar lane', 'Seattle', 'Wa ', '67890'),
        (17, '1 Walnut Street', ' Denver', 'CO', '78901-1234')
)
UPDATE orders
SET
    street = address_data.column2,
    city = address_data.column3,
    state = address_data.column4,
    zip_code = address_data.column5
FROM address_data
WHERE orders.order_id = address_data.column1
    AND orders.order_id IN (11, 12, 14, 14, 15, 16, 17)
