1. SYMMETRIC PAIR

-- Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

-- Write a query to output all such symmetric pairs in ascending order by the value of X.
-- Sample input
-- 20 20
-- 20 20
-- 20 21
-- 23 22
-- 22 23
-- 21 20

-- Sample Output

-- 20 20
-- 20 21
-- 22 23

DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS test; 
USE test;

DROP TABLE IF EXISTS test1;

CREATE TABLE test1 (
  X decimal(4,0) NOT NULL,
  Y decimal(4,0) NOT NULL);
  
insert into  test1 values (20,20);
insert into  test1 values (20,20);
insert into  test1 values (20,21);
insert into  test1 values (23,22);
insert into  test1 values (22,23);
insert into  test1 values (21,20);

-- The solution is divided in two parts 
-- First part finds paris where x1 != y1 example all other pairs except 20 20 in above example
-- because of condingiton f1.x<f2.x above pairs will get excluded
-- this is required because otherwise we will get duplicate records

-- Second part is to find such pairs where x1= y1 and x1 and y1 repeats for more than once
-- It returns 20,20 two tiems for above example
-- Using union instead of union all gives only distinct rows

(SELECT f1.X, f1.Y from test1 f1 , test1 f2
WHERE f1.X = f2.Y AND f1.Y = f2.X and f1.Y < f1.X)
UNION
(SELECT f1.X, f1.Y FROM test1 AS f1 
WHERE f1.X = f1.Y AND
(SELECT COUNT(*) FROM test1 WHERE X = f1.X AND Y = f1.Y) > 1);
-- For each row in the main query, the subquery (SELECT COUNT(*) FROM Functions
--  WHERE X = f1.X AND Y = f1.Y) is executed.

-- The subquery checks how many rows in the "Functions" table have the same values in 
-- columns "X" and "Y" as the current row (specified by the alias "f1"). 
-- The "X" and "Y" values of the current row are compared with the values in 
-- the "X" and "Y" columns of the "Functions" table.

-- If the count of such rows is greater than 1, it means that there are multiple rows
-- in the table with the same values in columns "X" and "Y" as the current row.

-- The condition (SELECT COUNT(*) FROM Functions WHERE X = f1.X AND Y = f1.Y) > 1 
-- evaluates to either true or false for each row in the main query.

-- The main query's WHERE clause checks the condition and only includes rows 
-- for which the condition is true.

-- In summary, this subquery is used to filter out rows from the result set
-- where there are multiple rows in the "Functions" table with the same values in
--  columns "X" and "Y" as the current row. 
-- It ensures that only rows with duplicated values are included in the final result.








