DROP PROCEDURE IF EXISTS CreatePatient;
DELIMITER @@
CREATE PROCEDURE Create Patient
(	IN alias VARCHAR(20), IN province VARCHAR(30), IN city VARCHAR(50),
 	IN first_name VARCHAR(100), IN last_name VARCHAR(100), IN email VARCHAR(256)
)
BEGIN

INSERT INTO Patient(
	alias,
	province,
	city,
	first_name,
	last_name,
	email
	) VALUES (
	alias,
	province,
	city,
	first_name,
	last_name,
	email
	);
END @@
DELIMITER;
