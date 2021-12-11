-- Part 2.4 update.sql
--
-- Submitted by: Joshua Harris, K19008090, 19008090

-- Part 1
UPDATE Coach
SET dailySalary = dailySalary / 4;

UPDATE Participant
SET dailySalary = dailySalary / 4;

-- Part 2

ALTER TABLE CoachInShow
ADD arrived TIME NOT NULL,
ADD departed TIME NOT NULL;

ALTER TABLE ContenderInShow
ADD arrived TIME NOT NULL,
ADD departed TIME NOT NULL;


-- Part 3

UPDATE CoachInShow AS C JOIN TvShow AS T ON C.idShow = T.idShow
SET C.arrived  =  T.startTime - 10000;
UPDATE CoachInShow AS C JOIN TvShow AS T ON C.idShow = T.idShow
SET C.departed = T.endTime + 10000;

UPDATE ContenderInShow AS C JOIN TvShow AS T ON C.idShow = T.idShow
SET C.arrived  =  T.startTime - 10000;
UPDATE ContenderInShow AS C JOIN TvShow AS T ON C.idShow = T.idShow
SET C.departed = T.endTime + 10000;