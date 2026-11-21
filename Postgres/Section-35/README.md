# Section 35 – Repository Pattern and CRUD Operations

## 1. Introduction

In this section, we learn how to organize database operations using the Repository Pattern.

We create a User Repository to manage all operations related to the users table.

The repository provides methods to:
- Find all users
- Find a user by ID
- Insert a new user
- Update an existing user
- Delete a user

## 2. Repository Pattern

The Repository Pattern provides a central place for accessing and managing data from a particular database table.

Instead of writing SQL queries directly inside route handlers, we create a separate repository that handles database operations.

For example:

- `find()` – Retrieves all users.
- `findById(id)` – Retrieves one user using their ID.
- `insert(username, bio)` – Creates a new user.
- `update(id, username, bio)` – Updates an existing user.
- `delete(id)` – Deletes a user.

This keeps route handlers clean and makes database code easier to maintain and reuse.

## 3. Creating the User Repository

Create a folder named `repos` inside the `src` directory.

Inside it, create `user-repo.js`.

The repository imports the database pool and uses it to execute SQL queries.

There are three common ways to create a repository:

1. A plain JavaScript object containing functions.
2. A class with instance methods.
3. A class with static methods.

In this section, we use static methods.

Database queries are asynchronous, so we use `async` and `await`.

## 4. Retrieving All Users

The `find()` method retrieves every row from the users table.

SQL query:

```sql
SELECT * FROM users;
```

The query result contains additional information, but the actual records are available through `result.rows`.

We return the rows after converting database column names into JavaScript camelCase format.

## 5. Finding a User by ID

The `findById(id)` method retrieves a particular user.

SQL query:

```sql
SELECT * FROM users
WHERE id = $1;
```

Here, `$1` is a parameter placeholder.

The actual ID is passed separately as an array:

```javascript
[id]
```

If the user exists, the API returns the user.

If the user does not exist, the API responds with status code `404`.

## 6. SQL Injection

SQL Injection is a security vulnerability that occurs when user-provided input is directly inserted into an SQL query.

Unsafe example:

```javascript
const result = await pool.query(
  `SELECT * FROM users WHERE id = ${id}`
);
```

An attacker could provide input such as:

```text
1; DROP TABLE users;
```

This can cause unintended SQL commands to execute.

SQL Injection can allow attackers to:
- Read unauthorized information.
- Modify database records.
- Delete records or tables.
- Damage the database.

Never directly concatenate user input into SQL queries.

## 7. Parameterized Queries

The recommended solution is to use parameterized queries.

Example:

```javascript
const result = await pool.query(
  'SELECT * FROM users WHERE id = $1',
  [id]
);
```

The SQL statement and the user-provided value are passed separately.

PostgreSQL treats the supplied value as data rather than as an additional SQL command.

For multiple values, use `$1`, `$2`, `$3`, and so on.

Example:

```javascript
await pool.query(
  'SELECT * FROM users WHERE id = $1 AND username = $2',
  [id, username]
);
```

## 8. Creating a User

The `insert()` method creates a new user.

SQL query:

```sql
INSERT INTO users (username, bio)
VALUES ($1, $2)
RETURNING *;
```

The `RETURNING *` clause returns the newly inserted user's information.

## 9. Updating a User

The `update()` method modifies an existing user.

SQL query:

```sql
UPDATE users
SET username = $1, bio = $2
WHERE id = $3
RETURNING *;
```

The `RETURNING *` clause returns the updated record.

If no user matches the ID, the repository returns `undefined`, and the route handler responds with `404`.

## 10. Deleting a User

The `delete()` method removes a user from the database.

SQL query:

```sql
DELETE FROM users
WHERE id = $1
RETURNING *;
```

The `RETURNING *` clause returns the deleted record.

If no record matches the ID, the API responds with `404`.

## 11. API Routes

The user router connects HTTP requests to repository methods.

| HTTP Method | Route | Operation |
|---|---|---|
| GET | `/users` | Retrieve all users |
| GET | `/users/:id` | Retrieve one user |
| POST | `/users` | Create a user |
| PUT | `/users/:id` | Update a user |
| DELETE | `/users/:id` | Delete a user |

For POST and PUT requests, Express uses `req.body` to access the submitted data.

For routes containing an ID, Express uses `req.params` to access the ID.

## 12. Converting Database Naming to CamelCase

PostgreSQL commonly uses snake_case naming:

- `created_at`
- `updated_at`

JavaScript commonly uses camelCase:

- `createdAt`
- `updatedAt`

To maintain consistent naming, we create a reusable utility called `to-camel-case.js`.

It converts object keys from snake_case to camelCase.

This utility can be reused by different repository methods.

## 13. Testing the API

We can test the API using either:

- Postman
- REST Client extension in Visual Studio Code

The application runs on port `3005`.

Example requests:

```http
GET http://localhost:3005/users
```

```http
GET http://localhost:3005/users/1
```

```http
POST http://localhost:3005/users
Content-Type: application/json

{
  "username": "cookie123",
  "bio": "I am a cookie"
}
```

```http
PUT http://localhost:3005/users/1
Content-Type: application/json

{
  "username": "alison156",
  "bio": "I am Alison"
}
```

```http
DELETE http://localhost:3005/users/1
```

## 14. Important Concepts Learned

- Repository Pattern
- Static methods in JavaScript classes
- Async and await
- PostgreSQL queries using the `pg` module
- SQL Injection
- Parameterized queries
- CRUD operations
- SQL `RETURNING` clause
- HTTP GET, POST, PUT and DELETE
- Express `req.body` and `req.params`
- Converting snake_case into camelCase
- Testing APIs using Postman and REST Client

## Conclusion

In this section, we built a User Repository that handles database operations separately from API route handlers.

We implemented CRUD operations and learned why parameterized queries are essential for preventing SQL Injection.

The Repository Pattern makes applications easier to organize, maintain, test and expand.
