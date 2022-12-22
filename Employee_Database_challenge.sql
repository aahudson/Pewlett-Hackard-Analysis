-- Creating tables for PH-EmployeeDB
DROP TABLE departments; 
CREATE TABLE departments (
     dept_no VARCHAR(6) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
DROP TABLE employees; --cascade; 
CREATE TABLE employees (
	emp_no VARCHAR(6) NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

DROP TABLE dept_manager;
CREATE TABLE dept_manager (
dept_no VARCHAR(6) NOT NULL,
    emp_no VARCHAR(6) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE dept_emp;
CREATE TABLE dept_emp (
	emp_no VARCHAR(6) NOT NULL,
    dept_no VARCHAR(6) NOT NULL,
      from_date DATE NOT NULL,
      to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE titles;
CREATE TABLE titles (
	emp_no VARCHAR NOT NULL,
	title VARCHAR(50) NOT NULL,
  	from_date DATE NOT NULL,
  	to_date DATE NOT NULL
--	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
--	PRIMARY KEY (emp_no, title)
);


DROP TABLE salaries; 
CREATE TABLE salaries (
	emp_no VARCHAR NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, from_date)
);

-- select * from departments 
-- Create a table that holds all the titles of employees who were born between January 1, 1952 and December 31, 1955
DROP TABLE retirement_titles_table; 
SELECT DISTINCT on (e.emp_no) e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles_table
FROM employees AS e
LEFT JOIN titles AS t
ON e.emp_no = t.emp_no 
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND t.to_date > NOW() -- exclude employees who have already left the company
ORDER BY e.emp_no, t.from_date DESC;

SELECT t.title, COUNT(*) AS num_employees
FROM retirement_titles_table AS t
GROUP BY t.title
ORDER BY num_employees DESC;


-- Create a Mentorship Eligiblity Tabel for current temployees 1954-01-01 - 1965-12-31 
-- employee data and titles data 
-- join employees and dept_emp tables o the primary key 
-- filter the data on the to_date to all current employees
-- fileter data on the birth_date columns to get all employees brith rnage 1965-01-01 to 1965-12-31
-- order table by employee number 
-- export to mentorship eligibility table as mentorship_eligibilty.csv

DROP TABLE mentorship_eligibilty; 
SELECT DISTINCT on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, ed.from_date, ed.to_date, t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS ed
ON (e.emp_no = ed.emp_no) 
INNER JOIN titles as t
ON (e.emp_no = t.emp_no) 
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND ed.to_date > NOW() -- exclude employees who have already left the company
ORDER BY e.emp_no ASC; 


select * from  mentorship_eligibilty; 

-- --------------------------
select emp_no from  dept_emp; 
select emp_no from employees;
select * from titles; 

select e.emp_no, e.birth_date, x.from_date, x.to_date
FROM employees AS e
LEFT JOIN dept_emp AS x
ON (e.emp_no = x.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'



-- ------------------------------------

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT * FROM retirement_info;

