-- Data Engineering --
-- Drop Tables if Existing
DROP TABLE IF EXISTS departments cascade;
DROP TABLE IF EXISTS dept_emp cascade;
DROP TABLE IF EXISTS dept_manager cascade;
DROP TABLE IF EXISTS employees cascade;
DROP TABLE IF EXISTS salaries cascade;
DROP TABLE IF EXISTS titles cascade;


CREATE TABLE titles (
    title_id varchar(5) Primary Key,
    title varchar(30) NOT NULL
);

CREATE TABLE departments (
    dept_no varchar(10) Primary Key,
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


