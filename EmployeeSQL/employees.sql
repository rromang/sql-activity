

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


--Create table with employee info plus salary info

create table employee_salary as (
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
from employee_salary
limit 10;


--Create table with employee info plus salary and dept_no
create table employee_dept as (
SELECT 
	es.emp_no, 
	es.emp_title_id,
	es.birth_date,
	es.first_name,
	es.last_name,
	es.sex,
	es.hire_date,
	es.salary,
	de.dept_no
    FROM employee_salary as es , dept_employees as de 
    WHERE es.emp_no = de.emp_no
);

--Check merged table
select *
from employee_dept
limit 10;


--Create table with employee info plus salary, dept_no and dept_name
create table employee_deptname as (
SELECT * FROM
		(SELECT
		ed.emp_no, 
		ed.emp_title_id,
		ed.birth_date,
		ed.first_name,
		ed.last_name,
		ed.sex,
		ed.hire_date,
		ed.salary,
		ed.dept_no,
		dt.dept_name
		FROM employee_dept AS ed
		LEFT JOIN departments AS dt
			ON ed.dept_no = dt.dept_no
		 )  AS Employees_Data
);

select *
from employee_deptname
limit 10;

--Create table with employee info plus salary, dept_no, dept_name and title
create table employee_info as (
SELECT * FROM
	(
		SELECT
		en.emp_no, 
		en.emp_title_id,
		en.birth_date,
		en.first_name,
		en.last_name,
		en.sex,
		en.hire_date,
		en.salary,
		en.dept_no,
		en.dept_name,
		t.title
		FROM employee_deptname AS en
		LEFT JOIN titles AS t
			ON en.emp_title_id = t.title_id
	) AS Employees_Data
);

select *
from employee_info
limit 10;

--Change order of columns
CREATE TABLE employee_info_new as (
SELECT * FROM
	(
		SELECT
		emp_no, 
		emp_title_id,
		dept_no,
		dept_name,
		title,
		birth_date,
		first_name,
		last_name,
		sex,
		hire_date,
		salary
		FROM employee_info
	) AS Employees_Data
);

select *
from employee_info_new
limit 10;


drop table dept_mgr_info
--Create table with employee info plus salary, dept_no and dept_name but only for dept managers
create table dept_mgr_info as (
SELECT * FROM
	(
		SELECT
		en.emp_no, 
		en.emp_title_id,
		en.title,
		en.dept_no,
		en.dept_name,
		en.birth_date,
		en.first_name,
		en.last_name
		FROM employee_info_new AS en
		LEFT JOIN dept_manager AS dm
			ON en.emp_no = dm.emp_no
	) AS Employees_Data2
);

select *
from dept_mgr_info
limit 10;



