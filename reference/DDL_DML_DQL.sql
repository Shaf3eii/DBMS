------------------------------------------------------------
-- DDL (Data Definition Language)
------------------------------------------------------------
-- DDL (Data Definition Language) is used to define and modify 
-- the structure of database objects such as tables, columns, and schemas. 
-- It deals with how the data is stored, not the data itself.
------------------------------------------------------------

-- Create a new table
-- This command creates a new table named 'Employees' with specific columns.
-- The 'Eid' is a primary Key, 'Ename' cannot be NULL, and 'Eadd' + 'HireDate' have default values.
CREATE TABLE Employees (
  Eid INT PRIMARY KEY,
  Ename VARCHAR(20) NOT NULL,
  Eage TINYINT,
  Eadd VARCHAR(50) DEFAULT 'Cairo',
  HireDate DATE DEFAULT GETDATE(),
  DepNum INT
);

-- Add a new column
-- Adds a new column named 'Salary' to the Employees table.
ALTER TABLE Employees ADD Salary INT;

-- Modify column data type
-- Changes the data type of 'Salary' from INT to BIGINT.
-- You can change to a larger data type freely, 
-- but reducing the size (BIGINT → INT) may cause data loss.
ALTER TABLE Employees ALTER COLUMN Salary BIGINT;

-- Delete a column
-- Removes the 'Salary' column from the table.
ALTER TABLE Employees DROP COLUMN Salary;

-- Delete the entire table
-- Completely removes the table structure and its data from the database.
DROP TABLE Employees;



------------------------------------------------------------
-- DML (Data Manipulation Language)
------------------------------------------------------------
-- DML (Data Manipulation Language) is used to manage the data 
-- stored inside tables. 
-- It deals with inserting, updating, and deleting data records.
------------------------------------------------------------

-- Insert a single row
-- Inserts one record into the Employees table.
INSERT INTO Employees VALUES (1, 'Ali', NULL, 'Alex', '2021-01-01', NULL);

-- Insert using column names
-- Inserts a record specifying which columns to fill.
INSERT INTO Employees (Ename, Eid) VALUES ('Eman', 2);

-- Insert multiple rows
-- Adds several rows at once.
INSERT INTO Employees (Ename, Eid)
VALUES ('Sayed', 3), ('Fathi', 4), ('Tarek', 5);

-- Update a row
-- Updates the name of the employee with Eid = 1.
UPDATE Employees SET Ename = 'Omar' WHERE Eid = 1;

-- Increase all ages by 1
-- Adds 1 to every value in the 'Eage' column.
UPDATE Employees SET Eage += 1;

-- Delete a specific row
-- Removes a record where Eid = 1.
DELETE FROM Employees WHERE Eid = 1;



------------------------------------------------------------
-- DQL (Data Query Language)
------------------------------------------------------------
-- DQL (Data Query Language) is used to retrieve data from 
-- database tables without modifying it. 
-- The main command used is 'SELECT'.
------------------------------------------------------------

-- Select all columns
-- Retrieves every column from the Employees table.
SELECT * FROM Employees;

-- Select specific columns
-- Retrieves Eid, Eage, and Ename for employees where Eid > 2, sorted by name.
SELECT Eid, Eage, Ename FROM Employees WHERE Eid > 2 ORDER BY Ename;

-- Handle NULL values
-- Displays the full name only for students whose last name is not NULL.
SELECT St_Fname + ' ' + St_Lname AS [Full Name]
FROM Student
WHERE St_Lname IS NOT NULL;

-- Remove duplicates
-- Shows unique first names from the Student table.
SELECT DISTINCT St_Fname FROM Student;

-- Use IN instead of multiple ORs
-- Retrieves students living in Mansoura or Alex.
SELECT * FROM Student
WHERE St_Address IN ('Mansoura', 'Alex');

-- Filter by range
-- Retrieves students whose age is between 23 and 25 (inclusive).
SELECT * FROM Student WHERE St_Age BETWEEN 23 AND 25;

