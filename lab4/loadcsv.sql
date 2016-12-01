

DROP Table if exists Load_time;
Create table Load_time (
Buffer_Size int, Total_time time(3)
);
Set @diff = null;

SET @buffer_size = 8;
SET bulk_insert_buffer_size = 1024*1024*@buffer_size;
INSERT INTO Load_time(Buffer_Size) VALUES(@buffer_size);       

DELETE FROM Schools;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Schools.csv' 
INTO TABLE Schools 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Teams;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Teams.csv' 
INTO TABLE Teams 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Master;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Master.csv' 
INTO TABLE Master 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;


DELETE FROM AllstarFull;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/AllstarFull.csv' 
INTO TABLE AllstarFull 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Appearances;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Appearances.csv' 
INTO TABLE Appearances 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM AwardsManagers;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/AwardsManagers.csv' 
INTO TABLE AwardsManagers 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM AwardsPlayers;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/AwardsPlayers.csv' 
INTO TABLE AwardsPlayers 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM AwardsShareManagers;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/AwardsShareManagers.csv' 
INTO TABLE AwardsShareManagers 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM AwardsSharePlayers;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/AwardsSharePlayers.csv' 
INTO TABLE AwardsSharePlayers 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Batting;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Batting.csv' 
INTO TABLE Batting 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM BattingPost;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/BattingPost.csv' 
INTO TABLE BattingPost 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM CollegePlaying;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/CollegePlaying.csv' 
INTO TABLE CollegePlaying 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Fielding;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Fielding.csv' 
INTO TABLE Fielding 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM FieldingOF;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/FieldingOF.csv' 
INTO TABLE FieldingOF 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM FieldingPost;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/FieldingPost.csv' 
INTO TABLE FieldingPost 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM HallOfFame;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/HallOfFame.csv' 
INTO TABLE HallOfFame 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Managers;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Managers.csv' 
INTO TABLE Managers 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM ManagersHalf;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/ManagersHalf.csv' 
INTO TABLE ManagersHalf 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;


DELETE FROM Pitching;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Pitching.csv' 
INTO TABLE Pitching 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM PitchingPost;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/PitchingPost.csv' 
INTO TABLE PitchingPost 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM Salaries;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/Salaries.csv' 
INTO TABLE Salaries 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM SeriesPost;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/SeriesPost.csv' 
INTO TABLE SeriesPost 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;

DELETE FROM TeamsFranchises;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/TeamsFranchises.csv' 
INTO TABLE TeamsFranchises 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;


DELETE FROM TeamsHalf;
LOAD DATA LOCAL INFILE '/home/uesenthi/ece356/lab1/part2-baseballDB/csv/TeamsHalf.csv' 
INTO TABLE TeamsHalf 
CHARACTER SET 'UTF8'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES ;




--mysqldump -uroot -p ece356db_uesenthi  Load_time > "C:\Users\BBMesh\Desktop\SQLStuff\Lab1\Dumps\Tabledump.sql"






