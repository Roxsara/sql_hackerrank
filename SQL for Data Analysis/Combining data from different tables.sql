-- Stacking table rows with UNION

-- Exercise 1
/*
Write a query that selects all rows from the "Purchasing.PurchaseOrderDetail" table where the line total is greater than $10,000.
Include the following columns in your output:
PurchaseOrderID
PurchaseOrderDetailID
OrderQty
LineTotal
*/

SELECT PurchaseOrderID,
	   PurchaseOrderDetailID,
	   OrderQty,
	   LineTotal
  FROM Purchasing.PurchaseOrderDetail
  WHERE LineTotal > 10000;


-- Exercise 2
/*
Write a similar query that selects all rows from the "Sales.SalesOrderDetail" table where the line total is greater than $10,000.
Include the following columns in your output:
SalesOrderID
SalesOrderDetailID
OrderQty
LineTotal
*/

SELECT SalesOrderID,
	   SalesOrderDetailID,
	   OrderQty,
	   LineTotal
  FROM Sales.SalesOrderDetail
  WHERE LineTotal > 10000;


-- Exercise 3
/*
Combine the rows from your Exercise 1 and Exercise 2 queries by "stacking" them vertically. Make sure the similar fields from each table align.
Alias the first two columns as "OrderID" and "OrderDetailID", respectively.
*/


SELECT OrderID = PurchaseOrderID,
	   OrderDetailID = PurchaseOrderDetailID,
	   OrderQty,
	   LineTotal
  FROM Purchasing.PurchaseOrderDetail
  WHERE LineTotal > 10000

UNION

SELECT OrderID = SalesOrderID,
	   OrderDetailID = SalesOrderDetailID,
	   OrderQty,
	   LineTotal
  FROM Sales.SalesOrderDetail
  WHERE LineTotal > 10000;

-- Exercise 4
/*
Add the following derived fields to your query; remember , you'll need to add them to both components of your query. 
Sort the output of your query by line total in descending order.
"RunDate" - displays the current date
"OrderType" - this should display the string "Purchase" for purchase orders, and "Sale" for sales orders.
*/

SELECT OrderID = PurchaseOrderID,
	   OrderDetailID = PurchaseOrderDetailID,
	   OrderQty,
	   LineTotal,
	   RunDate = GETDATE(),
	   OrderType = 'Purchase'
  FROM Purchasing.PurchaseOrderDetail
  WHERE LineTotal > 10000

UNION

SELECT OrderID = SalesOrderID,
	   OrderDetailID = SalesOrderDetailID,
	   OrderQty,
	   LineTotal,
	   RunDate = GETDATE(),
	   OrderType = 'Sale'
  FROM Sales.SalesOrderDetail
  WHERE LineTotal > 10000

ORDER BY LineTotal DESC;


-- JOINs

-- Exercise 1
/*
Write a query that combines the "FirstName" and "LastName" columns from the "Person.Person" table, with the "EmailAddress" column from the "Person.EmailAddress" table.
HINT - these tables have the "BusinessEntityID" field in common.
*/

SELECT A.[FirstName],
	   A.[LastName],
	   B.[EmailAddress]
  FROM Person.Person A
  JOIN Person.EmailAddress B
  ON A.BusinessEntityID = B.BusinessEntityID;

-- Exercise 2
/*
Write a query that combines the "Name" and "ListPrice" columns from the "Production.Product" table, with the "ReviewerName" and "Comments" columns from the "Production.ProductReview" table.
HINT - these tables have the "ProductID" field in common.
*/

SELECT A.[Name],
	   A.[ListPrice],
	   B.[ReviewerName],
	   B.[Comments]
  FROM Production.Product A
  JOIN Production.ProductReview B
  ON A.ProductID = B.ProductID;


-- Going deeper with JOINs

-- Exercise 1
/*
Write a query that combines the "FirstName" and "LastName" columns from the "Person.Person" table, with the "EmailAddress" column from the "Person.EmailAddress" table,
AND the "PhoneNumber" field from the "Person.PersonPhone" table.
HINT - these tables all have the "BusinessEntityID" field in common.
*/

SELECT A.FirstName,
	   A.LastName,
	   B.EmailAddress,
	   C.PhoneNumber
  FROM Person.Person A
  JOIN Person.EmailAddress B
  ON A.BusinessEntityID = B.BusinessEntityID
  JOIN Person.PersonPhone C
  ON B.BusinessEntityID = C.BusinessEntityID;

-- Exercise 2
/*
Modify your query from Exercise 1 such that you now only pull in phone numbers with a Seattle area code - that is to say, phone numbers that start with "206".
HINT - PhoneNumber is a text field, so you will need a text function to accomplish this. Either LEFT or a wildcard used in conjunction with LIKE should work.
*/

SELECT A.FirstName,
	   A.LastName,
	   B.EmailAddress,
	   C.PhoneNumber
  FROM Person.Person A
  JOIN Person.EmailAddress B
  ON A.BusinessEntityID = B.BusinessEntityID
  JOIN Person.PersonPhone C
  ON B.BusinessEntityID = C.BusinessEntityID
  WHERE LEFT(C.PhoneNumber, 3) = '206';

-- Exercise 3
/*
Modify your query from Exercise 2 to pull in each person's city from the "Person.Address" table.
Note that this table has no fields in common with any of the tables already in our join. This means we will need to join in another table that we can use as a 
"bridge" between our Person.Address table and our Person.Person table - a table that should have fields we can use to connect it to either table.
The table we need is "Person.BusinessEntityAddress"; note that it has both "BusinessEntityID" AND "AddressID" fields. You will need to join this table to 
Person.Person, and then join Person.Address to this table in order to get your query to work.
*/

