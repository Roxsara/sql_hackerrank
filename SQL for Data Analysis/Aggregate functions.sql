-- Aggregate functions

-- Exercise 1:
/*
Display the number of purchasing orders in the Purchasing.PurchaseOrderHeader table where the total amount due is greater than $20,000.
*/

SELECT COUNT(PurchaseOrderID)
  FROM Purchasing.PurchaseOrderHeader
  WHERE TotalDue > 20000;

-- Exercise 2:
/*
Display the sum of all total amounts due for purchasing orders in the Purchasing.PurchaseOrderHeader table.
*/

SELECT SUM(TotalDue)
  FROM Purchasing.PurchaseOrderHeader;

-- Exercise 3:
/*
Display the largest single amount due for a purchasing order in the Purchasing.PurchaseOrderHeader table.
*/

SELECT MAX(TotalDue)
  FROM Purchasing.PurchaseOrderHeader;

-- Exercise 4:
/*
Display the average of subtotal + freight for all purchasing orders in the Purchasing.PurchaseOrderHeader table.
*/

SELECT AVG(SubTotal + Freight)
  FROM Purchasing.PurchaseOrderHeader;


-- Aggregate functions with GROUP BY

-- Exercise 1:
/*
Display the count of products in the Production.Product table, broken out by color.
*/

SELECT COUNT(ProductID),
	   Color
  FROM Production.Product
  GROUP By Color;

-- Exercise 2:
/*
Modify your code from Exercise 1 by breaking out the product count by color AND style.
Then add a new column with the sum of the list prices for each group.
*/

SELECT [Number of products] = COUNT(ProductID),
	   Color,
	   Style,
	   [Total list price] = SUM(ListPrice)
  FROM Production.Product
  GROUP By Color, Style;

-- Exercise 3:
/*
You are not limited to only grouping by individual fields in your data; you can actually group by derived fields as well!
You just have to make sure that you include the same derived field in both your SELECT and GROUP BY.
With that in mind, "prettify" your output from Exercise 2 by displaying "No color" in the "Color" column in place of NULL values, 
and "NA" in the "Style" column in place of NULL values.
HINT: The ISNULL function could be handy 
*/

SELECT [Number of products] = COUNT(ProductID),
	   [Color] = ISNULL(Color, 'No color'),
	   [Style] = ISNULL(Style, 'NA'),
	   [Total list price] = SUM(ListPrice)
  FROM Production.Product
  GROUP BY ISNULL([Color], 'No color'), ISNULL([Style], 'NA');


-- Aggregate functions with HAVING

-- Exercise 1:
/*
Identify all first names in the Person.Person table which are shared by more than 50 people.
Sort the output in descending order by the count of the name.
*/

SELECT FirstName,
	   [Number of people] = COUNT(*)
  FROM Person.Person
  GROUP BY FirstName
  HAVING COUNT(*) > 50
  ORDER BY COUNT(*) DESC;

-- Exercise 2:
/*
Identify all products in the Production.Products table (by name) with total sales in the Purchasing.PurchaseOrderDetail table of less than $10,000.
Also include a column with a count of sales by product in your output.
Sort the output by total sales amount, in ascending order.
HINT: Total sales can be defined as the sum of line totals from the Purchasing.PurchaseOrderDetail table.
Your code should look quite similar to an example presented in the video.
*/

SELECT A.[Name],
	   [Total Sales Amount] = SUM(B.LineTotal),
	   [Count of Sales] = COUNT(A.ProductID)
  FROM Production.Product A
  JOIN Purchasing.PurchaseOrderDetail B
  ON A.ProductID = B.ProductID
  GROUP BY A.[Name]
  HAVING SUM(B.LineTotal) < 10000
  ORDER BY SUM(B.LineTotal);

-- Exercise 3:
/*
Modify your query from Exercise 2 by filtering out products whose name includes a number.
HINT: You will need to use a wildcard with LIKE; review the example code provided in the course section on pattern matching with wildcards
if you need a refresher.
*/

SELECT A.[Name],
	   [Total Sales Amount] = SUM(B.LineTotal),
	   [Count of Sales] = COUNT(A.ProductID)
  FROM Production.Product A
  JOIN Purchasing.PurchaseOrderDetail B
  ON A.ProductID = B.ProductID
  WHERE A.[Name] NOT LIKE '%[0-9]%'
  GROUP BY A.[Name]
  HAVING SUM(B.LineTotal) < 10000
  ORDER BY SUM(B.LineTotal);
