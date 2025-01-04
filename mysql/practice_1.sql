-- Employee with the lowest salary in the company
SELECT first_name, salary
FROM employee_salary
WHERE salary = (SELECT MIN(salary) AS lowest_salary FROM employee_salary);

-- List all employees whose salary is greater than the average salary in their departments
SELECT *
FROM employee_salary
WHERE salary > (
SELECT AVG(salary)
FROM employee_salary
WHERE employee_salary.dept_id = dept_id
)
;

-- Rank all employees based on their salary (highest to lowest)
SELECT *,
RANK() OVER (ORDER BY salary DESC) AS salary_ranking
FROM employee_salary
;

-- Calculate teh culumitive total of salaries ordered by employee_id
SELECT first_name, last_name, salary, employee_id,
SUM(salary)
OVER (ORDER BY employee_id) AS cumulative_salary
FROM employee_salary
;

-- Classify employees into salary bands: High (salary > 75,000), Medium (50,000–75,000), and Low (salary < 50,000).
SELECT first_name, last_name, salary,
CASE
	WHEN salary > 75000 THEN 'High'
    WHEN salary BETWEEN 50000 AND 75000 THEN 'Medium'
    WHEN salary < 50000 THEN 'Low'
END AS salary_category
FROM employee_salary
;

SELECT first_name, last_name, occupation, salary,
CASE
	WHEN occupation LIKE "%manager%" THEN (salary * 0.20)
    WHEN occupation LIKE "%Analyst%" THEN (salary * 0.10)
    ELSE (salary * 0.05)
END AS bonus
FROM employee_salary
;

-- Combine employee_salary with a departments table (columns: dept_id, dept_name) to display each employee's department name.
SELECT dept_id, first_name, last_name, department_name
FROM employee_salary
INNER JOIN parks_departments ON dept_id = department_id
;


-- List all departments and the total number of employees in each, including departments with no employees.
SELECT dept_id, COUNT(dept_id) AS total_employees
FROM employee_salary
INNER JOIN parks_departments ON dept_id = department_id
GROUP BY dept_id
;

-- Combine two queries to display:
SELECT *
FROM employee_salary
WHERE salary > 75000
UNION
SELECT *
FROM employee_salary
WHERE occupation LIKE '%Manager%'
;