CREATE TABLE Work_Address(
	address_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	street_address VARCHAR(256),
	province VARCHAR(30),
	city VARCHAR(100),
	postal_code CHAR(6),
	PRIMARY KEY (address_ID)
);

CREATE TABLE Doctor(
	alias VARCHAR(20),
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	gender VARCHAR(20),
	address_ID BIGINT UNSIGNED NOT NULL,
	licence DATE,
	PRIMARY KEY (alias),
	FOREIGN KEY (address_ID) references Work_Address(address_ID)
);

CREATE TABLE Patient_Address(
	address_ID BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	province VARCHAR(30),
	city VARCHAR(50),
	PRIMARY KEY (address_ID)
);

CREATE TABLE Patient(
	alias VARCHAR(20),
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address_ID BIGINT UNSIGNED NOT NULL,
	email VARCHAR(256),
	PRIMARY KEY (alias),
	FOREIGN KEY (address_ID) references Patient_Address(address_ID)
);

CREATE TABLE Reviews(
	serial_number BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	patient_alias VARCHAR(20),
	doctor_alias VARCHAR(20),
	star_rating DECIMAL(2,1),
	comments VARCHAR(1024),
	date_time DATETIME,
	PRIMARY KEY (serial_number),
	FOREIGN KEY (doctor_alias) references Doctor (alias) ON DELETE CASCADE,
	FOREIGN KEY (patient_alias) references Patient (alias) on DELETE CASCADE
);

CREATE TABLE  Specialization(
	alias VARCHAR(20),
	specialization VARCHAR(100),
	PRIMARY KEY (alias, specialization),
	FOREIGN KEY (alias) references Doctor (alias) ON DELETE CASCADE
);

CREATE TABLE Friend_Requests(
	alias_from VARCHAR(20),
	alias_to VARCHAR(20),
	status INT,
	PRIMARY KEY (alias_from, alias_to),
	FOREIGN KEY (alias_from) references Patient (alias) ON DELETE CASCADE,
	FOREIGN KEY (alias_to) references Patient (alias) ON DELETE CASCADE
);
