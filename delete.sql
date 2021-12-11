-- 2.5 


-- delete participant and contender info using the contenders stageName
-- the details of the participants are deleted, as when the contender tuple is deleted, 
-- the cascade operation happens where the participants are referencing the delete tuple are 
-- also deleted.
DELETE FROM Contender 
WHERE stageName = (SELECT stageName 
FROM (
SELECT stageName, MIN(SUMTOTAL)
FROM (SELECT SUM(P.dailySalary) AS SUMTOTAL, C.stageName 
FROM Contender AS C JOIN Participant AS P ON C.idContender = P.contender 
GROUP BY (P.contender)) AS SM) AS MINSALARY);

DELETE FROM ContenderInShow
WHERE contender IN

(select idContender FROM ((SELECT idContender, MIN(SUMTOTAL)
FROM (SELECT SUM(P.dailySalary) AS SUMTOTAL, C.idContender
FROM Contender AS C JOIN Participant AS P ON C.idContender = P.contender 
GROUP BY (P.contender)) AS SM)) AS CONTEND);
