SELECT *
FROM HumanResources.Employee

SELECT JobTitle, BirthDate, Gender From HumanResources.Employee

SELECT BirthDate as "Date of Birth" From HumanResources.Employee

SELECT BirthDate as "Date of Birth", LoginID as "ID for Login", MaritalStatus as "Marital Status" From HumanResources.Employee

SELECT top 5 * FROM HumanResources.Employee
SELECT top 50 percent * FROM HumanResources.Employee

select * from [HumanResources].[Employee] where Gender = 'M'
select * from [HumanResources].[Employee] where VacationHours != 80
select * from [HumanResources].[Employee] where VacationHours >= 80

select * from [HumanResources].[Employee] where SickLeaveHours > 30
select * from [HumanResources].[Employee] where VacationHours <= 10


select * from [HumanResources].[Employee] where JobTitle = 'Research and Development Manager'
select * from [HumanResources].[Employee] where MaritalStatus <> 'S'

select *, VacationHours + SickLeaveHours as "Total Hours" from [HumanResources].[Employee] 
select *, SalariedFlag + VacationHours+ SickLeaveHours + CurrentFlag as TotalNumbers from [HumanResources].[Employee] 

select * from [HumanResources].[Employee] where (VacationHours & SickLeaveHours) > 50

select * from [Production].[Product] where Name like 'c%'
select * from [Production].[Product] where Name like 'chainrin_'
select * from [Production].[Product] where Name like 'chain'
select * from [Production].[Product] where Name like '%m'
select * from [Production].[Product] where Name like '%road%'
select * from [Production].[Product] where Name like '%nut%'
select * from [Production].[Product] where Name like 'metal%'


select * from [Purchasing].[ProductVendor] where ProductID in (2,317)
select * from [Purchasing].[ProductVendor] where UnitMeasureCode in ('CTN','EA')

SELECT * FROM [Person].[CountryRegion] WHERE CountryRegionCode in ('BY', 'CI', 'SG')


SELECT * FROM [Production].[ProductCostHistory] WHERE StandardCost between 12 and 14
SELECT * FROM [Production].[ProductCostHistory] WHERE StandardCost between 700 and 1000
SELECT * FROM [Production].[ProductCostHistory] WHERE StandardCost >= 700 and ProductID > 720

SELECT * FROM [Production].[ProductCostHistory] WHERE EndDate is not null
SELECT * FROM [Production].[ProductCostHistory] WHERE EndDate is null

SELECT * FROM [HumanResources].[Employee] WHERE OrganizationLevel = 1 and Gender = 'M' and SickLeaveHours > 30
SELECT * FROM [HumanResources].[Employee] WHERE JobTitle like 'Chief%' and MaritalStatus = 'M' and Gender ='F'

SELECT * FROM [Person].[StateProvince] where StateProvinceCode = 'AB' or StateProvinceCode = 'AK'
SELECT * FROM [Person].[StateProvince] where (CountryRegionCode = 'CA' or CountryRegionCode = 'US') AND StateProvinceCode = 'AB'

SELECT* FROM [Production].[Product] WHERE Name = 'Seat Tube' or Name = 'Blade'

SELECT* FROM [Production].[Product] WHERE not Name = 'Seat Tube' 

SELECT* FROM [Production].[Product] WHERE Name not like '%Chainring%' 
SELECT* FROM [Production].[Product] WHERE  SafetyStockLevel not like 1000  and not Name = '%blade%'

SELECT* FROM [Production].[Product] order by Name
SELECT* FROM [Production].[Product] order by Name DESC

 SELECT* FROM [Production].[Product] where SafetyStockLevel = 1000 order by  Name  desc
 SELECT* FROM [Production].[Product] order by  StandardCost, Name

 select * from [HumanResources].[Employee] where Gender = 'F' order by JobTitle 

SELECT* FROM [Production].[Product] where Name like '%pedal%' order by StandardCost desc
SELECT* FROM [Production].[Product] where StandardCost between 20 and 200 Order by StandardCost /* this is a comment */
SELECT* FROM [Production].[Product] where StandardCost between 20 and 200 Order by StandardCost -- this is also a comment
