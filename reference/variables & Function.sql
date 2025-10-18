------------------------------------------------------------
-- VARIABLES & DECLARATIONS
-- Declaring and assigning variables
DECLARE @x INT
SELECT @x = 100
SELECT @x

DECLARE @y INT = 500
SELECT @y

-- Assigning variable using a subquery
DECLARE @avg_age INT = (SELECT AVG(st_age) FROM Student)
SELECT @avg_age

-- Invalid: Subquery returns multiple rows
DECLARE @x2 INT = 100
SELECT @x2 = (SELECT st_age FROM Student)  -- ERROR

-- Valid: Subquery returns single value
DECLARE @x3 INT
SELECT @x3 = (SELECT st_age FROM Student WHERE st_id = 2)
SELECT @x3

-- When no record found → variable = NULL
DECLARE @x4 INT = 100
SELECT @x4 = (SELECT st_age FROM Student WHERE st_id = 99999)
SELECT @x4  -- NULL

-- Assigning multiple variables
DECLARE @age INT, @name VARCHAR(20)
SELECT @age = st_age, @name = st_fname FROM Student
SELECT @age, @name  -- last record assigned

------------------------------------------------------------
-- UPDATE WITH VARIABLE
DECLARE @z VARCHAR(20)
UPDATE Student 
SET st_fname = 'Ali', @z = st_lname 
WHERE st_id = 8
SELECT @z

------------------------------------------------------------
-- TABLE VARIABLE
DECLARE @t TABLE (id INT, name VARCHAR(20))
INSERT INTO @t
SELECT st_id, st_fname FROM Student
SELECT * FROM @t

------------------------------------------------------------
-- TOP WITH VARIABLE
DECLARE @n INT = 5
SELECT TOP(@n) * FROM Student

------------------------------------------------------------
-- EXECUTING DYNAMIC SQL
DECLARE @col VARCHAR(20)='*', @tab VARCHAR(20)='Student'
EXECUTE('SELECT '+@col+' FROM '+@tab)

------------------------------------------------------------
-- GLOBAL VARIABLES
SELECT @@SERVERNAME         -- Server name
SELECT @@VERSION            -- SQL Server version
SELECT @@ROWCOUNT           -- Rows affected
SELECT @@ERROR              -- Last error number
SELECT @@IDENTITY           -- Last inserted identity value

------------------------------------------------------------
-- CONTROL FLOW STATEMENTS
DECLARE @rows INT
UPDATE Student SET st_age += 1
SELECT @rows = @@ROWCOUNT

IF @rows > 0
	BEGIN
		SELECT 'Multiple rows affected'
	END
ELSE 
	BEGIN
		SELECT 'No rows affected'
	END

------------------------------------------------------------
-- IF EXISTS / IF NOT EXISTS
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Student')
	SELECT 'Table exists'
ELSE	
	CREATE TABLE Student (id INT, name NVARCHAR(20))

------------------------------------------------------------
-- ERROR HANDLING WITH TRY...CATCH
BEGIN TRY 
	DELETE FROM Department WHERE dept_id = 20
END TRY
BEGIN CATCH 
	SELECT 'Error occurred'
	SELECT ERROR_LINE(), ERROR_NUMBER(), ERROR_MESSAGE()
END CATCH

------------------------------------------------------------
-- LOOPS (WHILE, BREAK, CONTINUE)
DECLARE @counter INT = 10
WHILE @counter <= 20
BEGIN
	SET @counter += 1
	IF @counter = 14 CONTINUE
	IF @counter = 16 BREAK
	SELECT @counter
END
-- Output: 11, 12, 13, 15

------------------------------------------------------------
-- IIF FUNCTION
SELECT IIF(COUNT(dept_id) < 20, 'True = less', 'False = more')
FROM Department

------------------------------------------------------------
-- CASE EXPRESSION
SELECT st_fname, st_age,
CASE
	WHEN st_age > 25 THEN 'Older than 25'
	WHEN st_age = 25 THEN 'Exactly 25'
	ELSE 'Younger than 25'
