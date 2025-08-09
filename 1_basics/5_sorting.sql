SELECT firstname || ' ' || lastname as fullname, email, length(password) as pwdlen
FROM customers
WHERE length(password) < 12
ORDER BY length(password)
