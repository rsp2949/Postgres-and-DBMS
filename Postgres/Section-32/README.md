# Section 32 – Schema Migrations and Data Migrations

## Overview

In this section, we learn the difference between schema migrations and data migrations in PostgreSQL.

A schema migration changes the structure of a database, while a data migration moves or updates existing data.

We use an example where a `posts` table originally stores coordinates in two separate columns, `lat` and `lng`. Later, we want to combine these values into one PostgreSQL `POINT` column called `loc`.

## 1. Schema Migration vs Data Migration

### Schema Migration

A schema migration changes the database structure.

Examples:
- Creating a table
- Adding a column
- Dropping a column
- Renaming a column
- Changing a column's data type

### Data Migration

A data migration changes or moves existing data without necessarily changing the database structure.

In this example, we copy the existing latitude and longitude values into the new `loc` column.

## 2. The Problem

Initially, the `posts` table contains:

- `id`
- `url`
- `lat`
- `lng`

We want to change it to:

- `id`
- `url`
- `loc`

The `POINT` data type stores two coordinate values as one point. PostgreSQL represents a point using an x-coordinate and a y-coordinate.

In this example:

- X represents longitude.
- Y represents latitude.

The conversion is:

`POINT(lng, lat)`

The challenge is that the table might contain millions of existing posts. Copying all those values can take a long time.

## 3. Why We Should Not Combine Everything into One Migration

One possible approach is to perform three operations in one migration:

1. Add the new `loc` column.
2. Copy all existing latitude and longitude values into `loc`.
3. Drop the old `lat` and `lng` columns.

However, combining these operations inside one long-running transaction can cause problems.

A transaction works with a consistent view of the database. If new posts are created while a long-running migration is copying existing rows, those new rows may not be included in the original backfill operation.

If the migration then drops the old columns, the new rows may be left without a properly populated `loc` value.

This can cause missing data.

## 4. The Safer Five-Step Approach

The recommended approach is to separate the changes into five steps.

### Step 1: Add the New Column

Create a schema migration that adds a new `loc` column of type `POINT`.

The column should initially allow NULL values because existing rows have not been updated yet.

### Step 2: Update the Application

Deploy a new version of the application.

When creating or updating a post, the application should write to both:

- The old `lat` and `lng` columns.
- The new `loc` column.

This ensures that new or updated posts have values in both formats while the migration is in progress.

### Step 3: Backfill Existing Data

Copy the old coordinate values into the new column.

For every row where `loc` is NULL, calculate:

`POINT(lng, lat)`

This is called backfilling because we are updating records that already existed before the new column was introduced.

The lecture discusses two approaches:

**JavaScript approach**

- Load records from the database.
- Calculate the new point values in JavaScript.
- Send updates back to PostgreSQL.
- This approach allows complex business logic and validation.
- Loading too many records at once can use too much application memory.
- Batching can reduce memory usage, but batches may leave the migration partially completed if an error occurs.

**SQL approach**

- Use one SQL UPDATE statement to calculate the points inside PostgreSQL.
- This avoids transferring all the records into JavaScript.
- It is generally simpler and can be faster for straightforward transformations.
- Complex application-level validation is harder to implement.

For this lecture, we use the SQL approach inside a JavaScript file so that the operation can be committed to version control and shared with other engineers.

### Step 4: Update the Application Again

Deploy another version of the application.

Now the application should:

- Read coordinates from `loc`.
- Write new coordinates only to `loc`.
- Stop depending on the old `lat` and `lng` columns.

The application can still receive separate longitude and latitude values from the form and combine them into a PostgreSQL point before inserting the row.

When PostgreSQL returns a point through the Node.js `pg` library, the lecture demonstrates accessing its `x` and `y` values.

### Step 5: Drop the Old Columns

After confirming that the application no longer uses `lat` and `lng`, create a final schema migration to drop both columns.

The table now stores the coordinates in `loc`.

## 5. Transactions and Row Locks

Migrations are commonly executed inside transactions so that a failure can roll back the changes.

A transaction groups database operations together.

- `BEGIN` starts a transaction.
- `COMMIT` saves the transaction's changes.
- `ROLLBACK` cancels its uncommitted changes.

When a transaction updates a row, PostgreSQL takes a row-level lock. Another transaction trying to update that same row must wait until the first transaction commits or rolls back.

A long-running backfill transaction can therefore delay other updates to rows being processed.

### Batching

One way to reduce the time individual rows remain locked is to process records in smaller batches.

For example:

1. Update 5,000 rows.
2. Commit the transaction.
3. Update the next 5,000 rows.
4. Commit again.
5. Repeat until no rows remain to be updated.

The trade-off is that the entire backfill is no longer protected by one single transaction. If a later batch fails, earlier batches will already have been committed.

## 6. Data Migration Script

The lecture creates a separate `data` folder inside the `migrations` directory.

The file is named:

`01-lng-lat-to-loc.js`

The number at the beginning helps indicate the execution order of data migration scripts.

The migration framework manages migration files directly inside its migrations directory. The nested `data` folder is used for a separate, manually executed data migration.

The script:

1. Connects to PostgreSQL using the `pg` package.
2. Updates posts whose `loc` value is NULL.
3. Calculates each point using `POINT(lng, lat)`.
4. Prints a completion message.
5. Closes the database connection.

Run it from the project's data directory:

```bash
node 01-lng-lat-to-loc.js
```

## 7. Running the Example Application

The lecture uses Express.js and the Node.js `pg` package.

Install the dependencies:

```bash
npm install express pg
```

Run the application:

```bash
node index.js
```

Open the following address in your browser:

`http://localhost:3005/posts`

The application displays posts and provides a form to create new posts.

The supplied initial `index.js` file uses the original `lat` and `lng` columns. The lecture modifies the application in later steps to use the new `loc` column.

## 8. Important Commands

```sql
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    url TEXT,
    lat NUMERIC,
    lng NUMERIC
);

ALTER TABLE posts
ADD COLUMN loc POINT;

UPDATE posts
SET loc = POINT(lng, lat)
WHERE loc IS NULL;

ALTER TABLE posts
DROP COLUMN lat,
DROP COLUMN lng;
```

## Key Takeaways

- Schema migrations change the structure of the database.
- Data migrations move or update existing data.
- Avoid combining a long-running data backfill with schema changes in one migration.
- Use a gradual five-step approach when changing how existing data is stored.
- Backfill existing records after the application starts writing to both old and new columns.
- Use SQL for straightforward transformations and application code when complex validation is required.
- Transactions protect changes, but long-running transactions can hold row locks.
- Batching reduces the duration of individual transactions but introduces partial-completion considerations.

The next section moves on to working with PostgreSQL from a JavaScript application in greater detail.
