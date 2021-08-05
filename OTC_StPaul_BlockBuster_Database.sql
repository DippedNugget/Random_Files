-- everyone worked on

CREATE database IF NOT EXISTS otc_stpaul_blockbuster;

use otc_stpaul_blockbuster;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS login_validation;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS concessions;
DROP TABLE IF EXISTS movies;

CREATE TABLE movies(
	movie_id int NOT NULL auto_increment PRIMARY KEY,
	title varchar(30) NOT NULL,
	director varchar(30) NOT NULL,
	genre varchar(255) NOT NULL,
	rating varchar(30) NOT NULL,
	is_rented varchar(30) NOT NULL,
	store_location int NOT NULL,
	movie_barcode varchar(30)
);

CREATE TABLE concessions(
	concessions_id int NOT NULL auto_increment PRIMARY KEY,
	full_name varchar(60) NOT NULL,
	price decimal(5, 2) NOT NULL,
	quantity int NOT NULL,
	concession_barcode varchar(30)
);

CREATE TABLE stores(
	store_idPK int NOT NULL auto_increment PRIMARY KEY,
	address varchar(60) NOT NULL,
	phone varchar(14) NOT NULL
);

CREATE TABLE employees(
	employee_idPK int NOT NULL auto_increment PRIMARY KEY,
	first_name varchar(60) NOT NULL,
	last_name varchar(60) NOT NULL,
	address varchar(60) NOT NULL,
	phone varchar(14) NOT NULL DEFAULT 5559999999,
	isManager varchar(30) NOT NULL,
	emp_username varchar(60)
);

CREATE TABLE login_validation(
	validation_id int NOT NULL auto_increment PRIMARY KEY,
	emp_idFK int,
	emp_validator varchar(60),
	FOREIGN KEY (emp_idFK) REFERENCES employees (employee_idPK)
);

CREATE TABLE customers(
	customer_idPK int NOT NULL auto_increment PRIMARY KEY,
	first_name varchar(60) NOT NULL,
	last_name varchar(60) NOT NULL,
	address varchar(60),
	phone varchar(14),
	join_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE transactions(
	transaction_id int NOT NULL auto_increment PRIMARY KEY,
	customer_idFK int NOT NULL,
	store_idFK int NOT NULL,
	movies_rented JSON DEFAULT NULL,
	concessions_purchased JSON DEFAULT NULL,
	total decimal(5, 2) NOT NULL,
	FOREIGN KEY (customer_idFK) REFERENCES customers (customer_idPK),
	FOREIGN KEY (store_idFK) REFERENCES stores (store_idPK)
);

