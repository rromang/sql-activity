---Data Analysis
--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT
		emp_no, 
		first_name,
		last_name,
		sex,
		salary
FROM employee_info_new;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT
		emp_no, 
		first_name,
		last_name,
		hire_date
FROM employee_info_new
WHERE hire_date LIKE '%1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT
	dept_no,
	dept_name,
	emp_no,
	first_name,
	last_name
FROM dept_mgr_info;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT
		first_name,
		last_name,
		sex
FROM employee_info_new
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';


--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT
		emp_no,
		last_name,
		first_name,
		dept_name		
FROM employee_info_new
WHERE dept_name LIKE 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
		emp_no,
		last_name,
		first_name,
		dept_name		
FROM employee_info_new
WHERE dept_name LIKE 'Sales' OR dept_name LIKE 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT COUNT(emp_no), last_name
FROM employee_info_new
GROUP BY employee_info_new.last_name
ORDER BY COUNT(emp_no) DESC;