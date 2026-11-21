# Section 36 – Automated Database Testing

- Set up automated tests using Jest.
- Created a separate test database to protect development data.
- Learned how parallel tests can interfere with each other.
- Learned about PostgreSQL schemas and the `search_path` setting.
- Created a unique role and schema for each test file.
- Used `node-pg-migrate` to run migrations automatically.
- Used `pg-format` to safely format SQL identifiers.
- Created a reusable `Context` class to set up and clean up test schemas and roles.
- Used `beforeAll`, `afterAll`, and `beforeEach` to manage test setup, cleanup, and data reset.
- Successfully ran multiple test files in parallel without conflicts.
