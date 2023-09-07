# Pewlett Hackard 

![image](https://github.com/Jaynav04/Pewlett-Hackard-Employee-Analysis/assets/130405173/12fb88d4-a7c5-4a84-b35d-85578b89e378)


# Topic
It’s been two weeks since I was hired as a new data engineer at Pewlett Hackard (a fictional company). My first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

In this project, my tasks involved designing tables to accommodate data from CSV files, importing those CSV files into a SQL database, and subsequently addressing data-related inquiries. To elaborate, I carried out data modeling, data engineering, and data analysis in that order.

# Tools Used
- QuickDBD
- pgAdmin 4
- PostgresSQL

## Project is broken up into the following steps
1. Data Modeling
2. Data Engineering
3. Data Analysis

# Data Modeling
Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables using QuickDBD


![image](https://github.com/Jaynav04/sql-challenge/assets/130405173/52b532ee-f354-46b8-b8c9-d2c898deb841)

# Data Engineering (Data Modeling)

Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:

- I must specify the data types, primary keys, foreign keys, and other constraints.

- For the primary keys, verify that the column is unique. Otherwise, create a composite key which takes two primary keys to uniquely identify a row.

- Import each CSV file into its corresponding SQL table.


-- Drop Tables if Existing including its cascades in case we need to start over

	DROP TABLE IF EXISTS departments cascade;
	DROP TABLE IF EXISTS dept_emp cascade;
	DROP TABLE IF EXISTS dept_manager cascade;
	DROP TABLE IF EXISTS employees cascade;
	DROP TABLE IF EXISTS salaries cascade;
	DROP TABLE IF EXISTS titles cascade;

-- Creating tables including primary keys, foreign keys, data types, and not null columns

	CREATE TABLE titles (
	    title_id varchar(5) Primary Key,
	    title varchar(30) NOT NULL
	);
	
	CREATE TABLE departments (
	    dept_no varchar(10) NOT NULL Primary Key,
	    dept_name varchar(30) NOT NULL
	);
	
	CREATE TABLE employees (
	    emp_no int NOT NULL Primary Key,
	    emp_title_id varchar(5) NOT NULL,
		foreign key (emp_title_id) references titles(title_id),-- foreign key
	    birth_date varchar(10) NOT NULL,
	    first_name varchar(30) NOT NULL,
	    last_name varchar(30) NOT NULL,
	    sex char(1) NOT NULL,
	    hire_date varchar(10) NOT NULL
	);
	
	CREATE TABLE dept_emp (
	    emp_no int NOT NULL,--foreign key
		foreign key (emp_no) references employees(emp_no),
	    dept_no varchar(5) NOT NULL,-- foreign key
		foreign key (dept_no) references departments(dept_no)
	);
	
	CREATE TABLE salaries (
	    emp_no int NOT NULL,--foreign key
		foreign key (emp_no) references employees(emp_no),
	    salary int NOT NULL
	);

	CREATE TABLE dept_manager (
	    dept_no varchar(10) NOT NULL, --foreign key
		foreign key (dept_no) references departments (dept_no),
	    emp_no int NOT NULL,-- foreign key
		foreign key (emp_no) references employees(emp_no)
	);

--Import CSV's
--Verify Data exists

	select * from titles;
	select * from departments;
	select * from employees;
	select * from dept_emp;
	select * from salaries;
	select * from dept_manager;

# Data Analysis (Conducting Analysis Queries)
-- 1.List the employee number, last name, first name, sex, and salary of each employee.
	
	select e.emp_no, e.last_name,e.first_name,e.sex,s.salary
	from employees e
	join salaries s
	on e.emp_no = s.emp_no;
	
-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
	
	--changing hire_date column to data type date
	select * from employees
	alter table employees alter column hire_date type date
	using to_date(hire_date,'mm/dd/yyy');
	
	--filtering employees table for employees hired in 1986 only
	select first_name,last_name,hire_date
	from employees 
	where hire_date >= '1986-01-01' and
	hire_date <= '1986-12-31';
	
--3.List the manager of each department along with their department number, department name, employee number, last name, and first name
	
	select departments.dept_no,departments.dept_name,dept_manager.emp_no,employees.last_name,employees.first_name
	from departments 
	left join dept_manager
	on departments.dept_no = dept_manager.dept_no
	left join employees
	on employees.emp_no = dept_manager.emp_no;


--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
	
	select dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
	from dept_emp
	join departments
	on dept_emp.dept_no = departments.dept_no
	join employees 
	on dept_emp.emp_no = employees.emp_no;

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B

	select first_name,last_name,sex
	from employees 
	where first_name = 'Hercules' and
	last_name like 'B%'; 

--6. List each employee in the Sales department, including their employee number, last name, and first name 

	select dept_emp.emp_no,employees.last_name,employees.first_name
	from dept_emp
		join employees 
		on dept_emp.emp_no = employees.emp_no
		join departments 
		on dept_emp.dept_no = departments.dept_no
	where dept_name = 'Sales';

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
	
	select dept_emp.emp_no, employees.last_name,employees.first_name,departments.dept_name
	from dept_emp
	join employees 
	on dept_emp.emp_no = employees.emp_no
	join departments 
	on dept_emp.dept_no = departments.dept_no
	where dept_name = 'Sales' or
	dept_name = 'Developement';

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
	
 	select distinct(last_name), count(last_name) as Frequency
	from employees
	group by distinct(last_name)
	order by count(last_name) desc;
