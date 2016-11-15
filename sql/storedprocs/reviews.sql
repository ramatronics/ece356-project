--6.12
CREATE REVIEW
DROP PROCEDURE IF EXISTS CreateReview;
DELIMITER @@
CREATE PROCEDURE CreateReview
  (IN patient_alias VARCHAR(20),
   IN doctor_alias VARCHAR(20),
   IN star_rating DECIMAL(2,1),
   IN comments VARCHAR(1024))
BEGIN
  /* create a review using the given data */
  /* no return value */
END @@
DELIMITER ;

--6.13
DROP PROCEDURE IF EXISTS ViewReviews;
DELIMITER @@
CREATE PROCEDURE ViewReviews
  (IN doctor_alias VARCHAR(20),
   IN from_datetime DATETIME,
   IN to_datetime DATETIME)
BEGIN

  SELECT
    rating,
    comments,
    created
  FROM reviews r
  WHERE
    r.doctor_alias = doctor_alias AND
    r.created >= from_datetime AND
    r.created <= to_datetime;

END @@
DELIMITER ;
