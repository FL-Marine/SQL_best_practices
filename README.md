# SQL_best_practices
Personal SQL best practices README

## SQL Cheat Sheets
- https://media-exp1.licdn.com/dms/document/C561FAQFkX-D576FMpA/feedshare-document-pdf-analyzed/0/1625332666646?e=1632171600&v=beta&t=yWPQDDA9vs3q39DAHiNwXDGZsp-Xi0rneYYYWG3aj_Y
- https://media-exp1.licdn.com/dms/document/C561FAQHWGJnxqRzDaA/feedshare-document-pdf-analyzed/0/1626842110988?e=1632171600&v=beta&t=gnAoYN4cRQ_-VWITmveb8gU_RNJOAZwefoOTywaLLBc
- https://media-exp1.licdn.com/dms/document/C561FAQGy7n10Hq758g/feedshare-document-pdf-analyzed/0/1630387462164?e=1632171600&v=beta&t=rdYwYoImSK_5SxlX48H9BSGJPNuYVZ561wG8JZsXyIU

## Nandita's advice fot how to attack SQL projects/questions
**Nandita:** "So when I started sql what I used to do was create a sample table in my notes and create the output table I’m envisioning and then work it out in a query. Almost like reverse engineer from what I want as the outcome to write the query. It takes time to explore options and ideas with both the output and the queries, but when I do those conceptually rather than theoretically, they got etched in my brain since I was always able to associate them back to specific  scenarios! If that helps :blush: "

**Me:** "Did you hand write ?"

**Nandita:** Yep! And hand drew tables lol
"When I say tables I meant more like a entity relationship of the tables and what columns each table had with a 3-5 example data to make it easier"

**Me:** "What about joins ?"

**Nandita:** "So I would first understand and write down all the tables I need for my analysis and then sort of mark the relationship on paper and what keys help in join etc before you start doing queries."

**Me:** "So my case it would be very beneficial to your draw everything out and make the connections since I don’t have a visual ERD"

**Nandita:** " Yep! After a few times your muscle memory will just work wonders in recollecting these without having to take a pen and paper approach...I’m a very visual learner, so this helped to begin understanding and connecting dots"

**Nandita:** "I made like a main table Google doc With all of the tables and possible joinas but even that didn’t really help me"

**Nandita:** "I would say don’t try to do this pen to paper with allll the tables in the database.. begin with your use case / analysis you’re planning to do.. explore the datasets and figure out the tables you need and do this paper ERD to see how to interact with these tables to effectively get the output you desire."

## Checking Column Types
``` sql
SELECT
  table_name,
  column_name,
  data_type
FROM information_schema.columns
WHERE table_name = 'customer_orders';
```
**Result:**
| table\_name      | column\_name | data\_type                  |
| ---------------- | ------------ | --------------------------- |
| customer\_orders | order\_id    | integer                     |
| customer\_orders | customer\_id | integer                     |
| customer\_orders | pizza\_id    | integer                     |
| customer\_orders | exclusions   | character varying           |
| customer\_orders | extras       | character varying           |
| customer\_orders | order\_time  | timestamp without time zone |

- It is vital to check and know what data types are in the database columns. 
- Data types maybe listed incorrectly which will cause issues later on and will prevent a proper analysis on the data.
- **This is to be considered the first step prior to any data cleaning.**

## The Big 6 of SQL Querying
![image](https://user-images.githubusercontent.com/74512335/135074919-6deba6b6-2e59-4a3b-9d42-3bd0cd02aa62.png)

1) Start with SELECT and FROM. Pull some data. See? Easy!

2) Next, add a WHERE condition to filter which rows you want returned in your result set.

3) Then, add a GROUP BY to create segments in your data.
(As you gain experience, this will become POWERFUL).

4) Add a HAVING clause to return only the groups that match certain group-level filtering criteria. This is like WHERE, but for groups.

5) Finally, apply an ORDER BY to specify how your records should be sorted. The default order is ascending, and you can modify it with DESC to display your largest values at the top.

John Pauler LinkedIn post: https://www.linkedin.com/posts/johnpauler_mavenquicktips-sql-data-activity-6847870369701916672-aWDO

## Joins - Go thru Danny's course to understand joining multiple tables
**Danny:** "You need to profile both columns to see what values are missing or duplicates in each before deciding what you want to do"

**Me:** "by profile columns you mean compare them?"

