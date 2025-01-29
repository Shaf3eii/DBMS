***
## 1-SQL 
- **What is SQL?**
	- **SQL (Structured Query Language)** is a standard language used to interact with databases. It has three main components:
		- **DDL (Data Definition Language)**: Defines the database structure (`e.g`, CREATE TABLE).
		- **DML (Data Manipulation Language)**: Manages data (`e.g`, INSERT, UPDATE, DELETE).
		- **DCL (Data Control Language)**: Controls access (`e.g`, GRANT, REVOKE).
		- **TCL (Transaction Control Language)**: (`e.g`, Commit, Rollback).
		- **DQL (Data Query Language)**: (`e.g`, Select).
***
## 2-Data types
![[Pasted image 20250129205046.png]]
- The Difference between **`char`** and **`varchar`**:
	- `char`:
	    - `char` is a fixed-length character data type.
	    - When you define a column as `char` , you specify a fixed length for the data it can hold.
	    - It pads the shorter strings with spaces to reach the defined length.
	    - `e.g`, if you define a `char(10)` column and store "hello" in it, it will be stored as "hello     " (with five spaces at the end to fill the length).
	- `varchar`:
	    - `varchar`is a variable-length character data type.
	    - When you define a column as `varchar`, it only stores the actual length of the string plus one or two bytes (depending on the database system) to store the length information.
	    - It does not pad the shorter strings with spaces.
	    - `e.g`, if you define a `varchar(10)` column and store "hello" in it, it will be stored as "hello".
	- **Summary:**
		- `char` is more efficient for fixed-length data, where the length of the string is consistent.
		- `varchar` is more flexible and efficient for variable-length data, as it only uses storage space proportional to the actual length of the data stored.
		- `varchar` is generally preferred for most situations where the length of the strings can vary.
***
## 3-SQL Commands 
### 1. DDL
- **CREATE:**
	- Create database or its objects (table, index, function, views, store procedure, and triggers).
	- *Syntax:*
```
CREATE TABLE table_name (column1 datatype, column2 datatype);
```
- **DROP:**
	- Delete objects from the database
	- *Syntax:*
```
DROP TABLE table_name;
```
- **ALTER:**
	- Alter the structure of the database
	- *Syntax:*
```
ALTER TABLE table_name ADD Column column_name data_type;
```
- **TRUNCATE:**
	- Remove all records from a table, including all spaces allocated for the records are removed
	- *Syntax:*
```
TRUNCATE TABLE table_name;
```
- **COMMENT:**
	- Add comments to the data dictionary
	- *Syntax:*
```
COMMENT 'comment_text' ON TABLE table_name;
```
- **RENAME:**
	- Rename an object existing in the database
	- *Syntax:*
```
RENAME TABLE old_table_name TO new_table_name;
```

### 2. DML
- **INSERT:**
	- Insert data into a table
	- *Syntax:*
```
INSERT INTO table_name (column1, column2, ....) VALUES (value1, value2, ....);
```
- **UPDATE:**
	- Update existing data within a table
	- *Syntax:*
```
UPDATE table_name SET column1 = value1, column2 = value2 
	WHERE condition;
```
- **DELETE:**
	- Delete records from a database table
	- *Syntax:*
```
DELETE FROM table_name 
	WHERE condition;
```

### 3. DCL
- **GRANT:**
	- Assigns new privileges to a user account, allowing access to specific database objects, actions, or functions.
	- *Syntax:*
```
GRANT privilege_type [(column_list)] ON [object_type] object_name TO user [WITH GRANT OPTION];
```
- **REVOKE:**
	- Removes previously granted privileges from a user account, taking away their access to certain database objects or actions.
	- *Syntax:*
```
REVOKE [GRANT OPTION FOR] privilege_type [(column_list)] ON [object_type] object_name FROM user [CASCADE];
```

### 4. TCL
- **BEGIN TRANSACTION:**
	- Starts a new transaction
	- *Syntax:*
```
BEGIN TRANSACTION [transaction_name];
```
- **COMMIT:**
	- Saves all changes made during the transaction
	- *Syntax:*
```
COMMIT;
```
- **ROLLBACK:**
	- Undoes all changes made during the transaction
	- *Syntax:*
```
ROLLBACK;
```
- **SAVEPOINT:**
	- Creates a savepoint within the current transaction
	- *Syntax:*
```
SAVEPOINT savepoint_name;
```

### 5. DQL
- **SELECT:**
	- It is used to retrieve data from the database
	- *Syntax:*
```
SELECT column1, column2, ...FROM table_name WHERE condition;
```
***
## 4-SQL Joins
- Four different types: `INNER JOIN, OUTER JOIN, SELF JOIN, CROSS JOIN`.
- **SQL Joins** clause use when select records rows from two or more tables from the database. It's depend on certain columns from two table. Matching columns are evaluate and if predicated TRUE return a records set data in specified format.![[Pasted image 20250129212854.png]]
- **INNER JOIN:**
	- Combines data from two tables, ensures that only matching rows from both tables are included.
	- *Syntax:*
```
SELECT StudentCourse.COURSE_ID, Student.NAME, Student.AGE FROM Student  
INNER JOIN StudentCourse  
ON Student.ROLL_NO = StudentCourse.ROLL_NO;
```
- **LEFT JOIN:**
	- Returns all the rows of the table on the left side of the join and matches rows for the table on the right side of the join.
	- *Syntax:*
```
SELECT table1.column1,table1.column2,table2.column1,....  
FROM table1   
LEFT JOIN table2  
ON table1.matching_column = table2.matching_column;
```
- **RIGHT JOIN:**
	- Returns all the rows of the table on the right side of the join and matches rows for the table on the left side of the join.
	- *Syntax:*
```
SELECT table1.column1,table1.column2,table2.column1,....  
FROM table1   
RIGHT JOIN table2  
ON table1.matching_column = table2.matching_column;
```
- **FULL JOIN:**
	- combining results of both **`LEFT JOIN`** and **`RIGHT JOIN`**. The result-set will contain all the rows from both tables.
	- *Syntax:*
```
SELECT table1.column1,table1.column2,table2.column1,....  
FROM table1   
FULL JOIN table2  
ON table1.matching_column = table2.matching_column;
```
***
## Advance SQL
- **GROUP BY:**
	- **`SQL GROUP BY`** clause use with SELECT statement for fetching data (result groups) according to a matching values for one or more columns.
	- **`SQL HAVING Clause`** statement used with GROUP BY clause for filtering the GROUP BY clause result set data allow only group of result whose HAVING clause condition TRUE.
	- *Syntax:*
```
SELECT column_name1, column_name2, aggregate_function(column_name), ....
    FROM table_name
    [ WHERE condition ]
    GROUP BY column_name1, ...;
	HAVING condition;
```
- **ORDER BY:**
	- **`SQL ORDER BY`** Clause used to sorting SQL result set either ascending or descending order.
	- *Syntax:*
```
SELECT 
    column_name1, column_name2, ...
    FROM table_name
    [ WHERE condition ]
    ORDER BY column_name1, column_name2 [ ASC | DESC ];
```
- **Alias:**
	- temporary names given to table or column for the purpose of a specific SQL query.
	- *Syntax:*
```
SELECT
    column_name [AS alias_column_name], aggregate_function(column_name) [AS alias_name], ...
    FROM table_name [ alias_table_name ];
```
