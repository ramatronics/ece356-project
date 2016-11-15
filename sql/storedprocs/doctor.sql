--Doctor table related procedures
--6.8
DROP PROCEDURE IF EXISTS CreateDoctor;
DELIMITER @@
CREATE PROCEDURE CreateDoctor
 (IN alias VARCHAR(20),
  IN province VARCHAR(30),
  IN city VARCHAR(50),
  IN postal_code CHAR(6),
  IN street_address VARCHAR(256),
  IN first_name VARCHAR(100),
  IN last_name VARCHAR(100),
  IN licensed DATE,
  IN gender VARCHAR(20),
  IN specializations VARCHAR(1024))

BEGIN

  SET @addr_exists = (SELECT COUNT(*)
                         FROM work_address w_a
                         WHERE
                          w_a.street_address = street_address AND
                          w_a.province = province AND
                          w_a.city = city AND
                          w_a.postal_code = postal_code
                        );
  IF @addr_exists = 0 THEN
      INSERT INTO work_address(
        street_address,
        province,
        city,
        postal_code
      ) VALUES (
        street_address,
        province,
        city,
        postal_code
      );
  END IF;

  SET @addr_id = SELECT address_id
                  FROM work_address w_a
                  WHERE
                   w_a.street_address = street_address AND
                   w_a.province = province AND
                   w_a.city = city AND
                   w_a.postal_code = postal_code;

  INSERT INTO doctor VALUES (
  	alias,
  	first_name,
  	last_name,
  	gender,
    @addr_id
  	license
  );

  SET @index = 0;

	basic_loop:LOOP

  		SET @index = @index + 1;
    	SET @SpecPart = SPLIT_STR(specializations, ',', @index);

    	INSERT INTO doctor_specialization
      VALUES (alias,
   	 		      @SpecPart)
    	ITERATE basic_loop;

	END LOOP basic_loop;

END @@
DELIMITER ;

--6.9
DROP PROCEDURE IF EXISTS DoctorSearch;
DELIMITER @@
CREATE PROCEDURE DoctorSearch
  (IN province VARCHAR(30),
   IN city VARCHAR(50),
   IN postal_code CHAR(6),
   IN name_keyword VARCHAR(100),
   IN num_years_licensed INT,
   IN gender VARCHAR(20),
   IN specialization VARCHAR(20),
   IN avg_star_rating_at_least DECIMAL(2,1),
   IN reviewed_by_friend BOOLEAN,
   IN caller_alias VARCHAR(20))
BEGIN
  /* search for an exact match on province/city/postal_code/gender/specialization, substring
  match on name_keyword, inequality match on num_years_licensed and
  avg_star_rating_at_least, where a NULL value denotes a wildcard */
  /* return matching doctors as a relation with the attribute alias */
END @@
DELIMITER ;

--6.10
DROP PROCEDURE IF EXISTS ViewDoctorA;
DELIMITER @@
CREATE PROCEDURE ViewDoctorA
  (IN alias VARCHAR(20))
BEGIN
  /* retrieve the doctor record for the given alias */
  /* return the doctor info as a relation with the attributes first_name, last_name, province,
  city, street_address, postal_code, num_years_licensed, avg_star_rating, num_reviews */
  SELECT
    d.first_name,
    d.last_name,
    wa.province,
    wa.city,
    wa.street_address,
    wa.postal_code,
    YEAR(CURDATE()) - YEAR(d.license) AS num_years_licensed,
    AVG(r.rating) AS avg_star_rating,
    COUNT(r.review_id) AS num_reviews
  FROM doctor d
    INNER JOIN work_address wa
      ON wa.address_id = d.address_id
    LEFT JOIN reviews r
      ON r.doctor_alias = d.alias
    WHERE d.alias = alias
    GROUP BY d.alias;
END @@
DELIMITER ;

--6.11
DROP PROCEDURE IF EXISTS ViewDoctorB;
DELIMITER @@
CREATE PROCEDURE ViewDoctorB
  (IN alias VARCHAR(20))
BEGIN
  /* retrieve the doctor record for the given alias */
  /* return a list of the doctor’s specializations as a relation with the attribute specialization */

  SELECT specialization
    FROM doctor_specialization ds
    WHERE ds.alias = alias;
END @@
DELIMITER ;