**Danny:** "Yes - look at counts of each join column Use the magic CTE combo" 
```sql
With cte_counts as (
  Select
    column,
    count(*) as counts
  from
    table
  group by
    1
)
select
  counts,
  count(distinct column) as ids
from
  cte_counts
group by
  1
order by
  1
);
```

![image](https://user-images.githubusercontent.com/74512335/134607657-c3b15faf-bcc7-43a1-af5d-04b6a28c61d1.png)

### Maven Analytics Post
```sql
SELECT
courses.title AS online_course_title,
instructors.name AS instructor_name
FROM courses
INNER JOIN instructors
ON courses.instructor_id = instructors.instructor_id
```

1) 'courses' is the first table named in the FROM, making it our 'LEFT' table. Other tables will be added 'to the RIGHT'.

2) 'instructors' is the table named in the JOIN, making it the 'RIGHT' table in this example.

3) The ON clause(last line), specifies HOW to JOIN the tables. In this case, the JOIN will match instructor_id values from the two tables to associate the records.

4) When we use an INNER JOIN, as written above, the result is limited to records from both tables where there is a match using instructor_id, and all unmatching records from either table will be removed.

5) If we had used LEFT JOIN instead, we would return all of the records from our LEFT table, plus any matching records from our RIGHT table. LEFT JOIN preserves all LEFT table records.

6) If we had used RIGHT JOIN, we would return all records from our RIGHT table, plus matching records from our LEFT table. RIGHT JOIN preserves all RIGHT table records.

Link: https://www.linkedin.com/posts/maven-analytics_sql-data-mavenquicktips-activity-6847862520548524032-b-G3

## Changing one data type to another
- CAST changes one data type to another 
- :: is just a shortcut for cast
- instead of CAST(timestamp as string) do timestamp::string
- It's much more readable and preferred compared to using cast

**Stack Overflow link** - https://discordapp.com/channels/873717142888022047/873731632664817664/884895199749353493

## REGEXP_REPLACE
- REGEXP_REPLACE(source, pattern, replacement_string,[, flags])  
- ' to specify the regex
- '' repalce anything with blank
- 'g' means global match and removes all matches
- Use NULLIF to handle blank string '' in conjuction with REGEXP_REPLACE - https://docs.microsoft.com/en-us/sql/t-sql/language-elements/nullif-transact-sql?view=sql-server-ver15

![image](https://user-images.githubusercontent.com/74512335/132511293-460dc702-4f75-4f8f-bc7b-60eeba92d872.png)

**Regular Expressions Cheat Sheet** -https://cheatography.com/davechild/cheat-sheets/regular-expressions/

**PostgreSQL REGEXP_REPLACE Function** - https://www.postgresqltutorial.com/regexp_replace/

**How to use regular expressions (RegEx) in SQL Server to generate randomized test data** - https://solutioncenter.apexsql.com/using-regular-expressions-regex-in-sql-server-to-generate-randomized-test-data/

# Window Functions
- Learning Window Functions example post by John Pauler https://www.linkedin.com/posts/johnpauler_sql-data-analysis-activity-6845329904163176448-sMWg

**RANK, DENSE_RANK, ROW_NUMBER**
- The RANK function is used to retrieve ranked rows based on the condition of the ORDER BY clause.
- The DENSE_RANK function is similar to RANK function however the DENSE_RANK function does not skip any ranks if there is a tie between the ranks of the preceding records. 
- Unlike the RANK and DENSE_RANK functions, the ROW_NUMBER function simply returns the row number of the sorted records starting with 1.
https://codingsight.com/similarities-and-differences-among-rank-dense_rank-and-row_number-functions/

# SQL Bits & Bytes- Best practices for efficient querying
 
⭐ Start EDA with describing the dataset i.e., DESCRIBE, to show table structure

⭐ Preferably select individual fields instead of selecting all fields with *

⭐ If using select *, please use LIMIT /TOP to restrict the result set (especially useful if the dataset size is large)

⭐ Even if selecting individual columns, use of TOP/LIMIT is helpful for better performance

⭐ Know SQL logical order of operations i.e. 1) FROM 2)WHERE 3)GROUP BY 4)HAVING 5)SELECT 6)ORDER BY 7)LIMIT

⭐ Make use of column aliases when using the feature engineering concept

⭐ Make use of table aliases when querying multiple tables

