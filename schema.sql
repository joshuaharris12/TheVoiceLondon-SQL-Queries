-- Part 2.1 schema.sql
--
-- Submitted by: Joshua Harris, 19008090, K19008090
-- 

CREATE TABLE Coach (
    forename VARCHAR(15) NOT NULL,
    surname VARCHAR(15) NOT NULL,
    DoB DATE NOT NULL,
    idCoach CHAR(9),
    phone VARCHAR(15) NOT NULL,
    dailySalary INTEGER NOT NULL CHECK (dailySalary >= 0),
    gender CHAR(1) NOT NULL CHECK (gender = "M" OR gender = "F"),
    PRIMARY KEY(idCoach)
);

-- To implement the contender being set a replacement coach the coach is deleted, I would specify include 'DEFAULT "123456789"' next to the 'idContender CHAR(9)'
-- Also, I would set the foreign key to 'ON DELETE SET DEFAULT' instead of NULL.
CREATE TABLE Contender (
    stageName VARCHAR(20) NOT NULL,
    type VARCHAR(20) NOT NULL,
    idContender CHAR(9),
    coach CHAR(9),
    PRIMARY KEY(idContender),
    FOREIGN KEY(coach) REFERENCES Coach(idCoach) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Participant (
    forename VARCHAR(15) NOT NULL,
    surname VARCHAR(15) NOT NULL,
    DoB DATE NOT NULL,
    idParticipant CHAR(9),
    phone VARCHAR(15) NOT NULL,
    dailySalary INTEGER NOT NULL CHECK (dailySalary >= 0),
    gender CHAR(1) NOT NULL CHECK (gender = "M" OR gender = "F"),
    contender CHAR(9),
    PRIMARY KEY(idParticipant),
    FOREIGN KEY(contender) REFERENCES Contender(idContender) ON DELETE CASCADE ON UPDATE SET NULL
);

CREATE TABLE TvShow (
    location VARCHAR(30) DEFAULT "Television Studio",
    showDate DATE NOT NULL,
    idShow CHAR(9),
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    PRIMARY KEY(idShow)
);

CREATE TABLE CoachInShow (
    coach CHAR(9),
    idShow CHAR(9),
    PRIMARY KEY(coach,idShow),
    FOREIGN KEY(coach) REFERENCES Coach(idCoach) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREiGN KEY(idShow) REFERENCES TvShow(idShow) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ContenderInShow (
    contender CHAR(9),
    idShow CHAR(9),
    PRIMARY KEY(contender,idShow),
    FOREIGN KEY(contender) REFERENCES Contender(idContender) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(idShow) REFERENCES TvShow(idShow) ON DELETE CASCADE ON UPDATE CASCADE
);