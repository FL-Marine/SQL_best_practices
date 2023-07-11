/*Salaries Differences 
Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.
Hints
JOIN the department table with employee table to get a list of employees, salaries, and department
GROUP BY max salary by department in two different queries
Select difference of highest salaries between two departments
*/
SELECT
    (MAX(CASE WHEN dept.department = 'marketing' THEN emp.salary END) - MAX(CASE WHEN dept.department = 'engineering' THEN emp.salary END)) AS salary_difference
FROM db_employee AS emp
LEFT JOIN db_dept AS dept
    ON dept.id = emp.department_id
WHERE dept.department IN ('marketing', 'engineering');

-- output is 2400
