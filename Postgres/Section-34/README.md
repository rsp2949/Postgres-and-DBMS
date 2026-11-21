# Section 34 – User Repository and Database Queries

## Overview
In this section, we learn how to interact with a PostgreSQL database from our Node.js application using the Repository Pattern.

## Topics Covered
- Understanding the Repository Pattern.
- Creating a User Repository.
- Using static methods in a JavaScript class.
- Fetching all users from the database.
- Finding a user using their ID.
- Connecting repository methods with Express routes.
- Using async and await for database queries.
- Understanding query results and rows.
- Converting database column names into camelCase.
- Testing API endpoints using Postman or REST Client.
- Understanding SQL injection security risks.

## Main Files
- `src/repos/user-repo.js` – Contains methods for accessing the users table.
- `src/repos/utils/to-camel-case.js` – Converts database column names into camelCase.
- `src/routes/users.js` – Defines the API routes for users.
- `src/pool.js` – Manages the PostgreSQL connection pool.
- `request.http` – Contains HTTP requests for testing the API.

## API Routes
- `GET /users` – Retrieves all users.
- `GET /users/:id` – Retrieves a user using their ID.
- `POST /users` – Creates a user.
- `PUT /users/:id` – Updates a user.
- `DELETE /users/:id` – Deletes a user.

## Purpose
The main goal is to understand how an application communicates with a database using repositories, executes SQL queries, processes query results, and returns data through API routes.
