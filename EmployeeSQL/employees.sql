

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

