
--Remove employee table if exists
drop table "Employees";


--Create Table with employee information

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(30)   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(5)   NOT NULL,
    "hire_date" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);
--Import CSV
--Quick View of imported data
select *
from "Employees"
limit 5;

--Remove titles table if exists
drop table "Titles";

--Create Titles table
CREATE TABLE "Titles" (
    "title_id" VARCHAR(30)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

--Import CSV
--Quick View of imported data
select *
from "Titles"
limit 5;

--Remove titles table if exists
drop table "Department_Mgr";

--Create Department_Mgr table
CREATE TABLE "Department_Mgr" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT null,
    primary key ("emp_no","dept_no")
);

--Import CSV
--Quick View of imported data
select *
from "Department_Mgr"
limit 5;

--Remove salaries table if exists
drop table "Salaries";

--Create Salaries table
CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT null,
    primary key ("emp_no","salary")
);

--Import CSV
--Quick View of imported data
select *
from "Salaries"
limit 5;


--Remove manager table if exists
drop table "Manager";

--Create Manager table
CREATE TABLE "Manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT null,
    primary key ("dept_no","emp_no")
);

--Import CSV
--Quick View of imported data
select *
from "Manager"
limit 5;