⭐ Join tables using the ON keyword (ANSI-Standard) instead of WHERE clause

⭐ Filter with WHERE (as applicable) before HAVING

⭐ Use EXISTS/NOT EXISTS instead of IN/NOT IN

⭐ WHERE/HAVING/GROUP BY cannot have column aliases (due to logical order of operations)

⭐ Organize your query with CTE

⭐ Window functions are very helpful in finding moving averages, identifying duplicate rows, finding ranking etc.

⭐ Indent and comment your code for easy readability

⭐ GROUP BY and ORDER BY both allow column numbers, however use of column names is recommended for easy readability/scalability

⭐ Data Analysis is 99% querying, meaning you will use only SELECT statement. However, it’s good to have knowledge of DML/ TCL / DDL concepts.
 
 Pooja Chavan post https://www.linkedin.com/posts/thepoojachavan_dataanalysis-sql-dataanalytics-activity-6842097607553236992-UwBV
 
# Use temp tables for complex SQL queries.
There are three advantages:
1. intermediate steps which show the evolution of the data.
2. Allows easy debugging and QA'ing of steps, since its broken into small chunks.
3. Optimizes large queries, and decreases run times.

In a complex query with multiple sub-queries, it can be hard to know the output.

And if your query involves operations like UNION and INTERSECT, it will make it complex and slow very quickly.

It is not a sign of skill to create a single massive unreadable query with multiple sub queries. It just causes data governance and data quality issues in the long run, and makes reporting difficult.

So, break down complex queries and create multiple temporary tables. Then join them together gradually as you go along.

It'll make your life easier.

Matthew Blasa post - https://www.linkedin.com/posts/mblasa_sql-datascience-data-activity-6844030095506620416-8hDY

**Danny Ma on temp tables**
- Use temp tables only when you need to re-index or re-use the data later
- You eat the cost of IO for each temp table
- Materialized view is similar concept - but you eat the one off cost of creating it, and updating it each time data changes
- CTEs are usually fine for what most people need to do - abuse of temp tables is not good either

# Making Lines more readable
- It’s best practice and much more readable to place each field on its one line
```sql
select 
  reason_code
  , blah_blah
  , sum(blah)       as sum_of_blah
group by 
  1
  , 2
  ```
  Charlie Han example - https://hastebin.com/etifaroqiy.rust

- When you have windows functions or agg functions, it’s good to put them on their own line
- Like in their own space
- Visually much less taxing on the brain
```sql
final as (

    select [distinct]
        my_data.field_1,
        my_data.field_2,
        my_data.field_3,

        -- use line breaks to visually separate calculations into blocks
        case
            when my_data.cancellation_date is null
                and my_data.expiration_date is not null
                then expiration_date
            when my_data.cancellation_date is null
                then my_data.start_date + 7
            else my_data.cancellation_date
        end as cancellation_date,

        some_cte_agg.total_field_4,
        some_cte_agg.max_field_5

    from my_data
    left join some_cte_agg  
        on my_data.id = some_cte_agg.id
    where my_data.field_1 = 'abc'
        and (
            my_data.field_2 = 'def' or
            my_data.field_2 = 'ghi'
        )
    having count(*) > 1

)

select * from final
```

Per dbt: data base tool
- DO NOT OPTIMIZE FOR A SMALLER NUMBER OF LINES OF CODE. NEWLINES ARE CHEAP, BRAIN TIME IS EXPENSIVE
- ^ Rather have more lines of code that is readable then fewer lines that make it difficult to understand
- It’s expensive on your brain to read bad code
- Too much time reading bad code is expensive

# SQL Subqueries vs Temporary Tables vs CTEs
John Pauler's full Linkedin post - https://www.linkedin.com/posts/johnpauler_sql-data-analysis-activity-6846753804105379840-5yiw
Maven Analytics full blog post - https://www.mavenanalytics.io/blog/sql-subqueries-temporary-tables-ctes?utm_source=linkedin&utm_campaign=ctesubqueries_jp20210923

They each have pros and cons. Here's the short of it...

👉 SUBQUERIES 👈
+ the advantage is they can be really quick to write

- one disadvantage here is when you get more complex and start nesting subqueries, it gets hard to read (example in blog post)

- another disadvantage is if your data gets huge, you have fewer options to performance optimize it

👉 CTEs 👈
+ these are great if you've got long code and want to create a new data set early on which you will reference multiple times

