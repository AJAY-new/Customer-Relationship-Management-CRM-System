create database CRM;
use crm;

-- Drop tables if they exist (drop child tables first to avoid foreign key conflicts)
DROP TABLE IF EXISTS Orders, SupportTickets, SalesOpportunities, Campaigns, Products, Employees, Customers;

-- Create Customers Table (Independent Table)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Employees Table (Independent Table)
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Role ENUM('Sales', 'Support', 'Marketing'),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Products Table (Independent Table)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT,
    Description TEXT,
    Manufacturer VARCHAR(100),
    WarrantyPeriod INT,  -- In months
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create SalesOpportunities Table (References Customers, Products, Employees)
CREATE TABLE SalesOpportunities (
    OpportunityID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ProductID INT,
    ExpectedRevenue DECIMAL(10,2),
    Probability DECIMAL(5,2),
    Status ENUM('New', 'Negotiation', 'Closed-Won', 'Closed-Lost'),
    SalesRepID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE SET NULL,
    FOREIGN KEY (SalesRepID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL
);

-- Create SupportTickets Table (References Customers, Employees)
CREATE TABLE SupportTickets (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    Issue TEXT,
    Status ENUM('Open', 'In Progress', 'Resolved', 'Closed'),
    AssignedTo INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ResolvedAt TIMESTAMP NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID) ON DELETE SET NULL
);

-- Create Campaigns Table (Independent Table)
CREATE TABLE Campaigns (
    CampaignID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Type ENUM('Email', 'Social Media', 'Advertisement', 'Referral'),
    Budget DECIMAL(10,2),
    StartDate DATE,
    EndDate DATE,
    Status ENUM('Planned', 'Active', 'Completed'),
    Description TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Insert into Orders Table (Fixing based on valid CustomerID and ProductID)
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity, TotalAmount, Status) 
VALUES 
(1, 2, '2024-03-01', 1, 800.00, 'Shipped'),
(2, 1, '2024-03-02', 2, 1600.00, 'Pending'), 
(3, 4, '2024-03-03', 1, 250.00, 'Delivered'),
(4, 6, '2024-03-04', 3, 1500.00, 'Shipped'),
(5, 3, '2024-03-05', 1, 150.00, 'Cancelled'),
(6, 7, '2024-03-06', 1, 700.00, 'Delivered'),
(7, 5, '2024-03-07', 2, 1200.00, 'Pending'), 
(8, 8, '2024-03-08', 1, 200.00, 'Shipped'),
(9, 9, '2024-03-09', 1, 300.00, 'Pending'),
(10, 10, '2024-03-10', 3, 900.00, 'Delivered');






-- Insert into Customers Table
INSERT INTO Customers (Name, Email, Phone, Address, City, State, ZipCode, Country) VALUES
('John Doe', 'john.doe@email.com', '1234567890', '123 Street', 'New York', 'NY', '10001', 'USA'),
('Alice Smith', 'alice.smith@email.com', '2345678901', '456 Avenue', 'Los Angeles', 'CA', '90001', 'USA'),
('Bob Johnson', 'bob.j@email.com', '3456789012', '789 Boulevard', 'Chicago', 'IL', '60007', 'USA'),
('Emma Davis', 'emma.d@email.com', '4567890123', '101 Road', 'Houston', 'TX', '77001', 'USA'),
('Michael Brown', 'michael.b@email.com', '5678901234', '202 Lane', 'Phoenix', 'AZ', '85001', 'USA'),
('Olivia Wilson', 'olivia.w@email.com', '6789012345', '303 Way', 'Philadelphia', 'PA', '19101', 'USA'),
('William Taylor', 'william.t@email.com', '7890123456', '404 Drive', 'San Antonio', 'TX', '78201', 'USA'),
('Sophia Martinez', 'sophia.m@email.com', '8901234567', '505 Path', 'San Diego', 'CA', '92101', 'USA'),
('James Anderson', 'james.a@email.com', '9012345678', '606 Trail', 'Dallas', 'TX', '75201', 'USA'),
('Charlotte Thomas', 'charlotte.t@email.com', '0123456789', '707 Crescent', 'San Jose', 'CA', '95101', 'USA');

