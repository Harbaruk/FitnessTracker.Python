CREATE TABLE Offers(
Id INT IDENTITY(1, 1) PRIMARY KEY,
RecruiterId INT,
JobseekerId INT,
Subject VARCHAR(100),
Message VARCHAR(1000),
PostId INT,
Date DATETIME,
Status INT
);