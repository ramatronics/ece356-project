source clear.sql;
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
     alias      VARCHAR(20),
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
     alias      VARCHAR(20),
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
     INDEX `idx_rev_doctor` (doctor_alias ASC),
     INDEX `idx_rev_patient` (patient_alias ASC),
     FOREIGN KEY (doctor_alias) REFERENCES doctor (alias) ON DELETE CASCADE,
     FOREIGN KEY (patient_alias) REFERENCES patient (alias) ON DELETE CASCADE
  );

CREATE TABLE doctor_specialization
  (
     alias      VARCHAR(20),
     specialization VARCHAR(100),
     PRIMARY KEY (alias, specialization),
     FOREIGN KEY (alias) REFERENCES doctor (alias) ON DELETE CASCADE
  );

CREATE TABLE patient_friends
  (
     alias_from VARCHAR(20),
     alias_to   VARCHAR(20),
     status     BIT,
     PRIMARY KEY (alias_from, alias_to),
     FOREIGN KEY (alias_from) REFERENCES patient (alias) ON DELETE CASCADE,
     FOREIGN KEY (alias_to) REFERENCES patient (alias) ON DELETE CASCADE
  );
