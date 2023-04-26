CREATE DATABASE ProductTask
USE ProductTask

CREATE TABLE Categories(
       Id int PRIMARY KEY IDENTITY(1,1),
	   [Name] nvarchar(50),
	   TopCategoryId int NOT NULL foreign key references Categories(Id) 
)
INSERT Categories
VALUES
      ('Koynek',1),
	  ('Ayaqqabi',2),
	  ('Telefon',3)

SELECT ct.TopCategoryId 'Top Category',c.Name 'Sub Category' FROM Categories as ct
JOIN Categories as c
ON
ct.Id = c.TopCategoryId

CREATE TABLE Products(
       Id int PRIMARY KEY IDENTITY(1,1),
	   [Name] nvarchar(50),
	   CategoryId int foreign key REFERENCES Categories(Id)
)

INSERT Products
VALUES
     ('Gucci',1),
	 ('Versaci',1),
	 ('Nike',2),
	 ('Honor',3)

SELECT c.Name 'Product Name',ct.Name 'Category' FROM Products AS c
JOIN Categories AS ct
ON
c.CategoryId = ct.Id

CREATE TABLE Suppliers(
      Id int PRIMARY KEY IDENTITY(1,1),
	  [Name] nvarchar(50),
	  Phone nvarchar(50)
)

INSERT Suppliers
VALUES
      ('Trendyol','+0212-482-16-42'),
      ('Amazon','+7-918-256-82-85'),
	  ('Alibaba','+994-50-981-69-49')

CREATE TABLE SupplierProducts (
      Id int PRIMARY KEY IDENTITY(1,1),
	  SupplierId int foreign key REFERENCES Suppliers(Id),
	  ProductId int foreign key REFERENCES Products(Id),
	  StockQuantity int,
	  Price money
)

INSERT SupplierProducts
VALUES
      (1,2,10,60),
	  (2,3,20,40),
	  (3,1,5,2000)

SELECT *
FROM Suppliers
JOIN SupplierProducts ON Suppliers.Id = SupplierProducts.SupplierId
JOIN Products ON SupplierProducts.ProductId = Products.Id;

CREATE TABLE Orders(
       Id int PRIMARY KEY IDENTITY(1,1),
	   OrderDate date,
	   TotalAmount money
)

INSERT Orders
VALUES
      ('2023-04-20',100),
	  ('2023-02-18',200),
	  ('2023-04-21',150)

CREATE TABLE OrderDetails(
       Id int PRIMARY KEY IDENTITY(1,1),
	   ProductId int foreign key REFERENCES Products(Id),
	   OrderId int foreign key REFERENCES Orders(Id),
	   Quantity int,
	   Price money
)

INSERT OrderDetails
VALUES
      (1,2,3,300),
	  (2,3,10,350),
	  (3,1,15,400)

SELECT *
FROM Orders
JOIN OrderDetails ON Orders.Id = OrderDetails.OrderId
JOIN Products ON OrderDetails.ProductId = Products.Id