CREATE TABLE boats (
    name varchar(30) NOT NULL PRIMARY KEY,
    rating real NOT NULL,
    LOA real NOT NULL
);

CREATE TABLE races (
    name varchar(50) NOT NULL PRIMARY KEY,
    start_time date NOT NULL,
    max_length integer NOT NULL,
    min_length integer NOT NULL,
    location varchar(50) NOT NULL,
    time_limit real NOT NULL
);

CREATE TABLE registration (
    ID varchar(30) NOT NULL PRIMARY KEY,
    participants integer NOT NULL
);

CREATE TABLE race_locations (
    ID varchar(30) NOT NULL PRIMARY KEY,
    start_location varchar(50) NOT NULL,
    finish_location varchar(50) NOT NULL
);

CREATE TABLE results (
    ID varchar(30) NOT NULL PRIMARY KEY,
    place int NOT NULL,
    past_results int NOT NULL,
    finish_time real NOT NULL
);

CREATE TABLE records (
    ID varchar(30) NOT NULL PRIMARY KEY,
    time real NOT NULL,
    place integer NOT NULL,
    winner varchar(30) NOT NULL
);

\copy boats FROM 'DBboats.tsv';

SELECT * FROM boats;

\copy races FROM 'DBraces.tsv';

SELECT * FROM races;

\copy registration FROM 'DBregistration.tsv';

SELECT * FROM registration;

\copy race_locations FROM 'DBrl.tsv';

SELECT * FROM race_locations;

\copy results FROM 'DBresults.tsv';

SELECT * FROM results;

\copy records FROM 'DBrecords.tsv';

SELECT * FROM records;

#shows the number of registered participants
SELECT participants FROM registration;

#shows who has won in the past
SELECT winner FROM records;

#Shows boats eligible for race entry by length
SELECT boats.name, LOA, max_length, min_length FROM boats, races WHERE LOA<races.max_length AND LOA>races.min_length;

#shows which races might take longer than a day (times are in hours)
SELECT races.name FROM races WHERE time_limit>24;

#shows races that start and finish at the same place
SELECT races.name, start_location, finish_location FROM races, race_locations WHERE race_locations.start_location=race_locations.finish_location AND name =id;

#shows race entrants who have won in the past
SELECT name, winner FROM boats, records WHERE boats.name=records.winner;

#shows finishers within the time limit
SELECT finish_time, time_limit FROM results, races WHERE finish_time<races.time_limit;

#shows entrants who have participated in the past
SELECT name, ID FROM boats, records WHERE name=records.ID;

#shows boats who beat their previous time
SELECT results.ID, finish_time, time FROM results, records WHERE finish_time<records.time; 