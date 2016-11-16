-- SPLIT_STR MySQL Function
-- from http://blog.fedecarg.com/2009/02/22/mysql-split-string-function/
DROP FUNCTION IF EXISTS SPLIT_STR;
CREATE FUNCTION SPLIT_STR(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
    LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
    delim, '');

/*
Example:
SELECT SPLIT_STR('a|bb|ccc|dd', '|', 3) as third;
+-------+
| third |
+-------+
| ccc   |
+-------+
*/

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
                         FROM work_address wa
                         WHERE
                          wa.street_address = street_address AND
                          wa.province = province AND
                          wa.city = city AND
                          wa.postal_code = postal_code
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

  INSERT INTO doctor VALUES (
  	alias,
  	first_name,
  	last_name,
  	gender,
    (SELECT address_id
                    FROM work_address wa
                    WHERE
                     wa.street_address = street_address AND
                     wa.province = province AND
                     wa.city = city AND
                     wa.postal_code = postal_code),
  	licensed
  );

  SET @index = 0;
	specializationParseLoop:LOOP
  		SET @index = @index + 1;
      SET @specialization = SPLIT_STR(specializations, ",", @index);

      IF @specialization != '' THEN
        INSERT INTO doctor_specialization(alias, specialization) values (alias, @specialization);
        ITERATE specializationParseLoop;
      END IF;

    leave specializationParseLoop;
	END LOOP specializationParseLoop;

END @@
DELIMITER ;

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
  SELECT d.alias, d.first_name, d.last_name, d.gender,
         wa.city, wa.province, wa.postal_code,
         avg(r.rating) AS avg_review_rating,
         (YEAR(CURDATE()) - YEAR(d.license)) as years_licensed,
         ds.specialization
    FROM doctor d
      INNER JOIN work_address wa ON wa.address_id = d.address_id
      LEFT JOIN doctor_specialization ds ON ds.alias = d.alias
      LEFT JOIN reviews r ON r.doctor_alias = d.alias
    WHERE
      (province IS NULL OR wa.province = province) AND
      (city IS NULL OR wa.city = city) AND
      (postal_code IS NULL OR wa.postal_code = postal_code) AND
      (gender IS NULL OR d.gender = gender) AND
      (specialization IS NULL OR ds.specialization = specialization) AND
      (name_keyword IS NULL OR
        ((UPPER(d.first_name) LIKE CONCAT('%', UPPER(name_keyword), '%')) OR
          (UPPER(d.last_name) LIKE CONCAT('%', UPPER(name_keyword), '%')))
      ) AND
      (num_years_licensed IS NULL OR (YEAR(CURDATE()) - YEAR(d.license)) >  num_years_licensed) AND
      (reviewed_by_friend IS FALSE OR EXISTS(
        SELECT 1
          FROM patient_friends pf
            WHERE
              ((pf.alias_from = caller_alias AND pf.alias_to IN (SELECT patient_alias FROM reviews))
                OR
                (pf.alias_to = caller_alias AND pf.alias_from IN (SELECT patient_alias FROM reviews))
              ) AND pf.status = 1)
      )
      GROUP BY d.alias
      HAVING (avg_star_rating_at_least IS NULL OR avg(r.rating) >= avg_star_rating_at_least);

  /* search for an exact match on province/city/postal_code/gender/specialization, substring
  match on name_keyword, inequality match on num_years_licensed and
  avg_star_rating_at_least, where a NULL value denotes a wildcard */
  /* return matching doctors as a relation with the attribute alias */
END @@
DELIMITER ;

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
