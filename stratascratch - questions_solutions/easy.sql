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
Until now at every compensation revision cycle, all employees have received a salary increase so you can assume that the highest salary is the employee's current salary. 
    Use a max() function to find the highest salary for each employee.
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

/* 
Find the last time each bike was in use. Output both the bike number and the date-timestamp of the bike's last use (i.e., the date-time the bike was returned). Order the results by bikes that were most recently used.

Hints
To find the last time each bike was in use, we need to select the bike number and the date-timestamp of the bike's last use from the dc_bikeshare_q1_2012 table.
We also need to order the results by bikes that were most recently used.*/

select 
    bike_number,
    max(end_time) AS last_used
from dc_bikeshare_q1_2012
group by bike_number
order by last_used desc
| bike_number | last_used       |
| ----------- | --------------- |
| W01278      | 3/31/2012 19:28 |
| W01097      | 3/31/2012 15:37 |

/* Find the number of rows for each review score earned by 'Hotel Arena'. Output the hotel name (which should be 'Hotel Arena'),
review score along with the corresponding number of rows with that score for the specified hotel.
*/
SELECT 
    hotel_name,
    reviewer_score,
    COUNT(reviewer_score) AS count
FROM hotel_reviews
WHERE hotel_name = 'Hotel Arena'
GROUP BY  
    hotel_name,
    reviewer_score;
| hotel_name  | reviewer_score | count |
| ----------- | -------------- | ----- |
| Hotel Arena | 3.8            | 1     |
| Hotel Arena | 4.2            | 1     |
| Hotel Arena | 4.6            | 1     |
| Hotel Arena | 5.4            | 1     |

/* Count the number of movies that Abigail Breslin was nominated for an oscar.*/
SELECT 
    SUM(CASE WHEN nominee = 'Abigail Breslin' THEN 1 ELSE 0 END) AS n_movies_by_abi
FROM oscar_nominees;

-- This query works as well

SELECT COUNT(*) AS n_movies_by_abi
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin'
| n_movies_by_abi |
| --------------- |
| 1               |

/* 
Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.
select * from facebook_reactions;
select * from facebook_posts;
I need to join two tables together via post_id
Output must have post_id, post_text, post_keywords, post_date*/
 SELECT
    TOP 1
    fbr.post_id,
    fbr.poster,
    fbp.post_text,
    fbp.post_keywords,
    fbp.post_date
 FROM facebook_reactions AS fbr
 LEFT JOIN facebook_posts AS fbp
    ON fbr.post_id = fbp.post_id
WHERE reaction = 'heart';
| post_id | poster | post_text                  | post_keywords                 | post_date |
| ------- | ------ | -------------------------- | ----------------------------- | --------- |
| 1       | 1      | Lebron James is top class. | [basketball,lebron_james,nba] | 1/2/2019  |

/*Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees.
The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack.
Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location.
Luckily the user IDs of employees completing the surveys were stored.
Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.

Requirements
- Output must be 2 columns location and avg popularity by that location
- Need to JOIN facebook_employees to facebook_hack_survey ON id field

select * from facebook_employees;
select * from facebook_hack_survey;
*/

/* The reason for casting popularity as a float in the SQL query is to ensure that the result of the AVG function is a floating point number, which can handle decimal values. 
    If the AVG function were to operate on integers, the result would be an integer, and the fractional part would be discarded.
 The reason some numbers are whole while others have decimal places is due to the nature of the AVG function and the data it operates on.*/
SELECT
    fb_emp.location,
    AVG(CAST(fb_hs.popularity AS FLOAT)) AS avg_popularity
FROM facebook_employees AS fb_emp
LEFT JOIN facebook_hack_survey AS fb_hs
    ON fb_emp.id = fb_hs.employee_id
GROUP BY fb_emp.location;
| location    | avg_popularity |
| ----------- | -------------- |
| India       | 7.5            |
| Switzerland | 1              |
| UK          | 4.333          |
| USA         | 4.6            |

/* Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
Output all details related to retrieved records.*/
SELECT * 
FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000;
| index | start_date | end_date  | yearly_salary |
| ----- | ---------- | --------- | ------------- |
| 10    | 4/25/2018  | 4/28/2018 | 79536         |
| 14    | 11/30/2015 | 4/24/2018 | 89270         |
| 15    | 5/29/2018  |           | 87766         |
| 17    | 5/7/2017   |           | 88828         |
| 18    | 11/9/2018  |           | 82993         |
| 20    | 4/23/2015  | 1/30/2017 | 71683         |

/*Find how many times each artist appeared on the Spotify ranking list
Output the artist name along with the corresponding number of occurrences.
Order records by the number of occurrences in descending order.*/
SELECT
    artist,
    COUNT(streams) AS n_occurrences
FROM spotify_worldwide_daily_song_ranking
GROUP BY artist
ORDER BY n_occurrences DESC;
| artist         | n_occurrences |
| -------------- | ------------- |
| Kendrick Lamar | 9             |
| Ed Sheeran     | 5             |
| Khalid         | 2             |
| Manuel Turizo  | 2             |

/* Find the base pay for Police Captains. Output the employee name along with the corresponding base pay.*/
SELECT 
    employeename,
    basepay
FROM sf_public_salaries
WHERE jobtitle LIKE '%CAPTAIN%'
| employeename      | basepay  |
| ----------------- | -------- |
| PATRICIA JACKSON  | 99722    |
| TERESA BARRETT    | 188328.1 |
| ANNA BROWN        | 102571.2 |
| DOUGLAS MCEACHERN | 194566   |
| JOHN LOFTUS       | 188341.6 |

/* Find libraries who haven't provided the email address in circulation year 2016 but their notice preference definition is set to email.
Output the library code.*/
SELECT DISTINCT     
    home_library_code
FROM library_usage
WHERE notice_preference_definition = 'email' AND 
 circulation_active_year = 2016 AND
 provided_email_address = 0;
| home_library_code |
| ----------------- |
| E9                |
| P7                |
| R3                |
| X                 |

/*Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees along with the average salary of that department.*/
SELECT
    department,
    first_name,
    salary,
    AVG(CAST(salary as float))
    OVER (PARTITION BY department) AS dept_avg_salary
FROM employee;
| department | first_name | salary | dept_avg_salary |
| ---------- | ---------- | ------ | --------------- |
| Audit      | Shandler   | 1100   | 950             |
| Audit      | Jason      | 1000   | 950             |
| Audit      | Celine     | 1000   | 950             |
| Audit      | Michale    | 700    | 950             |

/*Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.
-- Need 4 columns, 3 from orders table & 1 from customers
-- Need to JOIN on id column */
SELECT
    o.order_date,
    o.order_details,
    o.total_order_cost,
    c.first_name
FROM orders AS o
JOIN customers AS c
    ON o.cust_id = c.id
WHERE c.first_name IN ('Jill', 'Eva')
ORDER BY c.id ASC;
| order_date | order_details | total_order_cost | first_name |
| ---------- | ------------- | ---------------- | ---------- |
| 4/19/2019  | Suit          | 150              | Jill       |
| 2/1/2019   | Coat          | 25               | Jill       |
| 3/10/2019  | Shoes         | 80               | Jill       |

/*Find the details of each customer regardless of whether the customer made an order. 
Output the customer's first name, last name, and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items.
Sort records based on the customer's first name and the order details in ascending order.*/
SELECT 
    c.first_name,
    c.last_name,
    c.city,
    o.order_details
FROM customers AS c 
LEFT JOIN orders AS o 
    ON c.id = o.cust_id;
-- Need to watch when joining on ID fields its not always ID to ID 
| first_name | last_name | city          | order_details |
| ---------- | --------- | ------------- | ------------- |
| John       | Joseph    | San Francisco |               |
| Jill       | Michael   | Austin        | Coat          |
| Jill       | Michael   | Austin        | Shoes         |
| Jill       | Michael   | Austin        | Suit          |
