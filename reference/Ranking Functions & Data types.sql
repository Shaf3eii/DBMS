-- Ranking functions assign numbers to rows based on order.
-- ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE()

-- ROW_NUMBER: gives unique row numbers
SELECT *, ROW_NUMBER() OVER (ORDER BY st_age DESC) AS RN FROM Student;

-- DENSE_RANK: same rank for ties, no gaps
SELECT *, DENSE_RANK() OVER (ORDER BY st_age DESC) AS DR FROM Student;

-- PARTITION BY: restart numbering for each group
SELECT *, ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY st_age DESC) AS RN FROM Student;

-- NTILE: divide results into equal groups
SELECT *, NTILE(4) OVER (ORDER BY st_age DESC) AS GroupNum FROM Student;



--datatypes
--numeric
--bit   bool  0:1   true:false 
--tinyint		 1byte       -128:+127  unsigned 0:255
--smallint		 2b			  -32768:+32767 unsigned 0:65555 
--int		   	8b
--big int	   	2g
---------------------------
--decimale
--smallmoney 4b  .0000
--money      8b   .0000
--real			0.0000000
--float				0.0000000000000......
--dec dec(digits,floats) dec(5,2) 122.12    12.898 xx
------------------------------
--char  char(max number 10msln)  ficxed length chars reserved
--varchar(max number 10msln) variable length charachter by7gz 3la 2d ma tktb
--nchar()
--nvarchar() n for scability lw 3ayz aktb ai lo3'a 3'er el english
---------------------------------
--datetime
-- Date mm/dd/yyyy
--time hh:mm
--time(7) hh:mm 12.7875464
--smalldatetime modern dates mm/dd/yyy hh:mm
--datetime   more dates range
--datetime(7)
--datetimeoffset 24/11/2021 10:30 +2:00 time zone
--------------------------------
--binary 01110101
--image bttsave as binaries 