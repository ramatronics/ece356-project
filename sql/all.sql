DROP PROCEDURE IF EXISTS ResetDB;
DELIMITER @@
CREATE PROCEDURE ResetDB()
BEGIN
    /*
     * Nuke the database
     */
    SET foreign_key_checks=0;
    DROP TABLE IF EXISTS work_address;
    DROP TABLE IF EXISTS doctor;
    DROP TABLE IF EXISTS patient_address;
    DROP TABLE IF EXISTS patient;
    DROP TABLE IF EXISTS reviews;
    DROP TABLE IF EXISTS doctor_specialization;
    DROP TABLE IF EXISTS patient_friends;
    SET foreign_key_checks=1;

    /*
     * Start laying that foundation
     */
    CREATE TABLE work_address
      (
         address_id     BIGINT UNSIGNED NOT NULL auto_increment UNIQUE,
         street_address VARCHAR(256),
         province       VARCHAR(30),
         city           VARCHAR(100),
         postal_code    CHAR(6),
         PRIMARY KEY (address_id)
      );

    CREATE TABLE patient_address
      (
         address_id BIGINT UNSIGNED NOT NULL auto_increment UNIQUE,
         province   VARCHAR(30),
         city       VARCHAR(50),
         PRIMARY KEY (address_id)
      );

    CREATE TABLE doctor
      (
         alias      VARCHAR(20) NOT NULL UNIQUE,
         first_name VARCHAR(100),
         last_name  VARCHAR(100),
         gender     VARCHAR(20),
         address_id BIGINT UNSIGNED NOT NULL,
         license    DATE,
         PRIMARY KEY (alias),
         FOREIGN KEY (address_id) REFERENCES work_address(address_id)
      );

    CREATE TABLE patient
      (
         alias      VARCHAR(20) NOT NULL UNIQUE,
         first_name VARCHAR(100),
         last_name  VARCHAR(100),
         address_id BIGINT UNSIGNED NOT NULL,
         email      VARCHAR(256),
         PRIMARY KEY (alias),
         FOREIGN KEY (address_id) REFERENCES patient_address(address_id)
      );

    CREATE TABLE reviews
      (
         review_id BIGINT UNSIGNED NOT NULL auto_increment UNIQUE,
         patient_alias VARCHAR(20),
         doctor_alias  VARCHAR(20),
         rating        DECIMAL(2, 1),
         comments      VARCHAR(1024),
         created       DATETIME,
         PRIMARY KEY (review_id),
    	   CHECK(rating >= 0 AND rating <= 5),
         INDEX `idx_rev_doctor` (doctor_alias ASC),
         INDEX `idx_rev_patient` (patient_alias ASC),
         FOREIGN KEY (doctor_alias) REFERENCES doctor (alias) ON DELETE CASCADE,
         FOREIGN KEY (patient_alias) REFERENCES patient (alias) ON DELETE CASCADE
      );

    CREATE TABLE doctor_specialization
      (
         alias VARCHAR(20) NOT NULL,
         specialization VARCHAR(100) NOT NULL,
         PRIMARY KEY (alias, specialization),
         FOREIGN KEY (alias) REFERENCES doctor (alias) ON DELETE CASCADE
      );

    CREATE TABLE patient_friends
      (
         alias_from VARCHAR(20) NOT NULL,
         alias_to   VARCHAR(20) NOT NULL,
         status     BIT NOT NULL DEFAULT 0,
         PRIMARY KEY (alias_from, alias_to),
         FOREIGN KEY (alias_from) REFERENCES patient (alias) ON DELETE CASCADE,
         FOREIGN KEY (alias_to) REFERENCES patient (alias) ON DELETE CASCADE
      );

    /*
     * Begin decorating that foundation
     */

    /*
     * Beneficial for PatientSearch stored procedure
     */
    CREATE INDEX idx_patientaddress_province ON patient_address(province);
    CREATE INDEX idx_patientaddress_city ON patient_address(city);

    /*
     * Beneficial for DoctorSearch stored procedure
     */
    CREATE INDEX idx_doctor_first_name ON doctor(first_name) USING BTREE;
    CREATE INDEX idx_doctor_last_name ON doctor(last_name) USING BTREE;
    CREATE INDEX idx_doctor_license ON doctor(license) USING BTREE;

    CREATE INDEX idx_doctor_address_city ON work_address(city);
    CREATE INDEX idx_doctor_address_province ON work_address(province);
    CREATE INDEX idx_doctor_address_postal_code ON work_address(postal_code);

    /*
     * Beneficial for ViewReviews stored procedure
     */
    CREATE INDEX idx_reviews_date ON reviews(created) USING BTREE;
END @@
DELIMITER ;

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
  SET @aliasExists = (SELECT COUNT(*) FROM doctor d WHERE d.alias = alias);

  IF @aliasExists > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A doctor with this alias already exists';
  END IF;

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
      (reviewed_by_friend = 0 OR
        (
          SELECT 1 FROM
          (SELECT pf.alias_from AS alias
            FROM patient_friends pf
              WHERE pf.alias_to = caller_alias AND
                    pf.status = 1
          UNION
          SELECT pf.alias_to AS alias
            FROM patient_friends pf
              WHERE pf.alias_from = caller_alias AND
                    pf.status = 1) k
          WHERE k.alias = r.patient_alias
        ) > 0 )
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

DROP PROCEDURE IF EXISTS CreatePatient;
DELIMITER @@
CREATE PROCEDURE CreatePatient
 (IN alias VARCHAR(20),
  IN province VARCHAR(30),
  IN city VARCHAR(50),
  IN first_name VARCHAR(100),
  IN last_name VARCHAR(100),
  IN email VARCHAR(256))
