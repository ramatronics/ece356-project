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
