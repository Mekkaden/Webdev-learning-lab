
--SQL execution order (important):

--FROM 

--WHERE

--GROUP BY

--HAVING

--SELECT
 
--ORDER BY



--EXP 1  - DML----------

--CREATE

CREATE TABLE Employee(empid INT , ename VARCHAR(10) , eaddress VARCHAR(10) , designation VARCHAR(10) ,department VARCHAR(20) ,salary VARCHAR(20) ,join_date DATE);



SELECT * FROM EMPLOYEE;

INSERT INTO employee VALUES(106 ,'James' , 'Kaduthuruthy' , 'Student' ,'cse' , 50000  ,TO_DATE('15-10-2015','DD-MM-YYYY'));


-- SELECT


--DISPLAY THE DETAILS OF ALL EMPLOYEES
SELECT * FROM EMPLOYEE;

SELECT ename,designation,salary FROM EMPLOYEE;

SELECT empid FROM EMPLOYEE WHERE salary > 60000;

SELECT ename,designation FROM EMPLOYEE WHERE DEPARTMENT = 'cse';

-- SELECT DETAILS OF EMPLOYEES WHOSE NAME ENDS WITH A
SELECT * FROM EMPLOYEE WHERE ename LIKE '%a';

SELECT * FROM EMPLOYEE WHERE ename LIKE 'j%';

SELECT * FROM EMPLOYEE WHERE ename LIKE 'J%';

SELECT * FROM EMPLOYEE WHERE ename LIKE '_a%';

--using aggregate function avg
SELECT DEPARTMENT , AVG(SALARY) AS AVG_SALARY FROM EMPLOYEE GROUP BY department;

SELECT ename,department FROM EMPLOYEE WHERE DESIGNATION = 'Manager';

-- UPDATE

UPDATE EMPLOYEE SET DESIGNATION = 'Asst-Manager' WHERE DESIGNATION ='Executive' AND JOINDATE < TO_DATE ('01-01-2023','DD-MM-YYYY');
SELECT * FROM EMPLOYEE;
SELECT ename, salary + 0.1 * salary AS new_salary FROM EMPLOYEE;

--or--
UPDATE EMPLOYEE SET salary = salary + 0.1 * salary;

DELETE FROM EMPLOYEE WHERE salary BETWEEN 50000 AND 55000;

--OR--
--***
DELETE FROM EMPLOYEE WHERE SALARY < 55000 AND SALARY > 50000;


--CONSTRAINTS-- 

CREATE TABLE books(title VARCHAR(20) PRIMARY KEY , author VARCHAR(20));

SELECT * FROM books;

-- cause error as pk cant be null , INSERT INTO books VALUES(null, 'navathe');

CREATE TABLE library(title VARCHAR(20) , author VARCHAR(20) , no_of_copies INT DEFAULT 2 , FOREIGN KEY(title) REFERENCES books(title));

SELECT * FROM library;

INSERT INTO library VALUES ('dbms','navathe',10);

INSERT INTO library VALUES ('c','dennis richie',20);  

DROP TABLE library;

--FOREIGN KEY , COMPOSITE KEY---

CREATE TABLE library(title VARCHAR(20)  , author VARCHAR(20) , no_of_copies INT DEFAULT 2 ,PRIMARY KEY (title ,author), FOREIGN KEY(title) REFERENCES books(title));

CREATE TABLE department (
    deptno VARCHAR2(5) PRIMARY KEY,
    deptname VARCHAR2(20),
    staffno VARCHAR2(10)
);

SELECT * FROM DEPARTMENT;

INSERT INTO department VALUES ('D1','CS','S101');
INSERT INTO department VALUES ('D2','EC','S110');
INSERT INTO department VALUES ('D3','EEE','S201');

CREATE TABLE STUDENT(rollno INT PRIMARY KEY , dno VARCHAR(20) , name VARCHAR(20) , FOREIGN KEY(dno) REFERENCES DEPARTMENT(deptno) ON DELETE CASCADE);

