SELECT firstname || ' ' || lastname as fullname, email
FROM customers
WHERE length(password) < 12
ORDER BY length(password)
