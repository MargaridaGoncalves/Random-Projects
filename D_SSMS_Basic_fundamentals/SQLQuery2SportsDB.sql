use SportsDB
-- we are creating a table with this script
Insert into Sports Values('Football', 0) -- here is possible to see that we don't insert the ID condition
-- read table
Select* from Sports
-- Update statement
Update Sports Set Name = 'Basketball' where ID = 1
-- read table
Select* from Sports

-- DELETE records
delete from Sports where ID = 6
Select* from Sports

-- TO OPEN THE TABLE CONDITIONS CLICK ON THE RIGHT OF THE TABLE AND THEN INTO THE DESSIGN OPTION
/*

Insert into Teams Values('Real Madrid', 2) 
Insert into Teams Values('Atletico Madrid', 2) 
Insert into Teams Values('Chelsea FC', 2) 

Insert into Teams Values('LA Lakers', 1) 
*/
Select* from Teams
Select* from Sports
Select* from Teams INNER JOIN Sports ON Sports.ID = Teams.SportID

-- Change names from the columns without the as 
Select Sports.Name [Sport Name], Teams.Name [Team Name], Sports.IsindividualSport [is individual Sport] FROM Teams
INNER JOIN Sports ON Sports.ID = Teams.SportID

-- this is a test comment ctrl+k then ctrl+c


-- Create a table manually
-- CREATE TABLE Attendees (PersonID int, HeroName varchar(255), Assets int, Sector varchar (255) )
Select* from Attendees


/*

CREATE TABLE Job
  ( 
     personid         INT PRIMARY KEY, 
     heroname         VARCHAR(255), 
     age              INT, 
     assets           INT, 
     sector           VARCHAR(255), 
     city             VARCHAR(255), 
     salary           INT, 
     distancetraveled INT, 
     rating           INT 
  )

INSERT INTO job 
            (personid, heroname, age, assets, sector, 
             city,salary, distancetraveled, rating) 
VALUES      (1, 'Spider Man ',32,300000,'Tech', 
             'B', 10000, 10,9), 
            (2, 'Super Man ', 64, 700000, 'Tech', 
             'M',10700,11, 5 ), 
            (3, 'Bat Man ', 100, 900000,'Fin', 
             'Q',12000, 11,  4 ), 
            (4, 'X Man ', 200,140000, 'Fin', 
             'B',12500,13,5 ), 
            (5, 'Wonder Woman', 100, 13000, 'Tech', 
             'C',11500, 11, NULL )

CREATE TABLE avgsalary 
  ( 
     city2     VARCHAR(255), 
     avgsalary INT 
  ) 

INSERT INTO avgsalary 
            (city2, avgsalary) 
VALUES      ('M',12000), 
            ('B', 11000), 
            ('Q', 9000), 
            ('LI',8500)

CREATE TABLE avgsalary2 
  ( city      VARCHAR(255),  avgsalary INT )

INSERT INTO avgsalary2 
            (city, avgsalary) 
VALUES      ('M', 12000), 
            ('B', 11000), 
            ('Br',9000), 
            ('Bs', 7000)

*/

Select* from Job
Select* from avgsalary
Select* from avgsalary2

Select* from Job
Select heroname,
	case 
		when city = 'Q' then 'Queens' -- we are adding a column that states that if the city starts with an Q this colum will have queens written
		else 'other city' -- else it will have in this new column other city written
		end 
from Job

Select max(salary) from Job -- only gives a number
-- to acquire the complete row we have
Select * from Job Where salary = (Select max(salary) from Job) -- it has to have the ()


Select* from Job
Select *,
	concat (cast(assets/1000 as char), 'k') Assetsink		-- cast is used to define the variable that is being concat into a char variable
from Job                                                    -- Assetsink is the new column that is being generated

Select *,
	concat (assets,' ',salary,' ',assets + salary) money	-- ' ' to create a space between them
from Job 

select *, assets/salary as frugalmeasure -- do calculations while creating a new column
from Job
order by frugalmeasure desc;


select * from Job where   
   city in                     -- SELECTING THE CITY NAME THAT IS CONTAINED IN THE (SELECT  CITY2 VECTOR)
   (select 
      city2 from avgsalary where avgsalary >10000)
	 -- (select city2 from avgsalary where avgsalary >10000) : this gave B and M as result

