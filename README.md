# SQL Practical Application
(sql-challenge)

## Repository containing SQL homework assignment from UofA Data Analytics Bootcamp.


### Organization of Work/Files

1. CSV => the necessary CSV files to create the tables are located in the /EmployeeSQL/CSVs folder
2. SQL files => there are 2 sql files: employees.sql contains the code to create the tables while employees_analysis contains the queries to filter/call for specific information from the tables.
3. In the main branch there are is the image for the quickdatabasediagrams.com ERD. In there it can also be found the exported schema (employees_qdbd.sql) resulting from the table relationship created in the website which was used to create the tables in the employees.sql file. Additionally, there is the Jupyter notebook with the work towards the bonus.

### Summary

 - All the necessary tables were created. The approach chosen resulted in the creation of intermediary tables that were systematically added/joined to other tables. In the end, I chose to leave all the tables in the .sql file however, in a different setup or for a different purpose I would have deleted the intermediary tables and kept the final table(s) with all the needed information.

 - I encountered an issue in the bonus piece when I called the table in the database resulting from the lack of a primary key. I went back to the table and altered it to included a serial primary key and that allowed me to run the process.

 - For the bonus, I followed the examples in class for most of the initial work. After searching for the employee number 499942, it revealed the first and last name to be April Foolsday, confirming it is a fake, test database.
