

--Drop tables if they exist
drop table "employees";
drop table "salaries";
drop table "dept_employees";
drop table "departments";
drop table "dept_manager";
drop table "titles";

--Create table
CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(6)   NOT NULL,
    "birth_date" VARCHAR(10)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR(10)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

--Create table

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT null,
    primary key ("emp_no","salary")
);



--Create table
CREATE TABLE "dept_employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(5)   NOT null,
    primary key ("emp_no","dept_no")
);



--Create table
CREATE TABLE "departments" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);


--Create table
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "emp_no" INT   NOT null,
    primary key ("dept_no","emp_no")
);


--Create table
CREATE TABLE "titles" (
    "title_id" VARCHAR(6)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

--Import CSV

--Quick check of CSV
select *
from employees
limit 10;


--Import CSV

--Quick check of CSV
select *
from salaries
limit 10;


--Import CSV

--Quick check of CSV
select *
from dept_employees
limit 10;


--Import CSV

--Quick check of CSV
select *
from departments
limit 10;


--Import CSV

--Quick check of CSV
select *
from dept_manager
limit 10;

--Import CSV

--Quick check of CSV
select *
from titles
limit 10;


--Change the table to include foreign keys
ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_employees" ADD CONSTRAINT "fk_dept_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_employees" ADD CONSTRAINT "fk_dept_employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");



create table merged_tb as (
SELECT 
	e.emp_no, 
	e.emp_title_id,
	e.birth_date,
	e.first_name,
	e.last_name,
	e.sex,
	e.hire_date,
	s.salary
    FROM employees as e , salaries as s 
    WHERE s.emp_no = e.emp_no

);

--Check merged table
select *
from merged_tb
limit 10;

create table merged_tb2 as (
SELECT 
	mt.emp_no, 
	mt.emp_title_id,
	mt.birth_date,
	mt.first_name,
	mt.last_name,
	mt.sex,
	mt.hire_date,
	mt.salary,
	de.dept_no
    FROM merged_tb as mt , dept_employees as de 
    WHERE mt.emp_no = de.emp_no

);

--Check merged table
select *
from merged_tb2
limit 10;

drop table merged_tb3

create table merged_tb3 as (
SELECT * FROM
	(
		SELECT
		emp_no, 
		emp_title_id,
		birth_date,
		first_name,
		last_name,
		sex,
		hire_date,
		salary,
		mt2.dept_no,
		dt.dept_name
		FROM merged_tb2 AS mt2
		LEFT JOIN departments AS dt
			ON mt2.dept_no = dt.dept_no
	) AS Employees_Data
);

select *
from merged_tb3
limit 10;

create table merged_tb4 as (
SELECT * FROM
	(
		SELECT
		mt3.emp_no, 
		mt3.emp_title_id,
		mt3.birth_date,
		mt3.first_name,
		mt3.last_name,
		mt3.dept_no,
		mt3.dept_name
		FROM merged_tb3 AS mt3
		LEFT JOIN dept_manager AS dm
			ON mt3.emp_no = dm.emp_no
	) AS Employees_Data2
);

select *
from merged_tb4
limit 10;

create table merged_tb5 as (
SELECT * FROM
	(
		SELECT
		mt3.emp_no, 
		mt3.emp_title_id,
		mt3.birth_date,
		mt3.first_name,
		mt3.last_name,
		mt3.sex,
		mt3.hire_date,
		mt3.salary,
		mt3.dept_no,
		mt3.dept_name,
		t.title
		FROM merged_tb3 AS mt3
		LEFT JOIN titles AS t
			ON mt3.emp_title_id = t.title_id
	) AS Employees_Data
);

select *
from merged_tb5
limit 10;