USE employee;

-- 1. Distinct Values: Retrieve distinct salaries from the Employees table
SELECT DISTINCT salary FROM employees;

-- 2. Alias (AS): Provide aliases for "age" and "salary" as "Employee_Age" and "Employee_Salary"
SELECT age AS Employee_Age, salary AS Employee_Salary FROM employees;

-- 3. Where Clause & Operators: Employees with salary > 50000 and hired before 2016-01-01
SELECT * FROM employees 
WHERE salary > 50000 AND hire_date < '2016-01-01';

-- 3b. Find the employee whose designation is missing and view it filled with "Data Scientist"
SELECT employee_id, employee_name, COALESCE(designation, 'Data Scientist') AS designation 
FROM employees;

-- 4a. ORDER BY: Find employees sorted by department ID ascending and salary descending
SELECT * FROM employees 
ORDER BY department_id ASC, salary DESC;

-- 4b. LIMIT: Display the first 5 employees hired in the year 2018
SELECT * FROM employees 
WHERE hire_date BETWEEN '2018-01-01' AND '2018-12-31' 
LIMIT 5;

-- 5a. Aggregate Functions: Calculate the sum of all salaries in the Finance department
SELECT SUM(e.salary) AS total_finance_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- 5b. Find the minimum age among all employees
SELECT MIN(age) AS min_employee_age FROM employees;

-- 6a. GROUP BY: List the maximum salary for each location
SELECT l.location, MAX(e.salary) AS max_salary
FROM employees e
JOIN location l ON e.location_id = l.location_id
GROUP BY l.location;

-- 6b. Calculate the average salary for each designation containing the word 'Analyst'
SELECT designation, AVG(salary) AS average_salary
FROM employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

-- 7a. HAVING: Find departments with less than 3 employees
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;

-- 7b. Find locations with female employees whose average age is below 30
SELECT l.location
FROM employees e
JOIN location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;

-- 8a. Inner Join: List employee names, designations, and department names where assigned
SELECT e.employee_name, e.designation, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 8b. Left Join: List all departments along with total employees, including those with no employees
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 8c. Right Join: Display all locations with employee names (display NULL if none assigned)
SELECT l.location, e.employee_name
FROM employees e
RIGHT JOIN location l ON e.location_id = l.location_id;