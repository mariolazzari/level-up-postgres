DELETE 
FROM usernames
WHERE username = 'kiaradiamond'
RETURNING *;

DELETE 
FROM usernames;
