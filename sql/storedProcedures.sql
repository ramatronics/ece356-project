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

DROP PROCEDURE IF EXISTS CreateDoctor;
DELIMITER @@
CREATE PROCEDURE CreateDoctor
(IN alias VARCHAR(20), IN province VARCHAR(30), IN city VARCHAR(50), IN postal_code CHAR(6),
IN street_address VARCHAR(256), IN first_name VARCHAR(100), IN last_name VARCHAR(100), IN
licensed DATE, IN gender VARCHAR(20), IN specializations VARCHAR(1024))

BEGIN

INSERT INTO Doctor VALUES (
	alias, 
	first_name, 
	last_name, 
	gender, 
	street_address, 
	province, 
	city, 
	postal_code, 
	licensed);

SET @index = 0;
	basic_loop:LOOP

  		SET @index = @index + 1;
    	SET @SpecPart = SPLIT_STR(specializations, ',', @index);

    	INSERT INTO Specialization VALUES (
    		alias,
   	 		@SpecPart
   		 	)
    	ITERATE basic_loop;


  	END LOOP basic_loop;

END @@
DELIMITER ;
