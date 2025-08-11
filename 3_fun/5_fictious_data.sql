INSERT INTO bookmarks(url, name, description)
SELECT 'https://site.com' || generate_series as url, 
    'Site' || generate_series as name,
    'Description' || generate_series as description
FROM generate_series(1,50);

SELECT * FROM bookmarks;