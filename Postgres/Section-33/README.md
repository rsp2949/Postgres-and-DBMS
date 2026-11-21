# Section 33 – Building a Node API with PostgreSQL

## Overview
In this section, we start building a small Node.js API and connect it to a PostgreSQL database called `social_network`.

## Topics Covered
- Setting up a Node.js project.
- Installing project dependencies.
- Creating a users table using migrations.
- Setting up an Express application.
- Creating REST API routes.
- Connecting Node.js to PostgreSQL using the `pg` module.
- Understanding PostgreSQL connection pools.
- Running SQL queries from a Node application.
- Preparing the application for testing.

## Database
Database name: `social_network`

Table name: `users`

Columns:
- `id`
- `created_at`
- `updated_at`
- `bio`
- `username`

## Main Files
- `index.js` – Starts the application and connects to PostgreSQL.
- `src/app.js` – Creates the Express application.
- `src/pool.js` – Manages the PostgreSQL connection pool.
- `src/routes/users.js` – Defines the users API routes.
- `migrations/` – Contains the database migration.

## Purpose
The main goal is to understand how a real Node.js application communicates with PostgreSQL and performs database operations.