INSERT INTO student VALUES (10,'D1','Aswathy');
INSERT INTO student VALUES (20,'D3','Akash');
INSERT INTO student VALUES (30,'D2','Arun');

DELETE  FROM DEPARTMENT WHERE deptname = 'CS';

SELECT * FROM STUDENT;

---CHECK CONDITION ---- 

CREATE TABLE account(accno INT PRIMARY KEY,amount INT , CHECK (amount >= 250));

SELECT * FROM ACCOUNT;

INSERT INTO account VALUES (147,1000);
INSERT INTO account VALUES (777,100);   -- ❌ Will fail


--FIXING ALLIGNMENTS OF TABLE --
SET LINESIZE 200;
SET PAGESIZE 100;

DROP TABLE account;

CREATE TABLE ACCOUNTS(ACCNO INT , CUSTOMERNAME VARCHAR(20) , BRANCH VARCHAR(20) ,TYPE VARCHAR(20) , opening_date DATE , current_balance DECIMAL(4,3));

DROP TABLE ACCOUNTS;

CREATE TABLE accounts (
    accno NUMBER PRIMARY KEY,
    customername VARCHAR2(30),
    branch VARCHAR2(20),
    type VARCHAR2(20),
    openingdate DATE,
    currentbalance NUMBER(10,2)
);

INSERT INTO accounts VALUES 
(101,'Rahul','Kochi','Savings',TO_DATE('10-01-2022','DD-MM-YYYY'),5000);

INSERT INTO accounts VALUES 
(102,'Anu','TVM','Current',TO_DATE('15-03-2021','DD-MM-YYYY'),12000);


INSERT INTO accounts VALUES 
(103,'Vishnu','Kochi','Savings',TO_DATE('20-07-2023','DD-MM-YYYY'),8000);

SELECT AVG(currentbalance) AS AVG_BALANCE FROM accounts;

SELECT COUNT(*) FROM accounts;

SELECT customername FROM accounts where currentbalance = (SELECT MAX(currentbalance) FROM accounts);

SELECT customername FROM accounts ORDER BY currentbalance;

SELECT customername FROM accounts ORDER BY currentbalance DESC FETCH FIRST 1 ROW ONLY;

SELECT * FROM accounts;


--When you use GROUP BY, every column in the SELECT clause must be:
--Either in the GROUP BY
--Or inside an aggregate function (MAX, COUNT, AVG, etc.)

--🔹 1️⃣ Total accounts segregated by account type per branch

SELECT TYPE ,BRANCH ,COUNT(*) AS total_accounts FROM accounts GROUP BY branch,type;
SELECT 	customername FROM accounts GROUP BY CUSTOMERNAME  HAVING COUNT(DISTINCT type) > 1;

SELECT branch , COUNT(*) FROM accounts WHERE openingdate > TO_DATE('03-01-2021' ,'DD-MM-YYYY' ) GROUP BY branch HAVING COUNT(*) >1;


SELECT branch , COUNT(*) FROM accounts GROUP BY branch ORDER BY branch;


DROP TABLE department;

CREATE TABLE departmentt (
    dno NUMBER PRIMARY KEY,
    dname VARCHAR2(20),
    location VARCHAR2(20)
);

INSERT INTO departmentt VALUES (10,'Banking','Chennai');
INSERT INTO departmentt VALUES (20,'IT','Bangalore');
INSERT INTO departmentt VALUES (30,'Finance','Delhi');
INSERT INTO departmentt VALUES (40,'HR','Hyderabad');


CREATE TABLE salary_grade (
    grade VARCHAR(20) PRIMARY KEY,
    low_sal NUMBER,
    high_sal NUMBER
);

INSERT INTO salary_grade VALUES ('A',20000,50000);
INSERT INTO salary_grade VALUES ('B',50001,99999);
INSERT INTO salary_grade VALUES ('C',100000,149999);
INSERT INTO salary_grade VALUES ('D',150000,199999);


