CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL,
    price NUMERIC(10,2) NOT NULL
);
INSERT INTO cars (make, model, year, price)
VALUES ('BMW', 'M3', 2022, 50000);
SELECT * FROM cars;
select model from cars;
select model from cars where id = 1 and price = 50000;

update cars set price = 25000 where id= 1;
select * from cars;

create table dealership (
	name varchar(100) not null,
	carid INTEGER references cars(id)
	);

INSERT INTO cars (make, model, year, price)
VALUES ('Audi', 'R8', 2021, 550000);

INSERT INTO dealership (name ,carid)
VALUES ('dynamo' , 1);

ALTER TABLE cars ADD usedfor INTEGER;
SELECT * FROM cars; 

ALTER TABLE cars ALTER COLUMN model SET NOT NULL;
 
ALTER TABLE cars RENAME COLUMN model to variant;
SELECT * FROM cars;

ALTER TABLE cars RENAME to car;

--  Index creation is used to internally help the database storage to handle data in a special way like using btress etc fro easy acces wrt to a particular column
CREATE INDEX btree ON car(price);
--DELETE FROM car WHERE id = 1;
--TRUNCATE TABLE TO DELETE ALL ROWS IN A TABLE AND DROP TABLE TO ACTUALLY DELETE A WHOLE TABLE
--two types of insert

 INSERT INTO car (make, variant, year, price)
VALUES ('BMW', 'M3', 2022, 50000) , 
('audi', 'a4', 2021, 60000);

SELECT * FROM car;

--THIS WONT WORK BCS THE TABLE HAS SERIAL(ID IS AUTOMATICALLY PUT) NEVER USE THIS FORMAT IN SERIAL USING TABLES
 -- INSERT INTO car VALUES('buggatii' ,'chiron' ,2374 , 234325);

SELECT * FROM car;
SELECT * FROM car WHERE price > 26000 ORDER BY price;
SELECT * FROM car WHERE price > 26000 ORDER BY price desc;
SELECT * FROM car WHERE price > 2600 ORDER BY price desc LIMIT 2; 

SELECT CONCAT(make,variant) as main,year,price FROM car WHERE price > 10000;
ALTER TABLE car ADD month INTEGER;
SELECT * FROM car;
SELECT * FROM car;

--THIS IS ME ASKING FOR THE SUM OF THE PRICES OF THE CARS IN THE SAME MONTH
SELECT SUM(price),month FROM car GROUP BY month;

SELECT COUNT(id),month FROM car GROUP BY month;

--NOW SUBQUERIES ARE LIKE FUNCTIONS JUST IMAGINE WE ARE THE SUBQUERY IS JUST A PLACEHOLDER FOR THE STUFF TAHTS RETURNING
SELECT id,make,year ,(SELECT AVG(price) FROM car) AS avgprice FROM car; 
SELECT CONCAT(make ,variant) as main FROM car WHERE price > (SELECT AVG(price) FROM car);






