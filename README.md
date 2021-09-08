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
