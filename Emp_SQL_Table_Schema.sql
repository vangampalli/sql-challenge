create table departments (
	dept_no varchar(30) not null Primary Key,
	dept_name varchar(30) not null 
	); 

SELECT *
FROM departments;

drop table employees; 

create table employees (
	emp_no int primary key, 
	emp_title_id varchar (30) not null, 
	birth_date date,
	first_name varchar (30) not null,
	last_name varchar (30) not null, 
	sex varchar (1) not null, 
	hire_date date); 
	
SELECT * 
From employees; 

drop table dept_emp; 

create table dept_emp (
	emp_no int not null,
	foreign key (emp_no) references employees(emp_no),
	dept_no varchar(30) not null, 
	foreign key (dept_no) references departments(dept_no)
	);
	
SELECT * 
FROM dept_emp;

drop table dept_manager; 

create table dept_manager (
	dept_no varchar(30) not null,
	foreign key (dept_no) references departments(dept_no), 
	emp_no int not null, 
	foreign key (emp_no) references employees(emp_no)
	); 

SELECT * 
From dept_manager; 

drop table salaries; 

create table salaries (
	emp_no int primary key, 
	salary int); 

SELECT *
From salaries; 

drop table titles; 

create table titles(
	title_id varchar (30)not null primary key, 
	title varchar (30) not null); 

SELECT * 
From titles; 


