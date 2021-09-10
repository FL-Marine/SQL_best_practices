# SQL_best_practices
Personal SQL best practices README

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

# RANK, DENSE_RANK, ROW_NUMBER
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