Select * FROM Job ORDER BY assets desc
SELECT Max(assets) FROM  Job WHERE  assets Not IN (SELECT Max(assets) FROM   Job) -- this code gives the max asset value after the first max asset


-- to see the complete row of the max asset:
SELECT * FROM  Job WHERE ( assets IN (SELECT Max(assets) FROM   Job))
-- to see the complete row of the second max asset:
SELECT  top 1 * FROM  Job WHERE ( assets Not IN  (SELECT Max(assets) FROM   Job)) order by assets desc 
-- OR
SELECT  top 1 * FROM Job WHERE assets < (SELECT MAX(assets) FROM Job) ORDER BY assets DESC 

-- MOD function in SQL
-- If a mod 2 = 0, the number is even
-- If a mod 2 = 1, the number is odd
SELECT *  FROM Job WHERE age % 2 = 0
SELECT *  FROM Job WHERE rating % 2 = 0
SELECT *  FROM Job WHERE salary % 2 = 0

-- Use the Group by function
Select sector, AVG(age) as [average Age per section] from Job group by sector -- here we can not do select *

-- if i want to have the other columns should create functions for them
SELECT sector, COUNT(*) AS TotalEmployees, AVG(age) AS [average Age per section]
FROM Job
GROUP BY sector

SELECT sector, COUNT(*) AS TotalEmployees, AVG(age) AS [average Age per section], max(assets) as [max assets], sum(assets) as [sum assets]
FROM Job
GROUP BY sector

-- let's mix up the group by and the order by
SELECT sector, COUNT(*) AS TotalEmployees, AVG(age) AS [average Age per section]
FROM Job
GROUP BY sector
order by AVG(age) desc

-- let's mix up the group by and the order by and even add a condition into it
--WHERE filters rows BEFORE aggregation.
--HAVING filters rows AFTER aggregation.

SELECT sector, COUNT(*) AS TotalEmployees, AVG(age) AS [average Age per section], avg(salary) as [average Salary]
FROM Job
GROUP BY sector
having avg(salary) > 11500 -- having needs to be before the ORDER BY condition
order by AVG(age) desc


SELECT *  FROM Job
-- Another example
SELECT sector,  avg(salary) as [average Salary], COUNT(*) AS TotalEmployees -- the moment I use an aggregation function (such as avg) I need to have the function GROUP BY
FROM Job
where age > 35 -- one employee was excluded from the calculation/table because it was 32y
GROUP BY sector
having avg(salary) > 11500 -- having needs to be before the order by condition


-- Instead of having a new table I add the avg(salary) into the existing table 
-- Using OUTER JOIN

SELECT *  FROM Job
SELECT J.*, A.avg_salary
FROM Job J
FULL OUTER JOIN 
    (SELECT city, AVG(salary) AS avg_salary
     FROM Job
     GROUP BY city) A -- A is the avg salary grouped by city
ON J.city = A.city

-- LET'S DO THAT WITH MORE CONDITIONS
SELECT J.*, A.avg_salary, A.avg_age, A.TotalEmployees
FROM Job J
FULL OUTER JOIN 
    (SELECT city, 
		AVG(salary) AS avg_salary,
		AVG(age) AS avg_age,
		COUNT(*) AS TotalEmployees
     FROM Job
     GROUP BY city) A -- A is the avg salary grouped by city
ON J.city = A.city

-- Adding data from other table into this one

SELECT J.*, A.avg_salary, A.avg_age, E.TotalEmployees
FROM Job J
FULL OUTER JOIN 
    (SELECT city, 
            AVG(salary) AS avg_salary,
            AVG(age) AS avg_age
     FROM Job
     GROUP BY city) A
ON J.city = A.city
FULL OUTER JOIN 
    (SELECT city, 
            COUNT(*) AS TotalEmployees -- this column can seem like it does not make sense but in thruth 
     FROM Attendees 
     GROUP BY city) E -- there is 1 employee in city M and 1 employee in city B
ON J.city = E.city


SELECT * from Avgsalary
union all -- combines the columns of the two tables: cbind.
select * from Avgsalary2