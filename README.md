# SQL_best_practices
Personal SQL best practices README

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
