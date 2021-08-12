-- everyone worked on

CREATE database IF NOT EXISTS otc_stpaul_blockbuster;

use otc_stpaul_blockbuster;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS user_validation;
DROP TABLE IF EXISTS user_roles;
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
	in_stock bool NOT NULL,
	store_location int NOT NULL
	-- movie_barcode varchar(30)
);

CREATE TABLE concessions(
	concessions_id int NOT NULL auto_increment PRIMARY KEY,
	full_name varchar(60) NOT NULL,
	price decimal(5, 2) NOT NULL,
	quantity int NOT NULL
	-- concession_barcode varchar(30)
);

CREATE TABLE stores(
	store_idPK int NOT NULL PRIMARY KEY,
	address varchar(60) NOT NULL,
	phone varchar(14) NOT NULL
);

CREATE TABLE employees(
	employee_idPK int NOT NULL auto_increment PRIMARY KEY,
	first_name varchar(60) NOT NULL,
	last_name varchar(60) NOT NULL,
	address varchar(60) NOT NULL,
	phone varchar(14) NOT NULL DEFAULT 5559999999,
    store_idFK int NOT NULL,
    FOREIGN KEY (store_idFK) REFERENCES stores (store_idPK)
);

CREATE TABLE user_validation(
	validation_id int NOT NULL auto_increment PRIMARY KEY,
	emp_idFK int NOT NULL,
	emp_username varchar(60),
	emp_validator varchar(60),
	ENABLED smallint not null DEFAULT 1,
	FOREIGN KEY (emp_idFK) REFERENCES employees (employee_idPK)
);

CREATE TABLE user_roles(
	role_id int NOT NULL auto_increment PRIMARY KEY,
	emp_username varchar(60) NOT NULL,
	user_role varchar(60) NOT NULL
);

CREATE TABLE customers(
	customer_idPK int NOT NULL auto_increment PRIMARY KEY,
	first_name varchar(60) NOT NULL,
	last_name varchar(60) NOT NULL,
	address varchar(60),
	phone varchar(14),
    -- barcode varchar(60),
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

------------------------------------------------------------
-- movies
INSERT INTO movies (title, director, genre, rating, in_stock, store_location) VALUES ("Spider-Man 2", "Sam Raimi", "Comic Book", "PG-13", true, 01);
INSERT INTO movies (title, director, genre, rating, in_stock, store_location) VALUES ("Back to the Future 3", "Robert Zemeckis", "Sci-Fi", "PG", true, 01);
INSERT INTO movies (title, director, genre, rating, in_stock, store_location) VALUES ("Robinson Crusoe on Mars", "Byron Haskins", "Sci-Fi", "PG", true, 01);

-- concessions
insert INTO concessions (full_name, price, quantity) VALUES ("REESES PIECES", 5.00, 12);
insert INTO concessions (full_name, price, quantity) VALUES ("JUNIOR MINTS", 5.00, 12);
insert INTO concessions (full_name, price, quantity) VALUES ("HOT TAMALES", 5.00, 12);

-- stores
INSERT INTO stores (store_idPK, address, phone) VALUES (01, "123 North South Street", "555-880-1587"); 
INSERT INTO stores (store_idPK, address, phone) VALUES (02, "123 South West Street", "555-880-1568"); 
INSERT INTO stores (store_idPK, address, phone) VALUES (03, "123 East South Street", "555-880-1794"); 

-- employees
INSERT INTO employees (first_name, last_name, address, phone, store_idFK) VALUES ("Adam", "Fite", "123 Madison Street", "417-555-8891", 03);
INSERT INTO employees (first_name, last_name, address, phone, store_idFK) VALUES ("Charlee", "Thao", "123 Madison Street", "417-555-8891", 02);
INSERT INTO employees (first_name, last_name, address, phone, store_idFK) VALUES ("Andrew", "Cham", "123 Madison Street", "417-555-8891", 01);

-- user_validation
INSERT INTO user_validation (emp_idFK, emp_username, emp_validator) VALUES (01, "OSPBAF", "12345");
INSERT INTO user_validation (emp_idFK, emp_username, emp_validator) VALUES (02, "OSPBCT", "67890");
INSERT INTO user_validation (emp_idFK, emp_username, emp_validator) VALUES (03, "OSPBAC", "13579");

-- user_roles
INSERT INTO user_roles (role_id, emp_username, user_role) VALUES (01, "OSPBAF", "USER");
INSERT INTO user_roles (role_id, emp_username, user_role) VALUES (02, "OSPBAF", "ADMIN");
INSERT INTO user_roles (role_id, emp_username, user_role) VALUES (03, "OSPBCT", "USER");
INSERT INTO user_roles (role_id, emp_username, user_role) VALUES (04, "OSPBCT", "ADMIN");
INSERT INTO user_roles (role_id, emp_username, user_role) VALUES (05, "OSPBAC", "USER");
INSERT INTO user_roles (role_id, emp_username, user_role) VALUES (06, "OSPBAC", "ADMIN");

-- customers
INSERT INTO customers (first_name, last_name, address, phone) VALUES ("George", "Washington", "01 Virigina Street", "555-234-6897");
INSERT INTO customers (first_name, last_name, address, phone) VALUES ("John", "Adams", "01 Massachusetts Street", "555-845-6487");
INSERT INTO customers (first_name, last_name, address, phone) VALUES ("Thomas", "Jefferson", "03 Virigina Street", "555-234-1478");

-- transactions
INSERT INTO transactions (customer_idFK, store_idFK, movies_rented, concessions_purchased, total) VALUES (01, 02, '["Spider-Man 2"]', '["REESES PIECES"]', 6.99);
INSERT INTO transactions (customer_idFK, store_idFK, movies_rented, concessions_purchased, total) VALUES (02, 03, '["Back to the Future 3"]', '["JUNIOR MINTS"]', 6.99);
INSERT INTO transactions (customer_idFK, store_idFK, movies_rented, concessions_purchased, total) VALUES (03, 01, '["Robinson Crusoe on Mars"]', '["HOT TAMALES"]', 6.99);