CREATE TABLE employeee (
    eno NUMBER PRIMARY KEY,
    ename VARCHAR2(20),
    job VARCHAR2(20),
    salary NUMBER,
    dno NUMBER,
    grade VARCHAR(20),
    FOREIGN KEY (dno) REFERENCES departmentt(dno),
    FOREIGN KEY (grade) REFERENCES salary_grade(grade)
);

INSERT INTO employeee VALUES (1,'Merlin','Clerk',5000,10,'A');
INSERT INTO employeee VALUES (2,'Hari','Manager',100000,30,'C');
INSERT INTO employeee VALUES (3,'Linu','IT Professor',200000,20,'D');
INSERT INTO employeee VALUES (4,'Farha','Manager',150000,20,'D');


SELECT dno FROM employeee;

SELECT * FROM departmentt;

SELECT dname FROM departmentt WHERE dno IN (SELECT dno FROM EMPLOYEEE);


-- List all employees to get salary more than ‘Hari’

SELECT * FROM EMPLOYEEE;

SELECT ename FROM EMPLOYEEe WHERE SALARY > (SELECT SALARY FROM EMPLOYEEE WHERE ENAME = 'Hari');

--List all employees who do the same job as Farha;, but exclude ;Farha; from the
--results.

SELECT ENAME FROM EMPLOYEEE WHERE JOB = (SELECT JOB FROM EMPLOYEEE WHERE ENAME = 'Farha') AND ENAME <> 'Farha';

--List name and salary of all employees whose salary is greater than salary of all
--employees working in department 30

SELECT ENAME ,SALARY FROM EMPLOYEEE WHERE SALARY > (SELECT MAX(SALARY) FROM EMPLOYEEE WHERE DNO = 30);

--List low salary of all employees whose grade is same as that of ‘Merlin’.
SELECT * FROM SALARY_GRADE;


--List department name of employees having highest salary.

SELECT * FROM DEPARTMENTT;
SELECT * FROM EMPLOYEEE e ;
SELECT * FROM SALARY_GRADE;
SELECT DNAME FROM DEPARTMENTT WHERE DNO = (SELECT DNO FROM EMPLOYEEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEEE));

--List average salary of employees in IT department
SELECT AVG(SALARY) FROM EMPLOYEEE WHERE DNO  = (SELECT DNO FROM DEPARTMENTT WHERE DNAME  = 'IT');

--List details of all employees in IT dept whose salary is greater than or equal to
--170000.

SELECT * FROM EMPLOYEEE WHERE DNO = (SELECT DNO FROM DEPARTMENTT WHERE DNAME = 'IT' ) AND SALARY >= 170000;

--Retrieve name &amp; job of employees in IT dept sorted in the order of name.

SELECT ENAME,JOB FROM EMPLOYEEE WHERE DNO = (SELECT DNO FROM DEPARTMENTT WHERE DNAME = 'IT') ORDER BY ENAME;

--List the name of employees having salary greater than avg of low salary &amp; high salary.

SELECT ename
FROM employee
WHERE salary > (
    SELECT AVG((low_sal + high_sal)/2)
    FROM salary_grade
);

DROP TABLE publisher;
--JOINS AND SET OPERATIONS -- 

CREATE TABLE publisher(
    publisher_id NUMBER PRIMARY KEY,
    publisher_name VARCHAR2(30),
    city VARCHAR2(20),
    state VARCHAR2(20),
    country VARCHAR2(20)
);