-- Insert into Employees Table
INSERT INTO Employees (Name, Email, Phone, Role, Department, Salary, HireDate) VALUES
('David Johnson', 'david.j@email.com', '1111111111', 'Sales', 'Sales', 60000, '2022-01-15'),
('Emily White', 'emily.w@email.com', '2222222222', 'Support', 'Customer Service', 55000, '2021-12-10'),
('Daniel Brown', 'daniel.b@email.com', '3333333333', 'Marketing', 'Marketing', 65000, '2023-02-20'),
('Sarah Green', 'sarah.g@email.com', '4444444444', 'Sales', 'Sales', 62000, '2021-07-25'),
('Ryan Black', 'ryan.b@email.com', '5555555555', 'Support', 'Customer Service', 56000, '2020-06-18'),
('Mia Harris', 'mia.h@email.com', '6666666666', 'Marketing', 'Marketing', 67000, '2019-03-30'),
('Ethan Young', 'ethan.y@email.com', '7777777777', 'Sales', 'Sales', 63000, '2021-09-05'),
('Isabella Adams', 'isabella.a@email.com', '8888888888', 'Support', 'Customer Service', 58000, '2022-04-15'),
('Matthew Scott', 'matthew.s@email.com', '9999999999', 'Marketing', 'Marketing', 69000, '2020-12-01'),
('Sophia Clark', 'sophia.c@email.com', '0000000000', 'Sales', 'Sales', 64000, '2023-01-10');

-- Insert into Products Table
INSERT INTO Products (Name, Category, Price, Stock, Description, Manufacturer, WarrantyPeriod) VALUES
('Laptop', 'Electronics', 1000, 50, 'High performance laptop', 'Dell', 24),
('Smartphone', 'Electronics', 800, 100, 'Latest model smartphone', 'Apple', 12),
('Headphones', 'Accessories', 150, 200, 'Noise-canceling headphones', 'Sony', 18),
('Smartwatch', 'Wearables', 250, 75, 'Advanced health tracking watch', 'Samsung', 12),
('Tablet', 'Electronics', 600, 90, 'Lightweight tablet', 'Microsoft', 24),
('Gaming Console', 'Gaming', 500, 60, 'Next-gen gaming console', 'Sony', 36),
('Camera', 'Photography', 700, 40, 'Professional digital camera', 'Canon', 24),
('Speaker', 'Audio', 200, 120, 'Bluetooth speaker', 'JBL', 12),
('Monitor', 'Electronics', 300, 80, '4K resolution monitor', 'LG', 24),
('Keyboard', 'Accessories', 100, 150, 'Mechanical keyboard', 'Razer', 24);




-- Insert into Orders Table (Fixing based on valid CustomerID and ProductID)
-- Insert into Orders Table (Fixing based on valid CustomerID and ProductID)
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity, TotalAmount, Status) 
VALUES 
(1, 2, '2024-03-01', 1, 800.00, 'Shipped'),
(2, 1, '2024-03-02', 2, 1600.00, 'Processing'),
(3, 4, '2024-03-03', 1, 250.00, 'Delivered'),
(4, 6, '2024-03-04', 3, 1500.00, 'Shipped'),
(5, 3, '2024-03-05', 1, 150.00, 'Cancelled'),
(6, 7, '2024-03-06', 1, 700.00, 'Delivered'),
(7, 5, '2024-03-07', 2, 1200.00, 'Processing'),
(8, 8, '2024-03-08', 1, 200.00, 'Shipped'),
(9, 9, '2024-03-09', 1, 300.00, 'Processing'),
(10, 10, '2024-03-10', 3, 900.00, 'Delivered');





-- Insert into SalesOpportunities Table
INSERT INTO SalesOpportunities (CustomerID, ProductID, ExpectedRevenue, Probability, Status, SalesRepID) VALUES
(1, 2, 800, 0.85, 'Negotiation', 1),
(2, 1, 1000, 0.90, 'Closed-Won', 2),
(3, 4, 250, 0.70, 'New', 3),
(4, 6, 500, 0.60, 'New', 4),
(5, 3, 150, 0.75, 'Negotiation', 5),
(6, 7, 700, 0.50, 'Closed-Lost', 6),
(7, 5, 600, 0.80, 'Closed-Won', 7),
(8, 8, 200, 0.65, 'New', 8),
(9, 9, 300, 0.55, 'Negotiation', 9),
(10, 10, 100, 0.95, 'Closed-Won', 10);

-- Insert into SupportTickets Table
INSERT INTO SupportTickets (CustomerID, Issue, Status, AssignedTo) VALUES
(1, 'Login issue', 'Open', 2),
(2, 'Product not received', 'In Progress', 3),
(3, 'Defective item', 'Resolved', 4),
(4, 'Payment issue', 'Open', 5),
(5, 'Account locked', 'Closed', 6),
(6, 'Refund request', 'Resolved', 7),
(7, 'Wrong item delivered', 'Open', 8),
(8, 'Technical support', 'In Progress', 9),
(9, 'Warranty claim', 'Closed', 10),
(10, 'Order cancellation', 'Resolved', 1);

