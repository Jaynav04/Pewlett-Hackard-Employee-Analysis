-- 1.List the employee number, last name, first name, sex, and salary of each employee.
	--Merge employees and salaries table
	select e.emp_no, e.last_name,e.first_name,e.sex,s.salary
	from employees e
	join salaries s
	on e.emp_no = s.emp_no;
	
-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
	
	--change hire_date column to data type date
	select * from employees
	alter table employees alter column hire_date type date
	using to_date(hire_date,'mm/dd/yyy');
	
	--filter employees table for employees hired in 1986 only
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