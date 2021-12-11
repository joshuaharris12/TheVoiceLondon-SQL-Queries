-- Average Female Salary
SELECT AVG(dailySalary)
FROM Participant
WHERE gender = "F";

-- Coaching Report
SELECT forename, surname, DoB, idCoach, phone, dailySalary, gender, COUNT(idContender)
FROM Contender AS A JOIN Coach AS C ON idCoach = coach
GROUP BY(coach);

-- Coach Monthly Attendance Report
SELECT coach, COUNT(idShow)
FROM (Coach AS C JOIN CoachInShow AS S ON C.idCoach = S.coach) JOIN TvShow AS T ON T.idShow = S.idShow
-- finish off

-- Most Expensive Contender
SELECT stageName, MAX(SUMTOTAL)
FROM (SELECT SUM(P.dailySalary) AS SUMTOTAL, C.stageName 
FROM Contender AS C JOIN Participant AS P ON C.idContender = P.contender 
GROUP BY (P.contender)) AS SM;

-- March Payment Report
SELECT C.forename, C.surname, COUNT(E.coach) AS Number_Of_Shows_Attended, CONCAT("£", C.dailySalary), ( C.dailySalary * COUNT(E.coach)) AS TotalSalary
FROM Coach AS C, CoachInShow as E, TvShow AS S
WHERE C.idCoach = E.coach AND S.idShow = E.idShow AND S.showDate >= '2019-03-01' AND S.showDate <= '2019-03-31'
GROUP BY(C.idCoach)
UNION 
SELECT P.forename, P.surname, COUNT(E.contender) AS Number_Of_Shows_Attended, CONCAT("£", P.dailySalary), ( P.dailySalary * COUNT(E.contender)) AS TotalSalary
FROM Participant AS P, Contender AS C, ContenderInShow AS E, TvShow AS S
WHERE E.contender = C.idContender AND P.contender = C.idContender AND S.idShow = E.idShow AND S.showDate >= '2019-03-01' AND S.showDate <= '2019-03-31'
GROUP BY (P.idParticipant);

SELECT CONCAT("£", SUM(TWE.TotalSalary)) AS Total_Amount_Paid_In_March FROM
(SELECT C.forename, C.surname, COUNT(E.coach) AS Number_Of_Shows_Attended, CONCAT("£", C.dailySalary), ( C.dailySalary * COUNT(E.coach)) AS TotalSalary
FROM Coach AS C, CoachInShow as E, TvShow AS S
WHERE C.idCoach = E.coach AND S.idShow = E.idShow AND S.showDate >= '2019-03-01' AND S.showDate <= '2019-03-31'
GROUP BY(C.idCoach)
UNION 
SELECT P.forename, P.surname, COUNT(E.contender) AS Number_Of_Shows_Attended, CONCAT("£", P.dailySalary), ( P.dailySalary * COUNT(E.contender)) AS TotalSalary
FROM Participant AS P, Contender AS C, ContenderInShow AS E, TvShow AS S
WHERE E.contender = C.idContender AND P.contender = C.idContender AND S.idShow = E.idShow AND S.showDate >= '2019-03-01' AND S.showDate <= '2019-03-31'
GROUP BY (P.idParticipant)) AS TWE ;


-- Well Formed Groups
SELECT IF(NUMRECS > 0, FALSE, TRUE) AS VIOLATED
FROM 
(SELECT COUNT(*) AS NUMRECS
FROM
(SELECT GROUPLESS1.PARTS
FROM (SELECT COUNT(P.contender) AS PARTS FROM Participant AS P JOIN Contender AS C ON P.contender = C.idContender WHERE C.type = "Group" GROUP BY(contender)) AS GROUPLESS1
WHERE GROUPLESS1.PARTS < 2) AS L) AS P;

