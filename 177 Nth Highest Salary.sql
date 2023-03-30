use sample1;
CREATE TABLE employee(id int, salary int);
INSERT INTO employee VALUES (1,100),(2,200),(3,300),(4,400),(5,500);
SELECT * FROM employee;


--SET @N =2;
--SELECT @N;

SELECT TOP 1 salary AS getNthHighestSalary
FROM
(
SELECT TOP @N id,salary		-- Here we can't use variable with TOP keyword
FROM employee 
ORDER BY salary DESC
) AS tb1;

GO
CREATE FUNCTION getnthhighestsalary(@N INT)
returns INT
AS
BEGIN
RETURN
(SELECT salary
FROM
(
SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
FROM employee
) AS tb1 WHERE rnk = @N
)
END
GO

SELECT dbo.getnthhighestsalary(2) ;