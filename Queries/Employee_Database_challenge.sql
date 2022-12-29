-- Create new table for retiring employees
SELECT em.emp_no,
    em.first_name,
    em.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as em
    INNER JOIN titles as t
    ON (em.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
;
-- Check the table
SELECT * FROM retirement_info;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, title DESC;

-- Get the count of retiting employees by title in descending order
SELECT COUNT(emp_no),
title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;


--DELIVERABLE 2: The Employees Eligible for the Mentorship Program

-- create a table to find eligible employees by current employment and birthdate
SELECT DISTINCT ON (em.emp_no) em.emp_no,
    em.first_name,
    em.last_name,
    em.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as em
INNER JOIN dept_emp as de
    ON em.emp_no = de.emp_no
INNER JOIN titles as t
    ON em.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01') AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY em.emp_no;

