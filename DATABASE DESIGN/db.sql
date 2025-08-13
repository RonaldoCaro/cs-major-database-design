CREATE TABLE players_raw (
    nationality TEXT, 
    name TEXT,
    role VARCHAR(8),
    team TEXT,
    maps INTEGER,
    rating REAL,
	nationality_id INTEGER,
	role_id INTEGER,
	team_id INTEGER
);

CREATE TABLE teams_raw (
    name TEXT UNIQUE,
    start_stage VARCHAR(8),
    end_stage VARCHAR(8),
    final_position TEXT,
	name_id SERIAL PRIMARY KEY,
	start_stage_id INTEGER,
	end_stage_id INTEGER,
	final_position_id INTEGER
);

CREATE TABLE countries(
    id SERIAL PRIMARY KEY,
    name TEXT
);

CREATE TABLE stages(
    id SERIAL PRIMARY KEY,
    stage VARCHAR(8)
);

CREATE TABLE positions(
    id SERIAL PRIMARY KEY,
    position_interval TEXT
);

CREATE TABLE roles(
    id SERIAL PRIMARY KEY,
    role TEXT
);

CREATE TABLE teams(
    id SERIAL PRIMARY KEY,
    name TEXT,
    start_stage_id INTEGER REFERENCES stages(id),
    end_stage_id INTEGER REFERENCES stages(id),
    final_position_id INTEGER REFERENCES positions(id),
    UNIQUE(name, final_position_id)
);

CREATE TABLE players(
    id SERIAL PRIMARY KEY,
    nationality_id INTEGER REFERENCES countries(id), 
    name TEXT,
    role_id INTEGER REFERENCES roles(id),
    team_id INTEGER REFERENCES teams(id),
    maps INTEGER,
    rating REAL,
    UNIQUE(nationality_id, name)
);

\copy players_raw(nationality, name, role, team, maps, rating) FROM 'PLAYERS.csv' WITH DELIMITER ',' CSV HEADER;
\copy teams_raw(name, start_stage, end_stage, final_position) FROM 'TEAMS.csv' WITH DELIMITER ',' CSV HEADER;

INSERT INTO countries(name) 
SELECT DISTINCT nationality 
FROM players_raw;

INSERT INTO stages(stage) 
SELECT DISTINCT end_stage 
FROM teams_raw;

INSERT INTO positions(position_interval) 
SELECT DISTINCT final_position 
FROM teams_raw;

INSERT INTO roles(role)
SELECT DISTINCT role
FROM players_raw;

UPDATE players_raw 
SET nationality_id = (
	SELECT countries.id 
	FROM countries 
	WHERE countries.name = players_raw.nationality 
	LIMIT 1
	);

UPDATE players_raw
SET role_id = (
	SELECT roles.id 
	FROM roles 
	WHERE roles.role = players_raw.role
	);

UPDATE players_raw
SET team_id = (
	SELECT teams_raw.name_id 
	FROM teams_raw 
	WHERE teams_raw.name = players_raw.team
	);

UPDATE teams_raw
SET start_stage_id = (
	SELECT stages.id 
	FROM stages 
	WHERE stages.stage = teams_raw.start_stage
	);

UPDATE teams_raw
SET end_stage_id = (
	SELECT stages.id 
	FROM stages 
	WHERE stages.stage = teams_raw.end_stage
);

UPDATE teams_raw
SET final_position_id = (
	SELECT positions.id 
	FROM positions 
	WHERE positions.position_interval = teams_raw.final_position
	);

INSERT INTO teams(name, start_stage_id, end_stage_id, final_position_id)
SELECT name, start_stage_id, end_stage_id, final_position_id
FROM teams_raw;

INSERT INTO players(nationality_id, name, role_id, team_id, maps, rating)
SELECT nationality_id, name, role_id, team_id, maps, rating
FROM players_raw;

DROP TABLE players_raw;
DROP TABLE teams_raw;

/*uPPS*/
BEGIN;

UPDATE teams
SET final_position_id = 11
WHERE name = 'Team Falcons' OR name = 'M80';

DELETE FROM positions
WHERE position_interval = '20th-22th';

ALTER TABLE positions
ADD COLUMN interval_value INTEGER;

UPDATE positions
SET interval_value = CASE id
    WHEN 1  THEN 11
    WHEN 2  THEN 7
    WHEN 3  THEN 10
    WHEN 4  THEN 1
    WHEN 5  THEN 12
    WHEN 6  THEN 5
    WHEN 7  THEN 2
    WHEN 8  THEN 8
    WHEN 9  THEN 3
    WHEN 11 THEN 9
    WHEN 12 THEN 6
    WHEN 13 THEN 13
    WHEN 14 THEN 4
END;

UPDATE players
SET rating = 0
WHERE rating IS NULL;

/*ROLLBACK;*/
COMMIT;





