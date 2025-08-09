CREATE TABLE usernames AS 
SELECT username
FROM customers
WHERE email like '%@gmail.com';