CREATE TABLE book_details (
    isbn NUMBER PRIMARY KEY,
    title VARCHAR2(30),
    mrp NUMBER,
    publisher_id NUMBER,
    author VARCHAR2(30),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

INSERT INTO publisher VALUES (1,'Pearson','Delhi','Delhi','India');
INSERT INTO publisher VALUES (2,'McGraw Hill','Mumbai','Maharashtra','India');
INSERT INTO publisher VALUES (3,'OReilly','California','CA','USA');
INSERT INTO publisher VALUES (4,'Springer','Berlin','Berlin','Germany');

INSERT INTO book_details VALUES (101,'DBMS',600,1,'Navathe');
INSERT INTO book_details VALUES (102,'OS',550,2,'Galvin');
INSERT INTO book_details VALUES (103,'Python',800,3,'Lutz');
INSERT INTO book_details VALUES (104,'AI',450,2,'Russell');
COMMIT;

SELECT * FROM BOOK_DETAILS;
SELECT * FROM PUBLISHER;

--List the name of books, price and city of publisher of all books.

SELECT B.TITLE,B.MRP,P.CITY FROM BOOK_DETAILS B JOIN PUBLISHER P ON B.PUBLISHER_ID = P.PUBLISHER_ID;

--List the details of books and their corresponding publisher details.

SELECT B.* , P.PUBLISHER_ID , P.PUBLISHER_NAME,P.CITY,P.STATE,P.COUNTRY FROM BOOK_DETAILS B JOIN PUBLISHER P ON B.PUBLISHER_ID = P.PUBLISHER_ID;

--List all publishers, details of books published by each publisher.

SELECT P.PUBLISHER_NAME ,B.* FROM PUBLISHER P LEFT JOIN BOOK_DETAILS B ON  p.publisher_id = b.publisher_id;

--List the name of the publisher which has got an entry in both tables.

SELECT publisher_name
FROM publisher

INTERSECT

SELECT p.publisher_name
FROM publisher p
JOIN book_details b
ON p.publisher_id = b.publisher_id;


--List the name of the publisher that has got an entry in book_details but not in the
--publisher table.


SELECT publisher_name
FROM publisher

MINUS

SELECT p.publisher_name
FROM publisher p
JOIN book_details b
ON p.publisher_id = b.publisher_id;


SELECT * FROM BOOK_DETAILS;
SELECT * FROM PUBLISHER;


SELECT P.P_NAME,B.P_NAME FROM BOOK_DETAILS B MINUS PUBLISHER P ;


--DDL---
DROP TABLE STUDENT;

CREATE TABLE student (
    roll_no NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    address VARCHAR2(30),
    phone_no VARCHAR2(15),
    gender VARCHAR2(10),
    branch VARCHAR2(20),
    mark1 NUMBER(5),
    mark2 NUMBER(5)
);

ALTER TABLE STUDENT ADD TOTALMARKSS VARCHAR(20);
ALTER TABLE STUDENT MODIFY ADDRESS VARCHAR(20);
ALTER TABLE STUDENT MODIFY (
	MARK1  NUMBER(3), 
	MARK2 NUMBER(4));

ALTER TABLE student
DROP COLUMN gender;

select * from student;

ALTER TABLE STUDENT DROP COLUMN BRANCH;

ALTER TABLE STUDENT RENAME COLUMN MARK1 TO MARK3;

RENAME STUDENT TO STUDENT1;




------------------------------------------------TRY------------------------------------------------



--DML --
DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (EMPID INT,NAME VARCHAR(20),JOB VARCHAR(20),SALARY VARCHAR(20), DEPTNO INT,JOINDATE DATE);
INSERT INTO Employee VALUES (1,'Hari','Manager',70000,20,TO_DATE('10-01-2021','DD-MM-YYYY'));
INSERT INTO Employee VALUES (2,'Arun','Clerk',40000,10,TO_DATE('15-05-2019','DD-MM-YYYY'));
INSERT INTO Employee VALUES (3,'Meera','Manager',80000,30,TO_DATE('20-07-2022','DD-MM-YYYY'));
INSERT INTO Employee VALUES (4,'John','Analyst',65000,20,TO_DATE('01-02-2020','DD-MM-YYYY'));
INSERT INTO Employee VALUES (5,'Anu','Clerk',50000,10,TO_DATE('12-03-2018','DD-MM-YYYY'));

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT NAME FROM EMPLOYEE WHERE SALARY > 60000;
UPDATE EMPLOYEE SET SALARY = SALARY + (SALARY * 0.1) WHERE JOB = 'MANAGER';
DELETE EMPLOYEE WHERE JOINDATE < TO_DATE('01-01-2020','DD-MM-YYYY');
--CONSTRAINTS--
DROP TABLE DEPARTMENT;
CREATE TABLE DEPARTMENT(DEPTNO INT PRIMARY KEY , DEPTNAME VARCHAR(20));
INSERT INTO Department VALUES (10,'HR');
INSERT INTO Department VALUES (20,'IT');
INSERT INTO Department VALUES (30,'Finance');

SELECT AVG(SALARY) FROM EMPLOYEE GROUP BY DEPTNO;
SELECT DEPTNO FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
SELECT DEPTNO FROM EMPLOYEE GROUP BY DEPTNO HAVING COUNT(*) > 2;

SELECT name
FROM Employee
WHERE salary > (
    SELECT salary
    FROM Employee
    WHERE name = 'Hari'
);


SELECT e.name, d.deptname, e.salary
FROM Employee e
JOIN Department d
ON e.deptno = d.deptno;

-------------------------------------------------------------

CREATE TABLE Product (
    pid NUMBER PRIMARY KEY,
    pname VARCHAR2(50),
    category VARCHAR2(30),
    price NUMBER(10,2),
    stock NUMBER
);
SELECT * FROM PRODUCT;
INSERT INTO Product VALUES (1, 'Laptop', 'Electronics', 50000, 10);
INSERT INTO Product VALUES (2, 'Phone', 'Electronics', 20000, 15);
INSERT INTO Product VALUES (3, 'Chair', 'Furniture', 3000, 5);
INSERT INTO Product VALUES (4, 'Table', 'Furniture', 7000, 0);
INSERT INTO Product VALUES (5, 'Headphones', 'Electronics', 1500, 8);

SELECT PNAME FROM PRODUCT WHERE PRICE > 1000;
UPDATE PRODUCT SET PRICE = PRICE * 1.05 WHERE CATEGORY = 'Electronics';

DELETE PRODUCT WHERE STOCK = 0;

CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    pid NUMBER,
    QUANTITY INT CHECK (QUANTITY > 0),
    FOREIGN KEY (pid)
    REFERENCES Product(pid));

