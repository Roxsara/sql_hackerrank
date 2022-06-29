-- Applying criteria with WHERE

-- Exercise 1:
/*
Select any rows from the “Person.Person” table where the value in the “FirstName” column is “Pilar”. 
Include all columns EXCEPT “BusinessEntityID”, “rowguid”, and “ModifiedDate” in your output.
*/

SELECT 
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [FirstName] = 'Pilar'

-- Exercise 2:
/*
Select any rows from the “Purchasing.Vendor” table 
where the value in the “Name” column is “Northwind Traders”. 
Include all columns EXCEPT “BusinessEntityID” and “ModifiedDate” in your output.
*/

SELECT
       [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
  FROM [AdventureWorks2019].[Purchasing].[Vendor]
  WHERE [Name] = 'Northwind Traders'

-- Exercise 3:
/*
Modify your query from Exercise 2 by commenting out the WHERE statement,
and then adding a new criterion that filters for preferred vendors only – 
that is to say, where the value in the “PreferredVendorStatus” column is 1.
*/

SELECT
       [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
  FROM [AdventureWorks2019].[Purchasing].[Vendor]
  --WHERE [Name] = 'Northwind Traders'
  WHERE [PreferredVendorStatus] = 1


-- Inequalities and NULLs

-- Exercise 1:
/*
Select any records from the “Person.Person” where the person type is not equal to “IN”.
Do not include the “BusinessEntityID” and “rowguid” fields in your output.
*/

SELECT
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [PersonType] != 'IN'

-- Exercise 2:
/*
Select all people from the “Person.Person” who have a “Title”. 
Do not include the “BusinessEntityID” and “rowguid” fields in your output.
*/

SELECT
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [Title] IS NOT NULL

-- Exercise 3:
/*
Select all people from the “Person.Person” who do NOT have a middle name listed.
Do not include the “BusinessEntityID” and “rowguid” fields in your output.
*/

SELECT
       [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [MiddleName] IS NULL

-- Exercise Bonus:
/*
Select all people from the “Person.Person” who do NOT have a title of “Mr.”.
Make sure to include NULL values in your result.
*/

SELECT [BusinessEntityID]
      ,[PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [Title] != 'Mr.' OR [Title] IS NULL


-- Multiple criteria with AND, OR, and IN
-- Exercise 1:
/*
Select all people from the “Person.Person” table with a first name of “Laura” and a last name of “Norman”.
Include only the following columns in your output:
PersonType
Title
FirstName
LastName
*/

SELECT
       [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [FirstName] = 'Laura' AND [LastName] = 'Norman'

-- Exercise 2&3:
/*
Modify your query from Exercise 1 as follows: Change your criteria to only look for records where the person type is either “SP”, “EM”, or “VC”.
*/

SELECT
       [PersonType]
      ,[Title]
      ,[FirstName]
      ,[LastName]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [PersonType] IN ('SP', 'EM', 'VC')


-- Combining AND and OR
-- Exercise 1:
/*
Select all rows from the "HumanResources.Employee" table where gender = "F", AND the job title is either "Network Manager" or "Application Specialist".
Select all columns using the "SELECT *" shortcut.
*/

SELECT *
  FROM [AdventureWorks2019].[HumanResources].[Employee]
  WHERE [Gender] = 'F' AND ([JobTitle] = 'Network Manager' OR [JobTitle] = 'Application Specialist')

-- Exercise 2:
/*
Streamline your query from Exercise 1 by using an IN statement to replace the OR.
Try running the modified query without parentheses to see if it still works.
*/

SELECT *
  FROM [AdventureWorks2019].[HumanResources].[Employee]
  WHERE [Gender] = 'F' AND [JobTitle] IN ('Network Manager', 'Application Specialist')

-- Exercise 3:
/*
Select all rows from the "Person.Person" table where person type = "EM", AND there is a NULL value in either the "Title" or "MiddleName" fields.
Include the following fields in your query:
PersonType (aliased as "Person Type")
Title
FirstName (aliased as "First Name")
MiddleName (aliased as "Middle Name")
LastName (aliased as "Last Name")
Suffix
*/

SELECT
       [Person Type] = [PersonType]
      ,[Title]
      ,[First Name] = [FirstName]
      ,[Middle Name] = [MiddleName]
      ,[Last name] = [LastName]
      ,[Suffix]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [PersonType] = 'EM' AND ([Title] IS NULL OR [MiddleName] IS NULL)

-- Exercise Bonus:
/*
Modify your query from Exercise 3 such that you are now selecting all rows where person type is either "EM" or "SP" 
AND there is a NULL value in either the "Title", "MiddleName", or "Suffix" fields.
*/

SELECT
       [Person Type] = [PersonType]
      ,[Title]
      ,[First Name] = [FirstName]
      ,[Middle Name] = [MiddleName]
      ,[Last name] = [LastName]
      ,[Suffix]
  FROM [AdventureWorks2019].[Person].[Person]
  WHERE [PersonType] IN ('EM', 'SP') AND ([Title] IS NULL OR [MiddleName] IS NULL OR [Suffix] IS NULL)


-- Selecting numerical values by range
-- Exercise 1:
/*
Select all rows from the "Purchasing.PurchaseOrderHeader" table where the total due amount is greater than $50,000 and the freight amount is less than $1,000.
Include the following columns in your output:
OrderDate
SubTotal
TaxAmt
Freight
TotalDue
*/

SELECT
       [OrderDate]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
  FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderHeader]
  WHERE [TotalDue] > 50000 AND [Freight] < 1000

-- Exercise 2:
/*
Using the BETWEEN keyword ,modify your query from Exercise 1 such that you are now pulling in all rows 
where the subtotal amount is between $10,000 and $30,000.
*/

SELECT
       [OrderDate]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
  FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderHeader]
  WHERE [SubTotal] BETWEEN 10000 AND 30000

-- Exercise 3:
/*
Modify your query from Exercise 2 such that you are NOT including $10,000 and $30,000 in your range of subtotals, 
but still including all amounts between these numbers. In other words, the range should no longer be "inclusive".
*/

SELECT
       [OrderDate]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
  FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderHeader]
  WHERE [SubTotal] > 10000 AND [SubTotal] < 30000

-- Matching text patterns with wildcards

-- Exercise 1:
/*
Select all rows from the Person.Person table where the first name is abbreviated with a period/dot at the end - for example, "A.".
Select all columns via the "SELECT *" shortcut.
*/

SELECT *
FROM [AdventureWorks2019].[Person].[Person]
WHERE [FirstName] LIKE '%.';

-- Exercise 2:
/*
Select all people from the Person.Person table with the initials "TLC".
HINT - you'll have to apply criteria to the FirstName, MiddleName, AND LastName columns.
You may select all columns via the "SELECT *" shortcut.
*/

SELECT *
FROM [AdventureWorks2019].[Person].[Person]
WHERE [FirstName] LIKE 'T%' AND [MiddleName] LIKE 'L%' AND [LastName] LIKE 'C%';

-- Exercise 3:
/*
Select all rows from the Person.Person table where the first name does not include a vowel (a, e, i, o, or u). 
HINT - you do NOT need to use OR to accomplish this; try using a wildcard with brackets ([ ]) instead.
You may select all columns via the "SELECT *" shortcut.
*/

SELECT *
FROM [AdventureWorks2019].[Person].[Person]
WHERE [FirstName] NOT LIKE '%[aeiou]%';


-- Sorting data with ORDER BY

-- Exercise 1
/*
Select all rows and the following columns from the HumanResources.Employee table:
OrganizationLevel (alias as "Organization Level")
JobTitle (alias as "Job Title")
VacationHours (alias as "Vacation Hours")
SickLeaveHours (alias as "Sick Leave Hours")
Sort your output first by OrganizationLevel in ascending order, then VacationHours in descending order.
*/

SELECT
	[Organization Level] = [OrganizationLevel],
	[Job Title] = [JobTitle],
	[Vacation Hours] = [VacationHours],
	[Sick Leave Hours] = [SickLeaveHours]
FROM [AdventureWorks2019].[HumanResources].[Employee]
ORDER BY [OrganizationLevel] ASC, [VacationHours] DESC;

-- Exercise 2
/*
Modify your query from Exercise 1 to use your column aliases, rather than the actual column names 
in the database table, in the ORDER BY.
*/

SELECT
	[Organization Level] = [OrganizationLevel],
	[Job Title] = [JobTitle],
	[Vacation Hours] = [VacationHours],
	[Sick Leave Hours] = [SickLeaveHours]
FROM [AdventureWorks2019].[HumanResources].[Employee]
ORDER BY [Organization Level] ASC, [Vacation Hours] DESC;

-- Exercise 3
/*
Modify your query from Exercise 2 to use the position of the columns in the query output 
(for example, 1 for the first column) in the ORDER BY as opposed to the column aliases.
*/

SELECT
	[Organization Level] = [OrganizationLevel],
	[Job Title] = [JobTitle],
	[Vacation Hours] = [VacationHours],
	[Sick Leave Hours] = [SickLeaveHours]
FROM [AdventureWorks2019].[HumanResources].[Employee]
ORDER BY 1 ASC, 3 DESC;

-- Selecting unique values with SELECT

-- Exercise 1
/*
Produce a list of the unique person types in the "Person.Person" table, sorted in ascending order.
*/

SELECT DISTINCT [PersonType]
FROM [AdventureWorks2019].[Person].[Person]
ORDER BY [PersonType];

-- Exercise 2
/*
Produce a list of the unique full names in the "Person.Person" table - including first name, middle name, and last name.
Only include names that have a value for middle name.
The output should be sorted by last name and then by first name, in ascending order.
*/

SELECT DISTINCT [FirstName], [MiddleName], [LastName]
FROM [AdventureWorks2019].[Person].[Person]
WHERE [MiddleName] IS NOT NULL
ORDER BY [LastName], [FirstName];