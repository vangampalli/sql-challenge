--merging files to query

create view merge1 as(
SELECT departments.dept_no, departments.dept_name, dept_emp.emp_no
FROM dept_emp
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
);


select *
From merge1;


create view merge2 as(
SELECT merge1.dept_no, merge1.dept_name, merge1.emp_no, salaries.salary
FROM salaries
INNER JOIN merge1 ON 
merge1.emp_no=salaries.emp_no
);

select* 
From merge2;

drop table merge3;

create view merge3 as(
Select merge2.dept_no, merge2.dept_name, merge2.emp_no, merge2.salary, employees.emp_title_id, employees.birth_date, employees.first_name, employees.last_name, employees.sex, employees.hire_date
From employees 
Inner Join merge2 ON 
merge2.emp_no = employees.emp_no
);

select* 
From merge3 

drop table merge4;

create view merge4 as(
Select merge3.dept_no, merge3.dept_name, merge3.emp_no, merge3.salary, merge3.emp_title_id, merge3.birth_date, merge3.first_name, merge3.last_name, merge3.sex, merge3.hire_date, titles.title
From titles
Inner Join merge3 ON
merge3.emp_title_id = titles.title_id
);

select * 
From merge4;

--List the following details of each employee: employee number, last name, first name, sex, and salary.

create view employee_details as(
select emp_no, last_name, first_name, sex, salary 
from merge4); 

select * 
From employee_details;

--List first name, last name, and hire date for employees who were hired in 1986.

create view hires_1986 as (
select first_name, last_name, hire_date
from merge4 
where extract(year from hire_date) = 1986); 

select *
From hires_1986;

--List the manager of each department with Department Number, Department Name, 
--Manager's Employee Number, Last Name, 
--First Name, Department Name

create view manager_df as (
	select distinct dept_manager.dept_no, merge4.dept_name, dept_manager.emp_no, merge4.last_name, merge4.first_name
	from dept_manager 
	inner join merge4
	on dept_manager.emp_no = merge4.emp_no);
	
select * 
from manager_df;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

create table department_emps as (
	select dept_name, emp_no, last_name, first_name
	from merge4 ); 
	
select * 
from department_emps;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

create view hercules as (
	select first_name, last_name, sex
	from merge4 
	where first_name = 'Hercules' 
	and last_name in
		(select last_name
		 from merge4 
		 where last_name LIKE 'B%'));

select * 
from hercules;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

create view sales_dept as (
	select emp_no, last_name, first_name, dept_name
	from merge4
	where dept_name = 'Sales');

select * 
from sales_dept;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

create view sales_devs as (
	select emp_no, last_name, first_name, dept_name
	from merge4
	where dept_name = 'Sales' or dept_name = 'Development');

select * 
from sales_devs;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

create view last_name_freq as ( 
	select last_name, COUNT(last_name) as "Last Names"
	from merge4
	group by last_name
	order by "Last Names" DESC); 

select * 
from last_name_freq;

--BONUS table 1 -Gender perentage of employees 

create view gender_counts as ( 
	select sex, (Count(sex) * 100/ (Select Count(*) from merge4)) as "Total Employee Sex %"
	from merge4 
	group by sex)
	
select * 
from gender_counts

--BONUS table 2 -Highest Salary of the Managers in descending order  

create view mngr_sal as ( 
	select salaries.salary, manager_df.dept_name, manager_df.last_name, manager_df.first_name
	from salaries 
	inner join manager_df
	on salaries.emp_no = manager_df.emp_no
	order by salary DESC);

select * 
from mngr_sal

--BONUS table 3 -Largest Departments 

create view largest_dept as (
	select dept_name, count(dept_name) as "Department Size"
	from Merge4 
	group by dept_name 
	order by "Department Size" DESC); 

select * 
from largest_dept 

