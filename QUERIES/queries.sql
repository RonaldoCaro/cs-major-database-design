/* Q1. How many players are? */
SELECT COUNT(name) AS total_players FROM players;

/* Q2. How many teams are? */
SELECT COUNT(name) AS total_teams FROM teams;

/* Q3. Is there any player without a team? */
SELECT id, name FROM players WHERE team_id IS NULL;

/* Q4. Top 10 players by rating */
SELECT players.name, players.maps AS maps_played, players.rating, teams.name as team
FROM players
JOIN teams ON players.team_id = teams.id
ORDER BY rating DESC LIMIT 10;

/* Q5. Top 8 teams by final position*/
SELECT teams.name AS team, positions.position_interval AS position
FROM teams 
JOIN positions ON teams.final_position_id = positions.id
ORDER BY positions.interval_value ASC
LIMIT 8;

/*Q6. Top 5 igl's by rating*/
SELECT igl_players.name, igl_players.rating, teams.name AS team, positions.position_interval
FROM (
SELECT players.name, players.rating, players.team_id, roles.role 
FROM players JOIN roles ON players.role_id = roles.id 
WHERE roles.role = 'igl'
) AS igl_players
JOIN teams ON igl_players.team_id = teams.id
JOIN positions ON teams.final_position_id = positions.id
ORDER BY igl_players.rating DESC
LIMIT 5;

/*Q7. Navi players rating */
SELECT players.name, players.rating
FROM players
JOIN teams ON players.team_id = teams.id
WHERE teams.name = 'Natus Vincere';