+ for complex stuff, this tends to make your code easier to follow than gross nested subqueries

- the downisde is, CTEs don't support indexing, so if your manufactured data gets really huge, you can't index it to performance optimize your query

👉 TEMPORARY TABLES 👈
+ these have the same reusability and readability advantages of CTEs over subqueries

+ the additional advantage over CTEs is that you can create an index on a temporary table. So if you're working with huge data sets and need to do some performance optimization, you have that option

- the downside some would argue here is creating the temporary table is more cumbersome code (not too bad though)

## Query Processing Order
SELECT
i.name AS instructor_name,
COUNT(c.course_id) AS courses_taught
FROM online_courses c
INNER JOIN instructors i
ON c.instructor_id = i.instructor_id
WHERE c.topic IN('SQL','Tableau','Machine Learning')
GROUP BY i.name
HAVING COUNT(c.course_id) > 2
ORDER BY courses_taught DESC
LIMIT 10;

Here's how the query will process...

1) FROM and JOIN -- first, the tables are identified

2) WHERE -- next, rows are filtered out (using course topic)

3) GROUP BY -- then, the data is grouped (instructor name)

4) HAVING -- next, groups are filtered out (< 2 courses)

5) SELECT -- next, the two columns are selected

6) ORDER BY -- then, results are ranked (most courses first)

7) LIMIT -- finally, results are limited (top 10 only)

Understanding SQL execution order is important...

This helps you write more efficient queries, and gives you a better understand of what's happening on the back-end.

It explains why you can use the alias courses_taught in the ORDER BY but you can't use it in the HAVING (because it is named in the SELECT, after the HAVING has executed).

Maven Analytics LinkedIn post: https://www.linkedin.com/posts/maven-analytics_mavenquicktips-sql-analysis-activity-6839889934048923648-xbeU

## Exploring unfamilar Tables
1. Find the number of rows in the table:
-- quickly understand how large your data set is

SELECT COUNT(*) AS number_of_rows
FROM tablename;

2. Find the date range covered in the table:
-- helps frame analysis and understand limitations

SELECT
MIN(created_at) AS first_created_at,
MAX(created_at) AS last_created_at
FROM tablename;

3. Learn which values are most common in a column:
-- easy way to start understanding specific columns

SELECT
columnname,
COUNT(*) AS times_repeated
FROM tablename
GROUP BY columnname
ORDER BY times_repeated DESC;

4. See what trends look like:
-- is record-writing volume steady / decreasing / increasing?
-- example shows date-level. Do the same for months, etc.

SELECT
DATE(created_at) AS created_date,
COUNT(*) AS records_on_date
FROM tablename
GROUP BY DATE(created_at)
ORDER BY DATE(created_at);

5. Return all columns, all records, to view the data:
-- do a visual inspection of the actual table contents

SELECT *
FROM tablename
LIMIT 1000;
-- syntax varies (MySQL = LIMIT, SQL Server = TOP, etc)

Maven Analytics LinkedIn post: https://www.linkedin.com/posts/maven-analytics_mavenquicktips-sql-data-activity-6847137743961673728-9-iD

## Entity Relationship Diagrams Model aka Entity Relationship Diagrams
Create a ERDM (Entity Relationship Diagrams Model) before you make SQL projects.

Here's why:

✔️Clear model. You get to see how tables relate to each other. It's a plan before you create the query, and saves you time.

✔️Recognize errors. You can use it to find why that table ain't joining. Without having to waste time using trial and error.

✔️Helps people viewing your SQL project. Without an ERDM, we don't know the relationships between the tables nor the structure of your database. It lacks context.

✔️Relationships. An ERDM helps show the nature of relationships between tables at a high level. Helps when you are doing data modeling project.

So if you have more than 3 tables, create an ERD.

Yes its long process.

But by the end, you have a sense of the relationships and structure in your head.

The biggest benefit?

It helps interviewers understand what you did in your SQL project, and helps you walk them through it.

![image](https://user-images.githubusercontent.com/74512335/135329348-559ba51e-3b83-4983-a153-cd07630010b7.png)

Matthew Blasa LinkedIn Post: https://www.linkedin.com/posts/mblasa_sql-data-dataanalysis-activity-6848986642703806464-oSd0

53:00 minute mark ERDM explanation: https://www.youtube.com/watch?v=6wx6oZxObhs
