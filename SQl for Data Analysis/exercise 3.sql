--Exercise 3:

--Select the first 100 rows from the Sales.SalesPerson table.
--Display only the SalesLastYear and SalesYTD columns, in that order.

SELECT TOP (100)
      [SalesLastYear]
      ,[SalesYTD]
  FROM [AdventureWorks2019].[Sales].[SalesPerson]