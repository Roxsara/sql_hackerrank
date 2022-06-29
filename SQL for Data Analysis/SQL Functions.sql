-- Creating basic derived columns

-- Exercise 1
/*
Select a derived column from the "Person.Person" table - aliased as "Person Title" - that consists of the person's first name,
followed by a space, followed by their last name, followed by a hyphen (-), followed by the person type.
*/

SELECT 
	[Person Title] = [FirstName] + ' ' + [LastName] + '-' + [PersonType]
FROM [AdventureWorks2019].[Person].[Person];

-- Exercise 2
/*
Select all rows from the "HumanResources.Employee" table where "SalariedFlag" = 0. Include the following columns in your output:
BusinessEntityID
VacationHours
SickLeaveHours
Total Time Off - This is a derived column you will calculate by adding vacation hours and sick leave hours
Sort the output by total time off, in ascending order.
*/

SELECT [BusinessEntityID]
      ,[VacationHours]
      ,[SickLeaveHours]
	  ,[Total Time Off] = [VacationHours] + [SickLeaveHours]
FROM [AdventureWorks2019].[HumanResources].[Employee]
WHERE [SalariedFlag] = 0
ORDER BY [Total Time Off];

-- Exercise 3
/*
Select all rows from the "HumanResources.EmployeePayHistory" table. Include the following columns in your output:
BusinessEntityID
Rate
Weekly Pay - This is a derived column you will calculate using the employee pay rate from the "Rate" column, and assuming a 40 hour work week.
Sort the output by amount per paycheck in descending order.
*/

SELECT [BusinessEntityID]
      ,[Rate]
	  ,[Weekly Pay] = [Rate]*40
	  ,[Amount per paycheck] = [Rate]*40*[PayFrequency]
FROM [AdventureWorks2019].[HumanResources].[EmployeePayHistory]
ORDER BY [Amount per paycheck] DESC;


/*
Modify your query from Exercise 2 by adding a new derived column called "Total Days Off". 
This column should build on our math for "Total Time Off" by factoring in an assumed 8 hour workday. 
HINT - remember how to keep SQL from performing "integer division" by dividing by a decimal!
*/

SELECT [BusinessEntityID]
      ,[VacationHours]
      ,[SickLeaveHours]
	  ,[Total Time Off] = [VacationHours] + [SickLeaveHours]
	  ,[Total Days Off] = ([VacationHours] + [SickLeaveHours]) / 8.0
FROM [AdventureWorks2019].[HumanResources].[Employee]
WHERE [SalariedFlag] = 0
ORDER BY [Total Time Off];

-- SQL Text Functions

-- Exercise 1
/*
Select the following columns (all rows) from the "Sales.CreditCard" table:
CardNumber
Last Four Digits - a derived column with just the last four digits of the credit card number
*/

SELECT
       [CardNumber]
      ,[Last Four Digits] = RIGHT([CardNumber], 4)
FROM [AdventureWorks2019].[Sales].[CreditCard];

-- Exercise 2
/*
Select the following columns (all rows) from the "Production.ProductReview" table:
ReviewerName
Comments
Cleaned Comments - a derived column in which all commas from the "Comments" field have been replaced with empty strings
*/

SELECT
       [ReviewerName]
      ,[Comments]
      ,[Cleaned Comments] = REPLACE([Comments],',','')
FROM [AdventureWorks2019].[Production].[ProductReview];

-- Exercise 3
/*
Select the "FirstName" and "LastName" columns from the "Person.Person" table.
Only include rows where the length of the last name is greater than or equal to 10 characters.
Bonus:Sort the output of Exercise 3 by the length of the last name, in descending order. 
HINT - you can re-use the expression in your WHERE clause in your ORDER BY, even though it isn't included in the SELECT list!
*/

SELECT [FirstName]
      ,[LastName]
FROM [AdventureWorks2019].[Person].[Person]
WHERE LEN([LastName])>=10
ORDER BY LEN([LastName]) DESC;

-- Nested functions

