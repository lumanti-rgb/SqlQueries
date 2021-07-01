create database ecommerce;
use ecommerce;
select * from customer;

select * from product;

--Select all products with brand “Cacti Plus”
select product_name from product 
where brand='Cacti Plus';

--Count of total products with product category=”Skin Care”
select count(*) as "No. of products" from product 
where category='Skin Care'

--Count of total products with MRP more than 100
select count(*) as "No. of products" from product 
where mrp>100;

--Count of total products with product category=”Skin Care” and MRP more than 100
select count(*) as "No. of products" from product 
where category='Skin Care' and mrp>100;

--Brandwise product count
select count(*) as "No. of products" from product 
group by brand;

--Brandwise as well as Active/Inactive Status wise product count
select
sum(case when active='Y' then 1 else 0 end) as "active",
sum(case when active='N' then 0 else 1 end) as "inactive",count(*) as "No. of products" from product 
group by brand;

--Display all columns with Product category in Skin Care or Hair Care
select * from product
where category='Skin Care' or category= 'Hair Care';

--Display all columns with Product category in Skin Care or Hair Care, and MRP more than 100
select * from product
where mrp>100 AND (category='Skin Care' OR category='Hair Care');

--Display   all   columns   with   Product   category=”Skin   Care”   and Brand=”Pondy”, and MRP more than 100
select * from product
where mrp>100 AND (category='Skin Care' AND brand='Pondy');

--Display   all   columns   with   Product   category   =”Skin   Care”   or Brand=”Pondy”, and more than 100
select * from product
where mrp>100 AND (category='Skin Care' or brand='Pondy');

--Display all product names only with names starting from letter P
select product_name from product where product_name like 'P%';

--Display  all product  names only with names Having letters “Bar”  in Between
select product_name from product where product_name like '%Bar%';

--Sales of those products which have been sold in more than two quantity in a bill
select * from sales 
where qty>2;

--Sales of those products which have been sold in more than two quantity throughout the bill
select product_id, sum(qty) quantity from sales
group by product_id
having sum(qty)>2;

--Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.

create table info(
name varchar(30),
birthdate date
);

BULK INSERT dbo.info
FROM 'C:\Users\ACER\Downloads\dates.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR ='\n'
)

select * from info;

--After populating the data, find no of people sharing Birth date, Birth month,Weekday

select count(name) from info 
where birthdate IN(
select birthdate from info group by birthdate 
having count(birthdate)>1
);


--Find the current age of all people
select *, DATEDIFF(year, birthdate, GETDATE()) Age from info