--Exercise 1:

--Select the first 3,000 rows from the Person.Person table. 
--Display only the Title, LastName, and FirstName columns, in that order.

SELECT TOP (3000)
      [Title]
	  ,[LastName]
      ,[FirstName]
  FROM [AdventureWorks2019].[Person].[Person]