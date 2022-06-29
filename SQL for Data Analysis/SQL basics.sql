-- Introduction to SQL

-- Exercise 1:
/*
Select the first 3,000 rows from the Person.Person table. 
Display only the Title, LastName, and FirstName columns, in that order.
*/

SELECT TOP (3000)
       [Title]
	  ,[LastName]
      ,[FirstName]
  FROM [AdventureWorks2019].[Person].[Person]


-- Exercise 2:
/*
Select the first 500 rows from the Sales.SalesOrderHeader table.
Display only the OrderDate, DueDate, ShipDate, and TotalDue columns, in that order.
*/

SELECT TOP (500)
       [OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[TotalDue]
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]


-- Exercise 3:
/*
Select the first 100 rows from the Sales.SalesPerson table.
Display only the SalesLastYear and SalesYTD columns, in that order.
*/

SELECT TOP (100)
       [SalesLastYear]
      ,[SalesYTD]
  FROM [AdventureWorks2019].[Sales].[SalesPerson]


-- Aliasing columns

-- Exercise 1:
/*
Modify the query in the “Aliasing Columns – Example Code.sql” file such that all column names in the query output have spaces between the words.
*/

SELECT 
       [Organization Level] = [OrganizationLevel]
      ,[Job Title] = [JobTitle]
      ,[Hire Date] = [HireDate]
      ,[Vacation Hours] = [VacationHours]
	  
  FROM [AdventureWorks2019].[HumanResources].[Employee]


-- Exercise 2:
/*
Write a query that outputs the “Name” and “ListPrice” fields from the “Production.Product” table. 
These column names in the query output should read “Product Name” and “List Price $$”, respectively.
*/

SELECT 
       [Product Name] = [Name]
      ,[List Price $$] = [ListPrice]
  FROM [AdventureWorks2019].[Production].[Product]


-- Exercise 3:
/*
Write a query that outputs the “PurchaseOrderID”, “OrderQty”, and “LineTotal” fields 
from the “Purchasing.PurchaseOrderDetail” table. 
“PurchaseOrderID” should be renamed to “OrderID”, and “OrderQty” to “OrderQuantity”. 
“LineTotal” can remain unchanged.
*/

SELECT
	   [OrderID] = [PurchaseOrderID]
      ,[OrderQuantity] = [OrderQty]
      ,[LineTotal]
  FROM [AdventureWorks2019].[Purchasing].[PurchaseOrderDetail]


-- Selecting custom values

-- Exercise 1
/*
Write a query that selects your first name and age.
Name the columns “First Name”, and “Age”, respectively.
*/

SELECT [First Name] = 'Roxana',
	   [Age] = 33

-- Exercise 2:
/*
Write a query that outputs:
•	All columns from the Sales.SalesOrderHeader table EXCEPT “rowguid” and “ModifiedDate”.
•	A column called “Query Run By” that outputs your first name. 
    This should be the first column in the query output.
The query should only output the top 5000 rows from the table.
*/

SELECT TOP (5000) 
	   [Query Run By] = 'Roxana'
	  ,[SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]


-- SQL Tips and tricks

-- Exercise 1:
/*
Select all columns AND rows from the “Sales.Customer” table.
*/

SELECT *
  FROM [AdventureWorks2019].[Sales].[Customer]


-- Exercise 2:
/*
Select all columns and the top 100 rows from the “Production.Product” table.
*/

SELECT TOP (100) *
  FROM [AdventureWorks2019].[Production].[Product]


