------------------------------------------------------------
-- JOINS
-- Joins are used to combine rows from two or more tables 
-- based on a related column between them.
-- Syntax: SELECT columns FROM TableA [JOIN TYPE] TableB ON condition;
------------------------------------------------------------
-- CROSS JOIN
-- Produces the Cartesian product of both tables 
-- (every row from the first table combined with every row from the second table).
SELECT st_fname, dept_name
FROM student CROSS JOIN department;
-- If Student has 3 rows and Department has 2 rows, result = 3 × 2 = 6 rows.

------------------------------------------------------------
-- INNER JOIN (also called EQUI JOIN)
-- Returns only the rows where the join condition is true.
SELECT st_fname, dept_name
FROM student s INNER JOIN department d
ON s.dept_id = d.dept_id;
-- | st_fname  | dept_name |
-- |-----------|-----------|
-- | Ali       | CS        |
-- | Eman      | IS        |
-- | Omar      | IT        |

------------------------------------------------------------
-- LEFT OUTER JOIN
-- Returns all rows from the LEFT table and matching rows from the RIGHT table.
-- Non-matching rows from the RIGHT table are filled with NULLs.
SELECT st_fname, dept_name
FROM student s LEFT OUTER JOIN department d
ON s.dept_id = d.dept_id;
-- Shows all students even if they don’t belong to any department.

------------------------------------------------------------
-- RIGHT OUTER JOIN
-- Returns all rows from the RIGHT table and matching rows from the LEFT table.

SELECT st_fname, dept_name
FROM student s RIGHT OUTER JOIN department d
ON s.dept_id = d.dept_id;
-- Shows all departments even if they have no students.

------------------------------------------------------------
--  FULL OUTER JOIN
-- Combines results of both LEFT and RIGHT joins.
-- Shows all rows from both tables with NULLs for missing matches.
SELECT st_fname, dept_name
FROM student s FULL OUTER JOIN department d
ON s.dept_id = d.dept_id;


------------------------------------------------------------
--  SELF JOIN
-- A join where a table is joined with itself.
-- Useful for hierarchical data (employees and their managers).
SELECT s.st_fname AS Student, s1.st_fname AS Supervisor
FROM student s INNER JOIN student s1
ON s1.st_id = s.st_super;

-- Example:
-- | Student  | Supervisor |
-- |----------|------------|
-- | Omar     | Ali        |
-- | Eman     | Ahmed      |


------------------------------------------------------------
-- AGGREGATE FUNCTIONS
-- Aggregate functions perform calculations on multiple rows 
-- and return a single value (MIN, MAX, SUM, AVG, COUNT).
SELECT COUNT(*) AS TotalStudents FROM student;
SELECT SUM(salary) AS TotalSalary FROM instructor;
SELECT AVG(salary) AS AvgSalary FROM instructor;

------------------------------------------------------------
-- GROUP BY
-- Groups rows that have the same values into summary rows.
SELECT dept_id, COUNT(st_id) AS StudentsCount
FROM student
GROUP BY dept_id;
-- | dept_id  | StudentsCount  |
-- |----------|----------------|
-- | 1        | 10             |
-- | 2        | 7              |

------------------------------------------------------------
--  GROUP BY with JOIN
SELECT d.dept_id, d.dept_name, COUNT(s.st_id) AS StudentsCount
FROM student s
JOIN department d ON s.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name;

------------------------------------------------------------
-- HAVING Clause
-- Used to filter groups after aggregation (like WHERE for grouped data).

SELECT dept_id, COUNT(st_id) AS StudentsCount
FROM student
GROUP BY dept_id
HAVING COUNT(st_id) > 5;
-- Only shows departments that have more than 5 students.

------------------------------------------------------------
-- SUBQUERIES
-- A query inside another query.
-- Used for comparison, filtering, or computed values.

-- Example 1: Compare with aggregate
SELECT *
FROM student
WHERE st_age > (SELECT AVG(st_age) FROM student);
-- Shows students older than the average student age.

-- Example 2: Subquery in SELECT
SELECT *, (SELECT COUNT(st_id) FROM student) AS TotalStudents
FROM student;
-- Adds a column showing the total number of students.

-- Example 3: EXISTS
SELECT *
FROM department d
WHERE EXISTS (SELECT * FROM student s WHERE s.dept_id = d.dept_id);
--  Returns departments that have at least one student.

-- Note:
-- JOIN is usually faster than subquery because the optimizer rewrites it internally.

------------------------------------------------------------
--  UNION Family