-- Insert into Campaigns Table
INSERT INTO Campaigns (Name, Type, Budget, StartDate, EndDate, Status, Description) VALUES
('Spring Sale', 'Email', 5000, '2024-03-01', '2024-03-30', 'Active', 'Discounts on selected items'),
('Summer Promo', 'Social Media', 7000, '2024-06-01', '2024-06-30', 'Planned', 'Special offers for summer'),
('Black Friday', 'Advertisement', 10000, '2024-11-20', '2024-11-30', 'Planned', 'Biggest sale of the year'),
('Holiday Deals', 'Referral', 6000, '2024-12-01', '2024-12-25', 'Planned', 'Refer and earn discounts'),
('Cyber Monday', 'Email', 8000, '2024-12-02', '2024-12-03', 'Completed', 'Online deals only'),
('Back to School', 'Social Media', 4000, '2024-08-01', '2024-08-15', 'Active', 'Special discounts for students'),
('Winter Clearance', 'Advertisement', 9000, '2025-01-10', '2025-01-31', 'Planned', 'Clearance sale on winter items'),
('Valentine Special', 'Referral', 3000, '2025-02-01', '2025-02-14', 'Active', 'Gift ideas and special discounts'),
('End of Season', 'Email', 7500, '2025-03-10', '2025-03-20', 'Planned', 'Final sale of the season'),
('Exclusive Membership', 'Social Media', 5000, '2025-04-01', '2025-04-30', 'Planned', 'Exclusive deals for members');


-- Select all records from the Customers table
SELECT * FROM Customers;

-- Select all records from the Employees table
SELECT * FROM Employees;

-- Select all records from the Products table
SELECT * FROM Products;

-- Select all records from the SalesOpportunities table
SELECT * FROM SalesOpportunities;

-- Select all records from the SupportTickets table
SELECT * FROM SupportTickets;

-- Select all records from the Campaigns table
SELECT * FROM Campaigns;

-- Select all records from the Orders table
SELECT * FROM Orders;

-- WHERE Clause (Filter customers in California)

SELECT Name, City, State, Country 
FROM Customers
WHERE State = 'CA';

-- 2. GROUP BY Clause (group orders by their Status and get the total amount for each status:)

SELECT Status, SUM(TotalAmount) AS TotalAmountByStatus
FROM Orders
GROUP BY Status;


-- HAVING Clause (Filter orders with a total amount greater than 1000)

SELECT Status, SUM(TotalAmount) AS TotalAmountByStatus
FROM Orders
GROUP BY Status
HAVING SUM(TotalAmount) > 1000;




-- 5. INNER JOIN (Get details of customers with their orders)

SELECT Customers.Name, Orders.OrderDate, Orders.Quantity, Orders.TotalAmount
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 6. LEFT OUTER JOIN (Get all customers and their orders, even if they haven’t placed any)

SELECT Customers.Name, Orders.OrderDate, Orders.Quantity, Orders.TotalAmount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- 7. RIGHT OUTER JOIN (Get all orders and their respective customers, even if no customer data exists)

SELECT Orders.OrderID, Customers.Name, Orders.TotalAmount
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- 8. CROSS JOIN (Get all combinations of products and orders) with limit 

SELECT Products.Name AS ProductName, Orders.OrderID
FROM Products
CROSS JOIN Orders
LIMIT 5;


-- 9. Subquery (Non-correlated) (Get customers who have placed orders for products costing more than $500)

SELECT Name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE TotalAmount > 500
);

-- 10. Subquery (Correlated) the orders with a TotalAmount greater than the average for that specific customer:

SELECT OrderID, CustomerID, TotalAmount
FROM Orders O
WHERE TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders
    WHERE CustomerID = O.CustomerID
);


-- 11. Single Row Function (UPPER) (Get all customers' names in uppercase)

SELECT UPPER(Name) AS UpperName
FROM Customers;

-- 12. Single Row Function (CONCAT) (Get the full address of customers by combining the street, city, and state)

SELECT CONCAT(Address, ', ', City, ', ', State) AS FullAddress
FROM Customers;

-- 13. to find the orders whose Status contains a specific pattern, for example, all orders where the Status contains the word "Shipped".

SELECT OrderID, CustomerID, Quantity, TotalAmount, Status
FROM Orders
WHERE Status LIKE '%Shipped%';

-- 14. Multi-row Function (AVG) (Find the average total amount spent on orders)

SELECT AVG(TotalAmount) AS AverageAmount
FROM Orders;

-- 15. Complex Query (Join + Aggregate + HAVING) (Find sales opportunities with an expected revenue above $500, grouped by product)

SELECT Products.Name, SUM(SalesOpportunities.ExpectedRevenue) AS TotalRevenue
FROM SalesOpportunities
INNER JOIN Products ON SalesOpportunities.ProductID = Products.ProductID
GROUP BY Products.Name
HAVING SUM(SalesOpportunities.ExpectedRevenue) > 500;




