SELECT first_name, last_name, emp_no
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

SELECT title, from_date, to_date, emp_no
FROM titles

SELECT emp_no, first_name, last_name
INTO new_employee
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- Check the table
SELECT * FROM new_employee;

SELECT title, from_date, to_date, emp_no
INTO new_titles
FROM titles
-- Check the table
SELECT * FROM new_titles;


SELECT new_employee.emp_no,
    new_employee.first_name,
	new_employee.last_name,
	new_titles.title,
	new_titles.from_date,
	new_titles.to_date
FROM new_employee
LEFT JOIN new_titles
ON new_employee.emp_no = new_titles.emp_no
ORDER BY emp_no ASC;

SELECT es.emp_no,
		es.first_name,
		es.last_name,
		ti.title, 
		ti.from_date,
		ti.to_date
INTO challenge_data
FROM employees as es
INNER JOIN titles as ti
ON (es.emp_no = ti.emp_no)
WHERE (es.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY (es.emp_no = ti.emp_no);
select * from challenge_data;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT cd.emp_no,
		cd.first_name,
		cd.last_name,
		cd.title, 
		cd.to_date
INTO recent_titles
FROM challenge_data AS cd;

select * from recent_titles

SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
					ret.first_name,
					ret.last_name,
					ret.title 
INTO unique_titles
FROM recent_titles AS ret
ORDER BY ret.emp_no ASC, ret.to_date DESC;
select * from unique_titles

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
Group By ut.title
ORDER By count DESC;
select * from retiring_titles

SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
					ret.first_name,
					ret.last_name,
					ret.title 
INTO unique_titles
FROM recent_titles AS ret
ORDER BY ret.emp_no ASC, ret.to_date DESC;
select * from unique_titles

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
Group By ut.title
ORDER By count DESC;
select * from retiring_titles

SELECT DISTINCT ON (e.emp_no) e.emp_no,
					e.first_name,
					e.last_name,
					e.birth_date,
					de.from_date,
					de.to_date,
					ti.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_employees AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND ti.to_date='9999-01-01'
ORDER BY e.emp_no ASC;

select * from mentorship_eligibility
-- query
SELECT es.emp_no,
		es.birth_date,
		es.first_name,
		es.last_name,
		rt.title,
		ti.from_date,
		ti.to_date
INTO final_retire
FROM employees as es
INNER JOIN titles as ti
ON (es.emp_no = ti.emp_no)
INNER JOIN retiring_titles as rt
ON (ti.title = rt.title)
WHERE (es.birth_date BETWEEN '1952-01-01' AND '1952-12-31')
ORDER BY (es.emp_no = ti.emp_no);
select * from final_retire