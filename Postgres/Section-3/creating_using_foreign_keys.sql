-- Create table called 'boats'
CREATE TABLE boats (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR
);

-- Insert two boats
INSERT INTO boats (name)
VALUES ('Rogue Wave'), ('Harbor Master');

-- Create table called 'crew_members'
CREATE TABLE crew_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR,
    boat_id INTEGER REFERENCES boats(id)
);

-- Insert three crew members
INSERT INTO crew_members (first_name, boat_id)
VALUES ('Alex', 1), ('Lucia', 1), ('Ari', 2);

-- Write query here to fetch all columns for all crew_members associated with the boat that has an ID of 1
SELECT *
FROM crew_members
WHERE boat_id = 1;
