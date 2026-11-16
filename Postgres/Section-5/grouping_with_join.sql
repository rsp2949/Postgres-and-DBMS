SELECT authors.name, COUNT(books.id)
FROM authors
JOIN books
ON authors.id = books.author_id
GROUP BY authors.name;
