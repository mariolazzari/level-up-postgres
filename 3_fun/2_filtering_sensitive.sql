SELECT firstname || ' ' || LEFT(lastname,1) || '.' as fullname, email, 
    LEFT(phone_number, LENGTH(phone_number) - 4) || '****' as phone
FROM customers;