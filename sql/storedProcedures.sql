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

DROP PROCEDURE IF EXISTS PatientSearch
DELIMITER @@
CREATE PROCEDURE PatientSearch
(	IN alias VARCHAR(20), IN province VARCHAR(30), IN city VARCHAR(50)
)
BEGIN

	select
		alias,
		province,
		city,
		count(Review.serial_number) as num_reviews,
		max(Review.date_time) as latest_review
	from Patient
	left join Review on Patient.alias = Review.patient_alias
	where
		(alias is NULL or Patient.alias = alias) and 
		(province is NULL or Patient.province = province) and
		(city is NULL or Patient.city = city)
	group by Patient.alias;

END @@
DELIMITER ;
