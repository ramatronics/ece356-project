--6.1 Reset Database
DROP PROCEDURE IF EXISTS ResetDB;
DELIMITER @@
CREATE PROCEDURE ResetDB ()
BEGIN
  source createTables.sql
END @@
DELIMITER ;
