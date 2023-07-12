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
| salary_difference |
| ----------------- |
| 2400              |

/* We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. 
Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. 
Order your list by employee ID in ascending order.

Hints 
Ideally this dataset should consists of unique records of employees for only current year
There are multiple years of data can be found for some employees
Until now at every compensation revision cycle, all employees have received a salary increase so you can assume that the highest salary is the employee's current salary. Use a max() function to find the highest salary for each employee.
The output should be all the details of all the employees with correct salary */

select 
    distinct id,
    first_name,
    last_name,
    MAX(salary) as salary,
    department_id
from ms_employee_salary
group by 
     id,
    first_name,
    last_name,
    department_id;
| id | first_name | last_name | salary | department_id |
| -- | ---------- | --------- | ------ | ------------- |
| 1  | Todd       | Wilson    | 110000 | 1006          |
| 2  | Justin     | Simon     | 130000 | 1005          |
| 3  | Kelly      | Rosario   | 42689  | 1002          |