-- UNION ALL keeps duplicates
SELECT St_Fname FROM Student
UNION ALL
SELECT Ins_Name FROM Instructor;

-- UNION removes duplicates
SELECT St_Fname FROM Student
UNION
SELECT Ins_Name FROM Instructor;

-- EXCEPT returns rows from the first query not in the second
SELECT St_Fname FROM Student
EXCEPT
SELECT Ins_Name FROM Instructor;

-- INTERSECT returns common rows between both queries
SELECT St_Fname FROM Student
INTERSECT
SELECT Ins_Name FROM Instructor;


------------------------------------------------------------
-- TOP Clause
-- TOP(n) → returns only the first n rows of the query result.
-- Get top 3 rows
SELECT TOP 3 St_Fname
FROM Student;

-- To get from bottom, use ORDER BY DESC
SELECT TOP 3 St_Fname
FROM Student
ORDER BY St_Age DESC;


------------------------------------------------------------
select st_fname + ' ' + st_lname as fullname
from Student
order by fullname

select st_fname + ' ' + st_lname as fullname
from Student
where fullname = 'ahmed ali'
-- The first query is correct because You can order by a column alias created in the SELECT clause, 
-- but you cannot use it in the WHERE clause since WHERE executes first.

------------------------------------------------------------
-- First to excute in query
-- 1. from
-- 2. join
-- 3. on
-- 4. where
-- 5. group by
-- 6. having
-- 7. select
-- 8. order by
-- 9. top
-- 10. distinct
------------------------------------------------------------
-- isnull vs coalesce
-- 'ISNULL' replaces NULL with a specified value.
SELECT ISNULL(St_Fname, 'Unknown')
FROM Student;

-- 'COALESCE' returns the first non-null value among multiple expressions.
SELECT COALESCE(St_Fname, St_Lname, St_Address, 'No Data')
FROM Student;

------------------------------------------------------------
-- String Concatenation and Date Formatting 

-- We can combine (concatenate) multiple string columns using +.
-- However, if any column is NULL, the result becomes NULL.
-- So we use ISNULL() to replace NULL with an empty string before concatenation.
SELECT ISNULL(St_Fname, '') + ' ' + ISNULL(CONVERT(VARCHAR(20), St_Age), '')
FROM Student;

-- Concat Function
-- CONCAT() combines multiple strings and automatically handles NULL values by treating them as empty strings.
SELECT CONCAT(St_Fname, ' ', St_Age)
FROM Student;


-- Convert Function
-- CONVERT() changes a value from one data type to another.
-- It’s often used to convert a datetime value to a formatted varchar string.
SELECT CONVERT(VARCHAR(20), GETDATE(), 101);  -- mm/dd/yyyy
SELECT CONVERT(VARCHAR(20), GETDATE(), 102);  -- yyyy.mm.dd
SELECT CONVERT(VARCHAR(20), GETDATE(), 103);  -- dd/mm/yyyy
SELECT CONVERT(VARCHAR(20), GETDATE(), 104);  -- dd.mm.yyyy

-- Cast Function
-- CAST() is similar to CONVERT(), but simpler, it just changes data type without any style formatting.
SELECT CAST(GETDATE() AS VARCHAR(20)); -- Oct 16 2025 06:30PM

-- Format Function
-- FORMAT() provides custom date/time formatting using pattern strings.
SELECT FORMAT(GETDATE(), 'dd MM yyyy');             -- 16 10 2025
SELECT FORMAT(GETDATE(), 'dddd MMMM yyyy');         -- Thursday October 2025
SELECT FORMAT(GETDATE(), 'ddd MMM yy');             -- Thu Oct 25
SELECT FORMAT(GETDATE(), 'hh:mm:ss');               -- 06:45:20
SELECT FORMAT(GETDATE(), 'dd MM yyyy hh:mm:ss');    -- 16 10 2025 06:45:20
SELECT FORMAT(GETDATE(), 'dd MM yyyy hh:mm:ss tt'); -- includes AM/PM


-- Month() Function
-- MONTH() extracts the month number from a date. MONTH(date) → returns month number (1–12)
SELECT MONTH(GETDATE());

------------------------------------------------------------
-- Insert based on SELECT
-- You can insert data from one table into another existing table using a SELECT statement
INSERT INTO table2
SELECT st_id, st_fname 
FROM Student;
-- When you want to copy specific columns or filtered data from one table into another


------------------------------------------------------------
-- HAVING without GROUP BY
-- You can use HAVING without GROUP BY if your SELECT statement contains an aggregate function.
SELECT SUM(salary)
FROM Instructor
HAVING COUNT(ins_id) < 100;

