DELETE 
FROM usernames
WHERE username = 'mario.lazzari'
RETURNING *;

DELETE 
FROM usernames;
