# IPL Data Analysis Using PostgreSQL

## Project Overview

This project analyzes IPL (Indian Premier League) data using **PostgreSQL**.

The IPL dataset is stored in CSV files and loaded into PostgreSQL tables. SQL queries are then used to analyze matches, team performance, extra runs, and bowler economy rates.

## Technologies Used

- PostgreSQL
- SQL
- CSV Dataset

## Dataset

The project uses two CSV files:

- `matches.csv` — Contains information about IPL matches.
- `deliveries.csv` — Contains ball-by-ball information for IPL matches.

## Database Tables

### `matchesdata`

Stores match-level information such as:

- Match ID
- Season
- City
- Date
- Team 1
- Team 2
- Toss Winner
- Toss Decision
- Result
- Winner
- Win by Runs
- Win by Wickets
- Player of the Match
- Venue

### `deliveriesdata`

Stores ball-by-ball information such as:

- Match ID
- Inning
- Batting Team
- Bowling Team
- Over
- Ball
- Batsman
- Bowler
- Batsman Runs
- Extra Runs
- Total Runs
- Wide Runs
- No-ball Runs
- Bye Runs
- Leg-bye Runs
- Penalty Runs
- Player Dismissed
- Dismissal Kind

## IPL Analysis

The following problems are solved using PostgreSQL queries.

### 1. Number of Matches Played Per Year

Find the total number of IPL matches played in each season.

```sql
SELECT season,COUNT(matchid) FROM matches
GROUP BY season
ORDER BY season;
```

### 2. Number of Matches Won by Each Team

Find the total number of matches won by each team across all seasons.

```sql
SELECT 	winner, COUNT(*) FROM matches
WHERE winner is not null
GROUP BY winner
ORDER BY COUNT(*) DESC;
```

### 3. Extra Runs Conceded Per Team in 2016

Find the total extra runs conceded by each bowling team during the 2016 IPL season.

```sql
SELECT d.bowling_team, SUM(extra_runs) AS extra_runs FROM matches m
JOIN deliveries d ON m.matchid=d.matchid
WHERE m.season='2016'
GROUP BY d.bowling_team
ORDER BY SUM(extra_runs) DESC;
```

### 4. Top 10 Economical Bowlers in 2015

Find the top 10 bowlers with the lowest economy rate during the 2015 IPL season.

Economy rate is calculated as:

```text
Economy Rate = Runs Conceded / Overs Bowled
```

Legal balls exclude wides and no-balls.

```sql
SELECT bowler,(runs/overs) AS economy
FROM (SELECT d.bowler,
SUM(
CASE
WHEN d.wide_runs=0 AND d.noball_runs=0
THEN 1
ELSE 0
END)/6.0 AS overs,
SUM(
d.total_runs-
penalty_runs-
bye_runs-
legbye_runs) AS runs
FROM  matchesdata m
JOIN deliveriesdata d ON d.matchid=m.matchid
WHERE m.season=2015
GROUP BY bowler) AS economydata
ORDER BY economy
LIMIT 10;
```

## SQL Concepts Used

The project demonstrates the use of:

- `SELECT`
- `WHERE`
- `JOIN`
- `GROUP BY`
- `ORDER BY`
- `COUNT()`
- `SUM()`
- `CASE`
- Subqueries
- Aggregate Functions
- Filtering
- PostgreSQL CSV Data Handling

## How to Run

1. Install PostgreSQL.
2. Create the IPL database.
3. Create the `matchesdata` and `deliveriesdata` tables.
4. Load `matches.csv` and `deliveries.csv` into the tables.
5. Execute the SQL queries.
6. View the analysis results in PostgreSQL.

## Author

**Suresh**
