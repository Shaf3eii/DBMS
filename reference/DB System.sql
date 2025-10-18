-- Sparse Columns
-- Sparse columns are designed to efficiently store NULL values in SQL Server.
-- They take no space if they are NULL but require extra 4 bytes if they contain data.
CREATE TABLE Survey (
    survey_nbr INT NOT NULL PRIMARY KEY,
    survey_desc VARCHAR(30),
    survey_info1 VARCHAR(30) SPARSE NULL
);
/*
Pros:
NULL values take no storage space.
Can define up to 30,000 columns.
Works with filtered indexes efficiently.

Cons:
Non-null values use 4 extra bytes.
Not supported for some data types (TEXT, IMAGE, NTEXT, etc.).
Cannot have default values or be computed columns.
*/


------------------------------------------------------------
-- Database Metadata Functions
-- SQL Server provides system functions and views to get metadata info.
SELECT DB_ID();
SELECT DB_NAME();
EXEC sys.sp_databases;
SELECT * FROM sys.database_files;
SELECT * FROM sys.databases;
SELECT * FROM sys.tables;
SELECT * FROM sys.columns;
SELECT * FROM sys.schemas;
-- These commands help you explore database structure, files, and schema objects.

sp_help;            -- Info about all objects
sp_helpdb;          -- Info about all databases
sp_helpdb iti2;     -- Info about specific database
sp_help student;    -- Info about specific table
sp_help nvarchar;   -- Info about data type
sp_spaceused;       -- Info about database space usage

------------------------------------------------------------
-- Constraints
CREATE TABLE dept (
  did INT PRIMARY KEY,
  name TEXT
);

CREATE TABLE emp (
  eid INT NOT NULL PRIMARY KEY,
  ename NVARCHAR(50),
  esal INT CHECK (esal > 100),
  eadd NVARCHAR(50) DEFAULT 'cairo' CHECK (eadd IN ('cairo','alex')),
  overtime INT CHECK (overtime BETWEEN 100 AND 1000),
  did INT FOREIGN KEY REFERENCES dept(did)
);
-- CHECK ensures data meets conditions.
-- DEFAULT assigns default values.
-- FOREIGN KEY maintains referential integrity.
-- Constraints can be added or dropped using ALTER TABLE.

------------------------------------------------------------
-- SnapShot
CREATE DATABASE snap
ON (NAME='iti', FILENAME='d:\db\2.ss')
AS SNAPSHOT OF iti;
-- A database snapshot is a read-only copy of a database at a specific moment.


------------------------------------------------------------
-- Schema and Synonyms
CREATE SCHEMA Projects;
ALTER SCHEMA Projects TRANSFER dbo.t1;

CREATE SYNONYM mySyn FOR HumanResources.Employee;
SELECT * FROM mySyn;
--  Synonym: A shortcut/alias for long object names — improves readability.


------------------------------------------------------------
-- Defaults, Rules, and User-Defined Data Types
-- Default Binding
CREATE DEFAULT dcity AS 'tanta';
EXEC sp_bindefault dcity, 'student.st_address';

-- Rule Binding
CREATE RULE rage AS @age > 10;
EXEC sp_bindrule rage, 'student.st_age';

-- User-Defined Data Type
EXEC sp_addtype new_dtype, 'nvarchar(50)', 'NOT NULL';
ALTER TABLE student ALTER COLUMN st_fname new_dtype;

-- You can also create alias types:
CREATE TYPE SSN FROM varchar(11) NOT NULL;
CREATE TYPE ShortDescription FROM nvarchar(10) NOT NULL;

