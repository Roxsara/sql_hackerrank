--Exercise 2:

--Select the first 500 rows from the Sales.SalesOrderHeader table.
--Display only the OrderDate, DueDate, ShipDate, and TotalDue columns, in that order.

SELECT TOP (500)
       [OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[TotalDue]
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]