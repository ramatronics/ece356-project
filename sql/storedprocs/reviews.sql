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