SELECT  CATEGORY , COUNT(PNAME) FROM PRODUCT GROUP BY CATEGORY; 

SELECT CATEGORY , AVG(PRICE) AS AVG_PRICE FROM PRODUCT GROUP BY CATEGORY;

SELECT CATEGORY FROM PRODUCT GROUP BY CATEGORY HAVING AVG(PRICE) > 2000;

-------------------------------------------------------------

CREATE TABLE Customer (
    cust_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    city VARCHAR2(50),
    balance NUMBER,
    acc_type VARCHAR2(20),
    join_date DATE
);


INSERT INTO Customer VALUES (1, 'Anita', 'Kochi', 120000, 'Savings', SYSDATE);
INSERT INTO Customer VALUES (2, 'Rahul', 'Trivandrum', 45000, 'Savings', SYSDATE);
INSERT INTO Customer VALUES (3, 'Meena', 'Kozhikode', 80000, 'Current', SYSDATE);
INSERT INTO Customer VALUES (4, 'Arjun', 'Thrissur', 1500, 'Savings', SYSDATE);
INSERT INTO Customer VALUES (5, 'David', 'Kollam', 200000, 'Current', SYSDATE);


CREATE TABLE Publisher (
    pid NUMBER PRIMARY KEY,
    pname VARCHAR2(50),
    city VARCHAR2(30) DEFAULT 'Chennai'
);


SELECT b.title, p.pname, p.city
FROM Books b
JOIN Book_Details bd ON b.book_id = bd.book_id
JOIN Publisher p ON bd.pid = p.pid;
































	

