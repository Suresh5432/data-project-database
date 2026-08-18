-- creating matches table 

CREATE TABLE matchesData(
matchid INT PRIMARY KEY,
season INT,
city VARCHAR(100) NOT NULL,
match_date DATE,
team1 VARCHAR(150),
team2 VARCHAR(150),
toss_winner VARCHAR(150),
toss_decision VARCHAR(150),
result VARCHAR(100),
dl_applied INT,
winner VARCHAR(150),
win_by_runs INT,
win_by_wickets INT,
player_of_match VARCHAR(150),
venue VARCHAR(300),
umpire1 VARCHAR(100),
umpire2 VARCHAR(100)
);

-- creating deliveries table

CREATE TABLE deliveriesdata(
matchid INT NOT NULL,
inning INT NOT NULL,
batting_team varchar(150),
bowling_team varchar(150),
overs INT,
ball INT,
batsman VARCHAR(100),
non_striker VARCHAR(100),
bowler VARCHAR(100),
is_super_over INT,
wide_runs INT,
bye_runs INT,
legbye_runs INT,
noball_runs INT,
penalty_runs INT,
batsman_runs INT,
extra_runs INT,
total_runs INT,
player_dismissed VARCHAR(100) DEFAULT 'none',
dismissal_kind VARCHAR(100) DEFAULT 'none',
filder varchar(100) DEFAULT 'none',
FOREIGN KEY (matchid) REFERENCES matchesdata(matchid)
);

-- loading matches.csv file into table

\copy matches 
FROM '/home/suresh/Downloads/data/matches.csv' 
with
(
FORMAT CSV,
HEADER true);

-- loading deliveries.csv file into file

\copy deliveries 
FROM '/home/suresh/Downloads/data/deliveries.csv' 
with
(FORMAT CSV,
HEADER true);


select * from deliveries;
select * from matches;
delete from matches
where id=*;

-- 1. Number of matches played per year of all the years in IPL.

SELECT season,COUNT(matchid) FROM matches
GROUP BY season
ORDER BY season;

-- 2. Number of matches won of all teams over all the years of IPL.

SELECT 	winner, COUNT(*) FROM matches
WHERE winner is not null
GROUP BY winner
ORDER BY COUNT(*) DESC;

-- 3. For the year 2016 get the extra runs conceded per team.

SELECT d.bowling_team, SUM(extra_runs) AS extra_runs FROM matches m
JOIN deliveries d ON m.matchid=d.matchid
WHERE m.season=2016
GROUP BY d.bowling_team
ORDER BY SUM(extra_runs) DESC;

-- 4. For the year 2015 get the top economical bowlers.

SELECT bowler,ROUND((runs/overs),2) AS economy
FROM (SELECT d.bowler,
count(*) 
filter 
(where d.wide_runs=0 AND d.noball_runs=0)/6.0 AS overs,
SUM(
d.total_runs-
penalty_runs-
bye_runs-
legbye_runs) AS runs
FROM  matches m
JOIN deliveries d ON d.matchid=m.matchid
WHERE m.season=2015
GROUP BY bowler) AS economydata
ORDER BY economy
LIMIT 10;
