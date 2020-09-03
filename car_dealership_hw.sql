CREATE TABLE customer_attributes(
	account_number SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	address VARCHAR(255),
	phone_number INTEGER,
	credit_score INTEGER
)

ALTER TABLE customer_attributes
ADD COLUMN date_created TIMESTAMP

CREATE TABLE payment_attributes(
	invoice_number SERIAL PRIMARY KEY,
	payment_amount NUMERIC(10,2),
	account_number INTEGER,
	date_created TIMESTAMP,
	late_fee NUMERIC,
	due_date TIMESTAMP,
	financing_number INTEGER
)

CREATE TABLE maintenance(
	workorder SERIAL PRIMARY KEY,
	car_id VARCHAR(50),
	order_created TIMESTAMP,
	order_done TIMESTAMP,
	price NUMERIC(10,2),
	summary VARCHAR(255),
	employee_id SMALLINT	
)

CREATE TABLE financing(
	financing_number SERIAL PRIMARY KEY,
	car_id VARCHAR(50),
	financing_amount NUMERIC(10,2),
	financing_provider VARCHAR(50),
	rate NUMERIC(10,2),
	term SMALLINT,
	unpaid_balance INTEGER
)

CREATE TABLE car_attributes(
	car_id VARCHAR(50) PRIMARY KEY,
	make VARCHAR(50),
	model VARCHAR(50),
	year SMALLINT,
	full_amount NUMERIC(10,2),
	account_number INTEGER
)

CREATE TABLE insurance_coverage(
	insurance_number SERIAL PRIMARY KEY,
	insurance_company VARCHAR(50),
	car_id VARCHAR(50)
)

ALTER TABLE payment_attributes
ADD FOREIGN KEY (account_number) REFERENCES customer_attributes(account_number)

ALTER TABLE payment_attributes
ADD FOREIGN KEY (financing_number) REFERENCES financing(financing_number)

ALTER TABLE maintenance
ADD FOREIGN KEY (car_id) REFERENCES car_attributes(car_id)

ALTER TABLE financing
ADD FOREIGN KEY (car_id) REFERENCES car_attributes(car_id)

ALTER TABLE car_attributes
ADD FOREIGN KEY (account_number) REFERENCES customer_attributes(account_number)


ALTER TABLE insurance_coverage
ADD FOREIGN KEY (car_id) REFERENCES car_attributes(car_id)

INSERT INTO customer_attributes(
	first_name,
	last_name,
	phone_number,
	address,
	credit_score,
	date_created
)
VALUES
('Porfirio', 'Pruneda', 7112659193, '36 Vine Lane Pasadena TX 77506', 450, 2020-09-09),
('Toni', 'Troxell', 6758447400, '272 N. Fremont St. Lubbock, TX 79424', 777, 2020-09-09),
('Dorthey', 'Derrick', 2668550710, '15 Cedar Street Houston TX 77092', 666, 2020-09-09),
('Kina', 'Keach', 5145318471, '315 Shipley Street Houston TX 77004', 555, 2020-09-09),
('Pasty', 'Pond', 9662915045, '9017 Hillcrest St. Grand Prairie TX 75052', 444, 2020-09-09),
('Theron', 'Treiber', 5199784733, '4 Elmwood Avenue San Antonio TX 78216', 390, 2020-09-09),
('Elsa', 'Ellingwood', 9955654039, '7052 Cedarwood Dr. Nacogdoches TX 75961', 780, 2020-09-09),
('Charlene', 'Clute', 6204541799, '812 Marconi Lane El Paso TX 79905', 742, 2020-09-09),
('Carlotta', 'Chirico', 8974841543, '7810 East Glendale Avenue Houston TX 77008', 810, 2020-09-09),
('Rosann', 'Rippeon', 6727831160, '7810 East Glendale Avenue Houston TX 77008', 640, 2020-09-09)

INSERT INTO car_attributes(
	make,
	model,
	year,
	full_amount,
	account_number
)
VALUES
(tesla, 'model x', 2019, 85000, 7),
('land rover', 'range rover', 2020, 91000, 2),
(lamborghini, 'aventador s', 2018, 181800, 5),
(ferrari, '458 spyder', 2019, 239340, 4),
(bugatti, 'veyron', 2005, 1900000, 1),
(tesla, roadster, 2021, 200000, 6),
(bmw, 535i, 2019, 75000, 3),
(infinty, qx60, 2019, 80000, 9),
('aston martin', db11, 2020, 198995, 10),
(bently, 'flying spur', 2020, 214600, 8)

INSERT INTO payment_attributes(
	payment_amount,
	account_number,
	date_created,
	late_fee,
	due_date,
	financing_number,
)
VALUES
()


-- QUERIES
SELECT date_created, CONCAT(first_name, ' ', last_name) AS "full name"
FROM customer_attributes
WHERE full_name = 'Toni%'
GROUP BY full_name

SELECT credit_score, CONCAT(first_name, ' ', last_name) AS "full name"
FROM customer_attributes
WHERE credit_score > 649
GROUP BY full_name

UPDATE financing
SET unpaid_balance - 95000
WHERE account_number = 1

UPDATE payment_attributes
SET late_fee + (payment_amount * 5%)
WHERE account_number = 5

CREATE VIEW payment_recorsd AS 
SELECT financing.financing_number, financing.unpaid_balance, payment_attributes.due_date
FROM financing
JOIN payment_attributes ON payment_attributes.financing_number = payment_attributes.financing_number
GROUP BY financing_number
WHERE financing_number = 3

SELECT customer_attributes.account_number, car_attributes.car_id, maintenance.car_id, CONCAT(customer_attributes.first_name, ' ', customer_attributes.last_name) AS "full_name", CONCAT(car_attributes.make, ' ', car_attributes.model) as "car name"
FROM customer_attributes
JOIN car_attributes ON customer_attributes.account_number = car_attributes.account_number
JOIN maintenance ON car_attributes.car_id = maintenance.car_id
GROUP BY car_id
WHERE account_number = 5
