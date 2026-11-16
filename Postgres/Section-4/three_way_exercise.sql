SELECT books.title, authors.name, reviews.rating
FROM books
JOIN authors
ON books.author_id = authors.id
JOIN reviews
ON authors.id = reviews.reviewer_id
AND books.id = reviews.book_id;
