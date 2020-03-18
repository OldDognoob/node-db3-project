-- Multi-Table Query Practice
--data base retrieved results from SQLiteStudio, SQL Editor of northwind
-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
select
  categoryname,
  productname
from category
join product on category.id = product.CategoryId 

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.

select
  [order].id,
  shipper.CompanyName
from [order]
join shipper on [order].shipvia = shipper.Id
where
  [order].orderdate < '2012-08-09' 
-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
--"PRODUCT".ProductName, "OrderDetail".Quantity
select
  orderid,
  quantity,
  product.ProductName
from orderdetail
join product on orderdetail.ProductId = product.Id
where
  orderid = 10251 
-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
select
  id as orderid,
  customer.CompanyName as "Customer's company name",
  employee.LastName as " employee's last name"
from [order]
join customer on [order].customerid = customer.id
join employee on [order].employeeid = employee.Id 

----------------------------Stretchs Tests----------------------------------------

--Displays CategoryName and a new column called Count that shows how many products are in each category. Shows 8 records.
select 
c.categoryname, 
count(*) as count 
from [Products] as p 
join [Categories] as c 
on p.categoryID = c.categoryID 
group by categoryname;

--Display OrderID and a column called ItemCount that shows the total number of products placed on the order. Shows 196 records.
select
  orderid,
  sum(quantity) as ItemCount
from orderdetails
group by
  orderid
---------------------------Stretch Tests-------------------------------------(more info lecture slack)
--Find the number of shipments by each shipper
select 
s.companyname,
count(o.id) as shippments
from [order]as o
join [shipper]as s
on o.shipvia = s.id
group by s.companyname

--Find the top 5 best performing employees measured in revenue
select 
e.firstname, 
e.lastname, 
count(o.id) as Orders
FROM [Order] as o
JOIN [Employee] as e
    on o.EmployeeId = e.Id
GROUP BY e.lastname
ORDER BY Orders desc
LIMIT 5;

--Find the customer country with the most orders
select [Customers].Country, count(*) as Orders
from [Customers]
join [Orders] ON [Customers].CustomerID = [Orders].CustomerID
join [OrderDetails] on [Orders].OrderID = [OrderDetails].OrderID
group by [Customers].Country
order by [Orders]desc limit 1