-- Exercise 1
/*
Select the "FirstName" and "LastName" columns from the "Person.Person" table (all rows). 
Now add a derived column called "Nickname", which is created by combining the first character of the the first name, a hyphen (-),
and the first three characters of the last name.
*/

SELECT
       [FirstName]
      ,[LastName]
      ,[Nickname] = LEFT([FirstName], 1) + '-' + LEFT([LastName], 3)
FROM [AdventureWorks2019].[Person].[Person];

-- Exercise 2
/*
Select the following columns (all rows) from the "Production.ProductReview" table:
ReviewerName
Comments
Cleaned Comments - a derived column in which all commas AND periods from the "Comments" field have been replaced with empty strings.
HINT - you will have to nest multiple REPLACE functions.
*/

SELECT
       [ReviewerName]
      ,[Comments]
      ,[Cleaned Comments] = REPLACE(REPLACE([Comments], ',', ''), '.', '')
FROM [AdventureWorks2019].[Production].[ProductReview];

-- Exercise 3
/*
There are a LOT of text functions in SQL. More than you could possibly scrunch into a single course or book without it turning 
into an encyclopedia. As such, you will frequently find yourself using Google or Bing to look up functions that accomplish specific tasks.
Let's practice that here.
Select the "FirstName" column from the "Person.Person" table (all rows). Now add the following derived columns:
FirstNameUpper, which features the first name entirely capitalized
FirstNameLower, which consists of the first name transformed entirely to lowercase
HINT - try searching for what you're trying to do (say, convert text to uppercase)in conjunction with the word "SQL".
*/

SELECT
       [FirstName]
      ,[FirstNameUpper] = UPPER([FirstName])
      ,[FirstNameLower] = LOWER([FirstName])
FROM [AdventureWorks2019].[Person].[Person];

-- Dates and datetimes

-- Exercise 1
/*
Select the following (not tied to any table in our AdventureWorks database):
A field called "Today" showing the current day and time
A field called "This Month", showing the number of the current month
A field called "This Year", showing the number of the current year.
All fields above should be calculated via SQL functions.
*/

SELECT [Today]=DAY(GETDATE()),
	   [This Month]=MONTH(GETDATE()),
	   [This Year]=YEAR(GETDATE());

-- Exercise 2
/*
Select all records from the "Purchasing.PurchaseOrderHeader" table where the order date occurred between 1/1/2011 and 7/31/2011 
AND the total amount due is greater than $10,000. Include the following columns:
PurchaseOrderID
OrderDate
TotalDue
*/

SELECT PurchaseOrderID,
	   OrderDate,
	   TotalDue
FROM Purchasing.PurchaseOrderHeader
WHERE OrderDate BETWEEN DATEFROMPARTS(2011,1,1) AND DATEFROMPARTS(2011,7,31) AND TotalDue>10000;


-- Date math

-- Exercise 1
/*
Use date math in conjunction with GETDATE to calculate what date is 100 days from now.
*/

SELECT DATEADD(DAY, 100, GETDATE());

-- Exercise 2
/*
Use DATEADD to calculate what date is 6 months from now.
*/

SELECT DATEADD(MONTH, 6, GETDATE());

-- Exercise 3
/*
Use DATEDIFF to select all rows from the "Sales.SalesOrderHeader" table where the order date is 7 or less days before 12/25/2013.
Note that it is possible for DATEDIFF to output a negative number if the "end" date is prior to your "start" date,
so you may want to use BETWEEN instead of <= in your criteria.
You may select all columns via the SELECT * shorthand.
*/

SELECT *
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
  WHERE DATEDIFF(DAY, [OrderDate], DATEFROMPARTS(2013, 12, 25)) BETWEEN 0 AND 7;

-- Exercise Bonus
/*
Modify your query from Exercise 3 to work for ANY year, not just 2013.
HINT - instead of hardcoding the year in your DATEFROMPARTS function, you will probably want to calculate the year based on the order date.
*/

SELECT *
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
  WHERE DATEDIFF(DAY, [OrderDate], DATEFROMPARTS(YEAR([OrderDate]),12,25)) BETWEEN 0 AND 7;


-- Data types and CASTing

