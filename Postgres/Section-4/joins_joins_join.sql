SELECT books.title, authors.name
FROM authors
LEFT JOIN books
ON authors.id = books.author_id;
