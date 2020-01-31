-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
-- I also added from and to dates, as one employee may have multiple salaries over time
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name",
e.first_name AS "First Name", e.gender AS "Gender", s.salary, s.from_date, s.to_date
FROM employees e,  salaries s
WHERE e.emp_no = s.emp_no
ORDER BY last_name, first_name, s.from_date;

-- 2. List employees who were hired in 1986.
SELECT last_name AS "Last Name", first_name AS "First Name"
FROM employees 
WHERE DATE_PART('year', hire_date) = 1986;

-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, 
--    last name, first name, and start and end employment dates.
SELECT d.dept_no AS "Dept Num", d.dept_name AS "Dept Name",
m.emp_no AS "Mgr Emp Num", e.last_name AS "Last Name", e.first_name AS "First Name", 
m.from_date AS "From Date", m.to_date AS "To Date"
FROM departments d, dept_manager m, employees e
WHERE d.dept_no = m.dept_no AND m.emp_no = e.emp_no
ORDER BY d.dept_name, m.from_date;

-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.
SELECT e.emp_no AS "Employee Num", e.last_name AS "Last Name",
e.first_name AS "First Name", d.dept_name AS "Department"
FROM employees e 
INNER JOIN dept_emp ON e.emp_no = dept_emp.emp_no
INNER JOIN departments d ON dept_emp.dept_no = d.dept_no
ORDER BY "Department", "Last Name", "First Name";

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name AS "First Name", last_name AS "Last Name"
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, 
--    last name, first name, and department name.
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", d.dept_name AS "Department"
FROM employees e
INNER JOIN dept_emp ON e.emp_no = dept_emp.emp_no
INNER JOIN departments d ON dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name, e.first_name;

-- 7. List all employees in the Sales and Development departments, 
--    including their employee number, last name, first name, and department name.
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", d.dept_name AS "Department"
FROM employees e
INNER JOIN dept_emp ON e.emp_no = dept_emp.emp_no
INNER JOIN departments d ON dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name, e.last_name, e.first_name;

-- 8. In descending order, list the frequency count of employee last names, 
--    i.e., how many employees share each last name.
SELECT last_name AS "Last Name", COUNT(last_name) AS "Total"
FROM employees
GROUP BY "Last Name"
ORDER BY "Total" DESC;

-- Part of bonus question....
-- Look up employee details for employee #499942
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.emp_no = 499942;
-- Query returns employee name of April Foolsday

SELECT * FROM salaries WHERE emp_no = 499942;
-- Query returns that this employee is only paid from 3-28-1998 to 3-28-1999

SELECT s.salary, t.title, s.from_date, s.to_date 
FROM salaries s 
INNER JOIN titles t ON s.emp_no = t.emp_no AND s.from_date >= t.from_date AND s.to_date <= t.to_date
WHERE t.emp_no = 499942;
-- Query show that this employee was paid $40,000 as a Technique Leader

