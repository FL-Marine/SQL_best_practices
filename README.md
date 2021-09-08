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

![image](https://user-images.githubusercontent.com/74512335/132511293-460dc702-4f75-4f8f-bc7b-60eeba92d872.png)

**Regular Expressions Cheat Sheet** -https://cheatography.com/davechild/cheat-sheets/regular-expressions/

**PostgreSQL REGEXP_REPLACE Function** - https://www.postgresqltutorial.com/regexp_replace/

**How to use regular expressions (RegEx) in SQL Server to generate randomized test data** - https://solutioncenter.apexsql.com/using-regular-expressions-regex-in-sql-server-to-generate-randomized-test-data/
