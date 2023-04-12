use sample1;
--CREATE TABLE [dbo].[int_orders](
-- [order_number] [int] NOT NULL,
-- [order_date] [date] NOT NULL,
-- [cust_id] [int] NOT NULL,
-- [salesperson_id] [int] NOT NULL,
-- [amount] [float] NOT NULL
--) ON [PRIMARY]
--GO
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST(N'1995-07-14' AS Date), 9, 1, 460)
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST(N'1996-08-02' AS Date), 4, 2, 540)
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST(N'1998-01-29' AS Date), 7, 2, 2400)
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST(N'1998-02-03' AS Date), 6, 7, 600)
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST(N'1998-03-02' AS Date), 6, 7, 720)
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST(N'1998-05-06' AS Date), 9, 7, 150)
--INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST(N'1999-01-30' AS Date), 4, 8, 1800);

SELECT * FROM int_orders;

-- As we can not get rest of the columns if we use the group by clause. So we use over() clause.
SELECT order_number,order_date,salesperson_id, amount,SUM(amount) OVER () AS sales_sum
FROM int_orders;

--If we want sales person wise sales then use partition by
SELECT order_number,order_date,salesperson_id, amount,SUM(amount) OVER(PARTITION BY salesperson_id) AS sales_by_person
FROM int_orders;

-- ORDER BY is optional for aggregate window functions
-- ORDER BY is mandatory for ranking window functions

SELECT order_number,order_date,salesperson_id, amount, SUM(amount) OVER( ORDER BY salesperson_id) AS running_sum
FROM int_orders;

-- ORDER BY is used to get the running sum
-- Not as expected
-- Above we do not get running sum as column in order by does not have distinct values

SELECT order_number,order_date,salesperson_id, amount,SUM(amount) OVER (ORDER BY order_date) AS running_sum
FROM int_orders;

-- To get running sum within sales persons
SELECT order_number,order_date,salesperson_id, amount,SUM(amount) OVER(PARTITION BY salesperson_id ORDER BY order_date) AS part_sum
FROM int_orders;