SELECT A.FirstName,
	   A.LastName,
	   B.EmailAddress,
	   C.PhoneNumber,
	   E.City
  FROM Person.Person A
  JOIN Person.EmailAddress B
  ON A.BusinessEntityID = B.BusinessEntityID
  JOIN Person.PersonPhone C
  ON B.BusinessEntityID = C.BusinessEntityID
  JOIN Person.BusinessEntityAddress D
  ON A.BusinessEntityID = D.BusinessEntityID
  JOIN Person.[Address] E
  ON D.AddressID = E.AddressID;


-- OUTER JOINs

-- Exercise 1
/*
Write a query that combines the "BusinessEntityID", "SalesQuota", and "SalesYTD" columns from the "Sales.SalesPerson" table,
with the "Name" column from the "Sales.SalesTerritory" table. Alias the "Name" column as "TerritoryName".
Make sure to include all rows from the "Sales.SalesPerson" table regardless of whether a match is found in the "Sales.SalesTerritory" table.
I'll leave it to you to determine which field to use to link the two tables together.
*/

SELECT A.[BusinessEntityID],
	   A.[SalesQuota],
	   A.[SalesYTD],
	   B.[Name] AS TerritoryName
  FROM Sales.SalesPerson A
  LEFT JOIN Sales.SalesTerritory B
  ON A.TerritoryID = B.TerritoryID;

-- Exercise 2
/*
Modify your query from Exercise 1 to only include rows where the YTD sales are less than $2,000,000.
*/

SELECT A.[BusinessEntityID],
	   A.[SalesQuota],
	   A.[SalesYTD],
	   B.[Name] AS TerritoryName
  FROM Sales.SalesPerson A
  LEFT JOIN Sales.SalesTerritory B
  ON A.TerritoryID = B.TerritoryID
  WHERE A.SalesYTD < 2000000;

-- Exercise 3
/*
Change the join in your query from Exercise 2 from an outer join to an inner join, and take note of the effect on the query output.
Are the rows with NULL values in the "TerritoryName" column still being included?
*/

SELECT A.[BusinessEntityID],
	   A.[SalesQuota],
	   A.[SalesYTD],
	   B.[Name] AS TerritoryName
  FROM Sales.SalesPerson A
  JOIN Sales.SalesTerritory B
  ON A.TerritoryID = B.TerritoryID
  WHERE A.SalesYTD < 2000000;


-- Going deeper with OUTER JOINs

-- Exercise 1
/*
Create a query with the following columns:
SalesOrderID, OrderDate, and TotalDue from the "Sales.SalesOrderHeader" table
A derived column called "Percent of Sales YTD", calculated as follows:
The value in the "TotalDue" column from Sales.SalesOrderHeader, divided by the value in the "SalesYTD" field from the Sales.SalesPerson table,
then multiplied by 100.
**You can connect the two tables by their "SalesPersonID" and "BusinessEntityID" fields, respectively.
Return all rows from Sales.SalesOrderHeader that have a total due amount greater than $2,000,
regardless of whether there is a sales person associated with the sale. Sort the output by sales order ID, ascending.
*/

SELECT A.SalesOrderID,
	   A.OrderDate,
	   A.TotalDue,
	   [Percent of Sales YTD] = A.TotalDue/B.SalesYTD*100
  FROM Sales.SalesOrderHeader A
  LEFT JOIN Sales.SalesPerson B
  ON A.SalesPersonID = B.BusinessEntityID
  WHERE A.TotalDue > 2000
  ORDER BY A.SalesOrderID;

-- Exercise 2
/*
Modify your query from  Exercise 1 such that only records from Sales.SalesOrderHeader where the Sales YTD value is less than $2,000,000 are included.
The overall number of records returned by your query should not change.
*/

SELECT A.SalesOrderID,
	   A.OrderDate,
	   A.TotalDue,
	   [Percent of Sales YTD] = A.TotalDue/B.SalesYTD*100
  FROM Sales.SalesOrderHeader A
  LEFT JOIN Sales.SalesPerson B
  ON A.SalesPersonID = B.BusinessEntityID AND b.SalesYTD < 2000000
  WHERE A.[TotalDue] > 2000
  ORDER BY A.SalesOrderID;

-- Exercise 3
/*
Add the "SalesOrderDetailID" and "LineTotal" columns from the "Sales.SalesOrderDetail" table to your Exercise 2 query.
Only include records in your output where a match is found in this query.
I'll leave it to you to figure out which field to join on (it's pretty intuitive).
NOTE - you are likely to find that the record count of your query increases substantially.
This is because there is a one to many relationship between Sales.SalesOrderHeader and Sales.SalesOrderDetail, 
with each sales order being composed of potentially many individual items.
*/

SELECT A.SalesOrderID,
	   A.OrderDate,
	   A.TotalDue,
	   [Percent of Sales YTD] = A.TotalDue/B.SalesYTD*100,
	   C.SalesOrderDetailID,
	   C.LineTotal
  FROM Sales.SalesOrderHeader A
  LEFT JOIN Sales.SalesPerson B
  ON A.SalesPersonID = B.BusinessEntityID AND b.SalesYTD < 2000000
  JOIN Sales.SalesOrderDetail C
  ON A.SalesOrderID = C.SalesOrderID
  WHERE A.[TotalDue] > 2000
  ORDER BY A.SalesOrderID;