-- Exercise 1
/*
Calculate yesterday's date dynamically via GETDATE. Convert the value to a DATE datatype, such that it has no timestamp component.
*/

SELECT CAST(GETDATE()-1 AS DATE);

-- Exercise 2
/*
Calculate the number of days between the current date and the end of the current year via DATEDIFF.
Use the CAST function to create the end-of-year date.
*/

SELECT DATEDIFF(DAY, GETDATE(), CAST('2022-12-31' AS DATE));

-- Exercise 3
/*
Select all rows from the "Person.Person" table where the middle name is not NULL, AND either the title is not NULL OR the suffix is not NULL.
Include the following columns:
Title
FirstName
MiddleName
LastName
Suffix
PersonID - a derived column created by combining the person type, a hyphen(-), and the business entity ID, in that order.
HINT - you will need to convert the business entity ID to a VARCHAR in order for the concatenation to work.
*/

SELECT Title,
	   FirstName,
	   MiddleName,
	   LastName,
	   Suffix,
	   [PersonID] = PersonType + '-' + CAST(BusinessEntityID AS VARCHAR)
  FROM Person.Person
  WHERE MiddleName IS NOT NULL AND (Title IS NOT NULL OR Suffix IS NOT NULL);


-- Handling NULL values with ISNULL

-- Exercise 1
/*
Select all rows from the "Production.Product" table where the weight is less than 10 pounds. 
Make sure to include NULL values in your output, and use ISNULL to accomplish this.
Include the following columns in your output:
Name
Color
*/

SELECT [Name],
	   [Color]
  FROM Production.Product
  WHERE ISNULL([Weight], 0) < 10;

-- Exercise 2
/*
Modify the "Color" field of your query from Exercise 1 such that NULL values are replaced with the word "None".
*/

SELECT [Name],
	   ISNULL([Color], 'None')
  FROM Production.Product
  WHERE ISNULL([Weight], 0) < 10;


-- The CASE statement

-- Exercise 1
/*
Select a derived column called "Price Category" from the "Production.Product" table such that:
If the list price is greater than $1,000, return "Premium".
If the list price is greater than $100 and less than $1,000, return "Mid-Range".
If the list price is less than $100, return "Value". This should be the default case.
Also include Name and ListPrice as columns in your output.
*/

SELECT [Name],
	   [ListPrice],
	   [Price Category] = 
	   CASE
	   WHEN [ListPrice] >= 1000 THEN 'Premium'
	   WHEN [ListPrice] BETWEEN 100 AND 1000 THEN 'Mid-Range'
	   ELSE 'Value'
	   END
  FROM Production.Product;


-- Exercise 2
/*
Select a derived column called "Employee Tenure" from the "HumanResources.Employee" table such that:
If an employee is salaried, and has been with the company 10 or more years
(calculated as the DATEDIFF in YEARs between the "HireDate" value and the current date), return "Non-Exempt - 10+ Years".
If an employee is salaried, and has been with the company less than 10 years, return "Non-Exempt - < 10 Years".
If an employee is NOT salaried, and has been with the company 10 or more years
(calculated as the DATEDIFF in YEARs between the "HireDate" value and the current date), return "Exempt - 10+ Years".
If an employee is NOT salaried, and has been with the company less than 10 years, return "Exempt - < 10 Years". This should be the default case.
Also include BusinessEntityID, HireDate, and SalariedFlag as columns in your output.
*/

SELECT BusinessEntityID,
	   HireDate,
	   SalariedFlag,
	   [Employee Tenure] = 
	   CASE
	   WHEN SalariedFlag = 1 AND DATEDIFF(YEAR, HireDate, GETDATE()) >= 10 THEN 'Non-Exempt - 10+ Years'
	   WHEN SalariedFlag = 1 AND DATEDIFF(YEAR, HireDate, GETDATE()) < 10 THEN 'Non-Exempt - < 10 Years'
	   WHEN SalariedFlag = 0 AND DATEDIFF(YEAR, HireDate, GETDATE()) >= 10 THEN 'Exempt - 10+ Years'
	   ELSE 'Exempt - < 10 Years'
	   END
  FROM HumanResources.Employee;