END AS AgeStatus
FROM Student

------------------------------------------------------------
-- BATCHES
-- A batch is a set of queries executed together.
-- If one fails, others continue.
INSERT INTO Parent (id) VALUES (1)
INSERT INTO Parent (id) VALUES (2)
INSERT INTO Parent (id) VALUES (3)

INSERT INTO Child (fid) VALUES (1)
INSERT INTO Child (fid) VALUES (4)   -- foreign key error
INSERT INTO Child (fid) VALUES (3)

------------------------------------------------------------
-- SCRIPT (separated by GO) -> some queries can't run together, seperate them with GO
CREATE TABLE Temp (id INT)
GO
DROP TABLE Temp
GO
CREATE RULE r10 AS @x > 10
GO
SP_BINDRULE r10, 'Student.st_age'

------------------------------------------------------------
-- TRANSACTIONS
-- A transaction works as one atomic unit.
BEGIN TRANSACTION
	INSERT INTO Child (fid) VALUES (1)
	INSERT INTO Child (fid) VALUES (2)
	INSERT INTO Child (fid) VALUES (3)
COMMIT

-- Rollback cancels all
BEGIN TRANSACTION
	INSERT INTO Child (fid) VALUES (1)
	INSERT INTO Child (fid) VALUES (4)
ROLLBACK

-- Safe transaction with TRY/CATCH
BEGIN TRY 
	BEGIN TRANSACTION
		INSERT INTO Child (fid) VALUES (1)
		INSERT INTO Child (fid) VALUES (2)
		INSERT INTO Child (fid) VALUES (3)
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
	SELECT ERROR_MESSAGE()
END CATCH

------------------------------------------------------------
-- USER-DEFINED FUNCTIONS
-- 1. SCALAR FUNCTION (returns a single value)
CREATE FUNCTION FirstName (@id INT)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @name VARCHAR(20)
	SELECT @name = st_fname FROM Student WHERE st_id = @id
	RETURN @name
END

SELECT dbo.FirstName(2)

------------------------------------------------------------
-- 2. INLINE TABLE FUNCTION (returns table, no logic)
CREATE FUNCTION GetInstructor (@did INT)
RETURNS TABLE
AS
RETURN
(
	SELECT ins_name, salary * 12 AS YearSalary
	FROM Instructor
	WHERE dept_id = @did
)

SELECT * FROM GetInstructor(10)

------------------------------------------------------------
-- 3. MULTI-STATEMENT TABLE FUNCTION
CREATE FUNCTION GetStudent (@format VARCHAR(20))
RETURNS @t TABLE 
(
	id INT,
	studentName VARCHAR(50)
)
AS
BEGIN
	IF @format = 'first'
		INSERT INTO @t SELECT st_id, st_fname FROM Student
	ELSE IF @format = 'last'
		INSERT INTO @t SELECT st_id, st_lname FROM Student
	ELSE IF @format = 'full'
		INSERT INTO @t SELECT st_id, st_fname + ' ' + st_lname FROM Student
	RETURN
END

SELECT * FROM GetStudent('full')

------------------------------------------------------------
-- WINDOW FUNCTIONS (LAG, LEAD, FIRST_VALUE, LAST_VALUE)
SELECT st_fname, grade,
	LAG(st_fname) OVER (ORDER BY grade) AS PrevStudent,
	LEAD(st_fname) OVER (ORDER BY grade) AS NextStudent
FROM Stud_Course 
INNER JOIN Student ON Student.st_id = Stud_Course.st_id

SELECT st_fname, grade, crs_id,
	FIRST_VALUE(st_fname) OVER (PARTITION BY crs_id ORDER BY grade) AS FirstStudent,
	LAST_VALUE(st_fname) OVER (PARTITION BY crs_id ORDER BY grade ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastStudent
FROM Stud_Course 
INNER JOIN Student ON Student.st_id = Stud_Course.st_id