BEGIN
  SET @aliasExists = (SELECT COUNT(*) FROM patient p WHERE p.alias = alias);

  IF @aliasExists > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A patient with this alias already exists';
  END IF;

  SET @exists = (SELECT COUNT(*) FROM patient_address p
    WHERE p.province = province AND p.city = city);

  IF @exists = 0 THEN
    INSERT INTO patient_address(province, city)
          VALUES (province, city);
  END IF;

  SET @address_id = (SELECT p.address_id
                      FROM patient_address p
                     WHERE p.province = province AND p.city = city);

  INSERT INTO patient(
    alias,
    first_name,
    last_name,
    address_id,
    email)
  VALUES (
    alias,
    first_name,
    last_name,
    @address_id,
    email);

END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS PatientSearch;
DELIMITER @@
CREATE PROCEDURE PatientSearch
 (IN alias VARCHAR(20),
  IN province VARCHAR(30),
  IN city VARCHAR(50))
BEGIN

SELECT
    p.alias,
    a.province,
    a.city,
    count(r.review_id) AS num_reviews,
    max(r.created) AS latest_review
    FROM patient p
      LEFT JOIN reviews r ON p.alias = r.patient_alias
      LEFT JOIN patient_address a ON p.address_id = a.address_id
    WHERE
      (alias IS NULL OR p.alias = alias) AND
      (province IS NULL OR a.province = province) AND
      (city IS NULL OR a.city = city)
    GROUP BY p.alias;


END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS AddFriend;
DELIMITER @@
CREATE PROCEDURE AddFriend
  (IN requestor_alias VARCHAR(20),
   IN requestee_alias VARCHAR(20))
BEGIN

  IF (SELECT COUNT(*) FROM patient_friends
        WHERE alias_from = requestee_alias AND
              alias_to = requestor_alias) = 1 THEN
      UPDATE patient_friends
        SET status = 1
      WHERE alias_from = requestee_alias
          AND alias_to = requestor_alias;

  ELSE
    INSERT INTO patient_friends (
        alias_from,
        alias_to,
        status)
      VALUES (
        requestor_alias,
        requestee_alias,
        0);
  END IF;

END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS ViewFriendRequests;
DELIMITER @@
CREATE PROCEDURE ViewFriendRequests
  (IN alias VARCHAR(20))
BEGIN
  /* search for patients who have requested friendship with the given alias but are not yet
  friends with the given alias */
  /* return matching patients as a relation with the attributes alias and email */
  SELECT pf.alias_from, p.email
    FROM patient p
      LEFT JOIN patient_friends pf
       ON pf.alias_from = p.alias
    WHERE
      pf.alias_to = alias AND
      pf.status = 0;

END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS ViewFriends;
DELIMITER @@
CREATE PROCEDURE ViewFriends
  (IN alias VARCHAR(20))
BEGIN
  /* search for patients who are friends of the given alias */
  /* return matching patients as a relation with the attributes alias and email */
  SELECT p.alias, p.email
    FROM patient p
      INNER JOIN (
        SELECT pf.alias_from AS alias
          FROM patient_friends pf
            WHERE pf.alias_to = alias AND
                  pf.status = 1
        UNION
        SELECT pf.alias_to AS alias
          FROM patient_friends pf
            WHERE pf.alias_from = alias AND
                  pf.status = 1
      ) s ON s.alias = p.alias;
END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS AreFriends;
DELIMITER @@
CREATE PROCEDURE AreFriends
  (IN alias1 VARCHAR(20),
   IN alias2 VARCHAR(20),
   OUT are_friends BOOLEAN)
BEGIN
  /* returns true in are_friends if alias1 and alias2 are friends, and false otherwise */
  IF (SELECT status
        FROM patient_friends pf
        WHERE
          (pf.alias_from = alias2 AND pf.alias_to = alias1)
          OR
          (pf.alias_from = alias1 AND pf.alias_to = alias2)) =  1 THEN
    SELECT TRUE INTO are_friends;
  ELSE
    SELECT FALSE INTO are_friends;
  END IF;
END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS CreateReview;
DELIMITER @@
CREATE PROCEDURE CreateReview
  (IN patient_alias VARCHAR(20),
   IN doctor_alias VARCHAR(20),
   IN star_rating DECIMAL(2,1),
   IN comments VARCHAR(1024))
c_r:BEGIN
  /* create a review using the given data */
  /* no return value */

  SET @patient_exist = (SELECT count(*) FROM patient WHERE alias = patient_alias);
  SET @doctor_exist = (SELECT count(*) FROM doctor WHERE alias = doctor_alias);

  if (@patient_exists = 0 OR @doctor_exits = 0 ) then
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid patient or doctor alias provided';
    leave c_r;
  end if;

  SET @valid_rate = MOD(star_rating, 0.5);

  IF(@valid_rate <> 0 or star_rating > 5.0) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid rating provided';
    leave c_r;
  END IF;

  INSERT INTO reviews(
    patient_alias,
    doctor_alias,
    created,
    rating,
    comments
  ) VALUES (
    patient_alias,
    doctor_alias,
    NOW(),
    star_rating,
    comments
  );
END @@
DELIMITER ;

DROP PROCEDURE IF EXISTS ViewReviews;
DELIMITER @@
CREATE PROCEDURE ViewReviews
  (IN doctor_alias VARCHAR(20),
   IN from_datetime DATETIME,
   IN to_datetime DATETIME)
BEGIN

  SELECT
    r.rating,
    r.comments,
    r.created
  FROM reviews r
    WHERE
      r.doctor_alias = doctor_alias AND
      r.created >= from_datetime AND
      r.created <= to_datetime;

END @@
DELIMITER ;
