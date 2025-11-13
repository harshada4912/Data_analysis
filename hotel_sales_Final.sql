
-- ==============================================================
-- Project : Hotel Management System
-- File    : situational_queries.sql
-- Purpose : Situational SQL Queries (Questions Only)
-- ==============================================================

-- Question - 1] The accounts team wants to check payments made via UPI to measure digital adoption.
select* from payments
where PaymentMethod='UPI';
 
-- Question - 2] List all unique first names of customers for a duplicate check.
select distinct FirstName
from customers;

 
-- Question - 3] Delete all rooms with Capacity = 1. 
delete from Rooms
where Capacity =1;


-- Question - 4] Display each customer’s name and phone number together using CONCAT. 
 select concat( firstname, ' '  ,lastname)as Fullname,phone
 from customers;
 


-- Question - 5] The booking office wants to see bookings where RoomID = 10 to check utilization of a specific room. 
 select *from bookings
 where RoomID = '10' ;
 
 
-- Question - 6] Identify rooms whose Capacity is greater than the average Capacity of all rooms. -- (Rooms subquery) 
select avg(capacity)from rooms;

select * from Rooms
where capacity >(select avg(Capacity)from rooms);

-- Question - 7] Create a VIEW StaffContact showing Staff FirstName, LastName, Role, and Phone.
Create VIEW StaffContact as 
select FirstName, LastName,Role,Phone
from staff;



-- Question - 8] The receptionist wants to offer Suite rooms under ₹7000 to business travelers. 
select *from rooms
where RoomType='Suite' and PricePerNight='7000';


-- Question - 9] The admin wants to see email addresses sorted by LastName from the Customers table
select  email
from customers
order by LastName;


-- Question - 10] Show staff full names combined into one column. 
select concat(firstname, ' ', lastname)as fullname
from Staff;

 -- Question - 11] Display all payment details in one line using CONCAT_WS. 
SELECT CONCAT_WS(' | ',PaymentID,BookingID,DATE_FORMAT(PaymentDate, '%Y-%m-%d'),PaymentMethod,Amount) AS PaymentSummary
FROM Payments;

 
-- Question - 12] The hotel wants to display the 2 most expensive rooms for VIP guests. 

select  *from rooms
order by PricePerNight desc
Limit 2;
-- Question - 13] Show each BookingID with its CheckIn and CheckOut dates combined.
select BookingID, concat (CheckInDate,'' ,CheckOutDate)as stayperiod
from  Bookings;

-- Question - 14] Finance wants to calculate the average Amount per PaymentMethod. 
select PaymentMethod,avg(Amount) as avgamount
from payments
group by PaymentMethod;



-- Question - 15] The analytics team wants to find the city where average CustomerID is greater than 50.
 select city 
 from customers
 group by city
 having avg (customerID)>50;
 
 
-- Question - 16] Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery) 
select avg(TotalAmount)from bookings;

select *from bookings
where TotalAmount>(select avg(TotalAmount)from bookings);


-- Question - 17] Display the last 2 added rooms from the Rooms table. 
select *from rooms
order by RoomID desc
limit 2;

--- Question - 18] The cashier wants a report of payments where Amount < ₹1500 for small transactions. 
select* from payments
where Amount < '1500';

-- Question - 19] Management wants to list all customers who have made more than 5 bookings. 
SELECT * 
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Bookings
    GROUP BY CustomerID
    HAVING COUNT(CustomerID) > 5
);

SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(b.CustomerID) AS TotalBooking
FROM customers c
JOIN bookings b
ON c.CustomerID = b.CustomerID
GROUP BY b.CustomerID,c.FirstName, c.LastName
HAVING TotalBooking > 5;


-- Question - 20] Identify customers who live in the same city. (Customers self join) 
SELECT c1.FirstName, c1.LastName, c1.City,
       c2.FirstName AS OtherFirstName, c2.LastName AS OtherLastName
FROM Customers c1
JOIN Customers c2 
    ON c1.City = c2.City 
    AND c1.CustomerID <> c2.CustomerID
ORDER BY c1.City;

-- Question - 21] Show the total revenue handled by each StaffID. 
select StaffID, sum(TotalAmount) as totalrevenue
from bookings
group by StaffID;





-- Question - 22] The manager wants to see all customers from Mumbai to check city-wise marketing campaigns. 
select *from customers
where city='mumbai';


-- Question - 23] Display the 3 lowest booking amounts. 
select *from bookings
order by totalamount asc
limit 3;


-- Question - 24] Insert 5 new room records with type, price, and capacity into the Rooms table. 
INSERT INTO Rooms (RoomType, PricePerNight, Capacity) VALUES
('double',55677,3),
('suite',67778,2),
('single',3444,1),
('dulex',2345,2),
('double',46588,3);

-- Question - 25] Show all unique CustomerIDs from bookings. 
select distinct CustomerID
from customers;

-- Question - 26] Create a trigger to automatically delete a payment when its corresponding booking is deleted. 



-- Question - 27] The marketing team wants to update the FirstName of CustomerID = 30 to 'Rahul'. 
update Customers
set FirstName="rahul"
where CustomerID = 30;

-- Question - 28] List all bookings ordered by CheckInDate. 
select *from bookings
order by CheckInDate;


-- Question - 29] Show all rooms where capacity is greater than 2. 
select*  from rooms
where capacity>2;


-- Question - 30] List staff emails ordered by their roles.
select email
from staff
order by role;


-- Question 31] Display each customer’s full name and city using CONCAT_WS. 
  select CONCAT_WS('' , firstname, lastname) As fullname,city 
  from customers;
  
-- Question 32] Show the first 4 customers’ full names only. 
select concat( firstname, '' ,lastname) as fullname
from customers
limit 4;

-- Question - 33] Show each staff’s role with their full name. 
SELECT Role,
       CONCAT(FirstName, ' ', LastName) AS FullName
FROM Staff;

-- Question - 34] Management wants to find the average StaffID per role. 
   select Role,
           avg(StaffID) as avgStaffID
   from staff
   group by Role;
   
-- Question - 35] List all bookings handled by StaffID = 2. 
select *from Staff
where StaffID= 2;


-- Question - 36] Display the first 3 staff alphabetically by their first names. 
select *from staff
order by FirstName asc
limit 3;


-- Question - 37] The front desk manager wants to see customers where FirstName = 'Amit' AND  City = 'Nagpur' for personal attention. 
select*from customers
where FirstName = 'Amit'AND  City = 'Nagpur';


-- Question - 38] Show all unique payment methods in descending order. 
select distinct PaymentMethod
from payments
order by PaymentMethod desc;

-- Question - 39] Insert 5 staff members into the Staff table with their role, phone, and email.
    INSERT INTO Staff(FirstName, LastName, Role, Phone, Email) VALUES
('Arjun', 'Mehta', 'Receptionist', '9123456780', 'arjun.mehta@hotel.com'),
('Riya', 'Sharma', 'Chef', '9876543210', 'riya.sharma@hotel.com'),
('Karan', 'Patel', 'Waiter', '9988776655', 'karan.patel@hotel.com'),
('Simran', 'Kaur', 'Manager', '9090909090', 'simran.kaur@hotel.com'),
('Vivek', 'Nair', 'Security', '9191919191', 'vivek.nair@hotel.com');

 -- Question - 40] The hotel manager wants to review bookings where CheckInDate is after '2024-01-01' to analyze recent occupancy. 

select *from bookings
where CheckInDate > '2024-01-01'
order by CheckInDate;

-- Question - 41] List all customers whose FirstName is 'Rahul' for a loyalty program. 
select *from  customers
where  FirstName ='Rahul';

-- Question - 42] Show all unique room types offered by the hotel.ups. 
select distinct RoomType
from Rooms;


-- Question - 43] Identify customers who spent more than 50,000 in total. 
select *from customers;


-- Question - 44] Delete all customers from the city 'TestCity'. 
delete from Customers
where city ='TestCity';

-- Question - 45] Find rooms that have the same PricePerNight. (Rooms self join) 
select *from rooms;


-- Question - 46] The manager wants to see staff whose Email ends with '@tcs.in' for corporate tie
select *from Staff
where Email like"%@tcs.in" ;


-- Question - 47] The analytics team wants to list all cities where maximum CustomerID is more than 100. 
select city ,max(CustomerID) as MaxId
from customers
group by city
having max(CustomerID)>100;

-- Question - 48] Show all unique capacities in descending order. 
select distinct capacity
from rooms
order by capacity  DESC;

-- Question - 49] List staff working as Managers. Abhishek Sudarshan Wavhal [Sep 2025]    
select *from staff
where Role="manger";

-- Question - 50] Display each payment’s ID, Method, Amount in one line. 
select CONCAT_WS ('    |   '   , PaymentID,  PaymentMethod, Amount )as paymentsummary from payments;

-- Question - 51] Show the first 4 payments only. 
select*from payments
limit 4;

-- Question - 52] The hotel manager wants to review rooms where PricePerNight is between ₹2000 and ₹4000 to offer discounts. 
select *from rooms
where PricePerNight between 2000 and 4000 ;

-- Question - 53] List all bookings ordered by CheckInDate. 
select *from bookings
order by  CheckInDate;

-- Question - 54] Display all unique CustomerIDs from bookings. 
select distinct CustomerID
from bookings;


-- Question - 55] The hotel manager wants to add new customer details. Insert 5 records with full details into the Customers table. 
INSERT INTO Customers (FirstName, LastName, Email, Phone, City) VALUES
('Rahul', 'Patil', 'rahul.patil@hotel.com', '9001112233', 'Pune'),
('Sneha', 'Joshi', 'sneha.joshi@hotel.com', '9001112234', 'Mumbai'),
('Vikas', 'Sharma', 'vikas.sharma@hotel.com', '9001112235', 'Delhi'),
('Neha', 'Kapoor', 'neha.kapoor@hotel.com', '9001112236', 'Chennai'),
('Arjun', 'Reddy', 'arjun.reddy@hotel.com', '9001112237', 'Hyderabad');



-- Question - 56] Show the last 2 staff hired. 
select* from staff
order by StaffID desc
limit 2;

-- Question - 57] Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery) 
select max(PricePerNight) from rooms;

select *From rooms
where Capacity >(select max(PricePerNight) as max from rooms
where Capacity = 2);


-- Question - 58] The HR team wants to see staff whose Role is not 'Chef' for role reallocation. 
select * from staff
where Role != "chef";

-- Question - 59] Show all unique cities in descending order from the Customers table. 
select distinct city
from customers
order by  city desc;

-- Question - 60] Display the phone number of the Waiter only. 
 select * from staff
 where Role=" Waiter";
 
 
 -- Question - 61] Display the last 2 bookings in the table. targeted promotions. 
 select *from  bookings
 order by BookingID  desc
 limit 2;
 
-- Question - 62] The marketing team wants to see customers living in Delhi or Chennai for 
select *from customers
where city  in('Delhi','Chennai');

-- Question - 63] Show all rooms where RoomType != 'Family' to plan renovations. 
select *from rooms
where RoomType != 'Family';


-- Question - 64] List staff emails ordered by their roles. 
select * from staff
order by Role;

-- Question - 65] Display all unique payment methods. 
select distinct PaymentMethod
from payments;

-- Question - 66] The receptionist wants a list of customers whose Phone starts with '98' for mobile offers. 
select *from customers
where phone like "98%";

-- Question - 67] Show the 3 cheapest rooms available for budget travelers.
select * from rooms
order by(PricePerNight) asc
limit 3;

-- Question - 68] Display the last 2 payments. 
select * from payments
order by paymentID desc
limit 2;

-- Question - 69] Management wants to know which unique cities customers come from. 
select distinct city
from customers;

-- Question - 70] List all bookings where TotalAmount > 5000. 
select *from bookings
where TotalAmount > 5000;

-- Question - 71] Display each staff’s Role with their Email in one column. 
select concat(' role ' ,' ','Email ' )as Roleemail
from staff;

-- Question - 72] Show the first 4 staff full names. 
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Staff
LIMIT 4;




-- Question - 73] Find bookings where TotalAmount is greater than all bookings made by CustomerID = 10. (Bookings subquery) 
select max(TotalAmount)from bookings;

select *from bookings
where TotalAmount>(select max(TotalAmount)from bookings
where CustomerID = 10 );

-- Question - 74] List rooms with capacity >= 3 for family bookings. 
 select *from rooms
 where capacity >= 3;
 

-- Question - 75] Display the RoomType and Price of only Suite rooms. 
select RoomType,PricePerNight
from  rooms
where RoomType="suite";


-- Question - 76] The cashier wants to see payments with Amount between ₹2000 and ₹7000 for mid-range billing checks. 
select *from payments
where amount between 2000 and 7000;



-- Question - 77] Insert 5 booking records into the Bookings table with all details. 
INSERT INTO Bookings (CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount) VALUES
(1, 5, 2, '2025-10-01', '2025-10-05', 12000),
(2, 8, 3, '2025-11-02', '2025-11-06', 15000),
(3, 10, 4, '2025-12-10', '2025-12-12', 8000),
(4, 12, 5, '2025-09-20', '2025-09-23', 9500),
(5, 14, 6, '2025-08-01', '2025-08-04', 11000);


-- Question - 78] Display the 3 lowest payments made by customers. 
select *from payments
order by Amount asc
limit 3;

-- Question - 80] Show all unique RoomIDs in descending order. study. 
select distinct RoomID
from rooms
order by RoomID desc;


-- Question - 79] Show each booking’s BookingID with TotalAmount using CONCAT. 
select concat('booking',     BookingID,      -'TotalAmount') as bookinginfo
from bookings;


-- Question - 81] Display each room’s RoomType and Price using CONCAT_WS. 
select CONCAT_WS(' |  '     ,RoomType,  PricePerNight)as roominfo
from rooms;



-- Question - 82] The admin wants to delete all bookings handled by StaffID = 3.
select *from bookings
where StaffID = 3;
 
-- Question - 83] Show customers whose FirstName length > 5 characters for a name-pattern 
select *from customers
where  length(FirstName) >5;



-- Question - 84] Show all unique roles available in the hotel. 
select distinct Role
from staff;


-- Question - 85] List all rooms where capacity is greater than 2. 
select *from rooms
where capacity>2;

-- Question - 86] Display each payment’s ID with Amount using CONCAT.
select CONCAT('PaymentID'," ",'Amount ') as paymentinfo
from payments;

-- Question - 87] List all Card payments from the Payments table.
select *From payments
where PaymentMethod='card';

-- Question - 88] Delete all customers whose Email ends with '@test.com' as invalid. 
delete from  customers
where Email like'%@test.com';


-- Question - 89] The hotel manager wants to review bookings where CheckOutDate before '202312-31' to measure old occupancy. 
select *from bookings
where CheckOutDate <'2023-12-31';

-- Question - 90] The front office manager needs to list rooms with capacity = 2 for couples. 
select *from rooms
where capacity = 2 ;

-- Question - 91] Show all unique capacities in descending order. 
select distinct capacity
from rooms
order by capacity desc;

-- Question - 92] The operations team wants to find the minimum TotalAmount in bookings. 
select  min( TotalAmount)as TotalAmount
from bookings;

-- Question - 93] Display all rooms by capacity in ascending order.
select *from rooms
order by capacity asc;

-- Question - 94] Show each booking’s BookingID with TotalAmount using CONCAT. 
select CONCAT('BookingID',  '' ,'TotalAmount ')as bookingsinfo
from bookings;

-- Question - 95] The operations head wants to see rooms with Capacity = 4 AND PricePerNight > ₹6000 for premium family packages.
select *from rooms
where Capacity = 4 AND PricePerNight > 6000;

 
-- Question - 96] Show staff full names combined into one column.
select concat(firstname , '  ' , lastname)as Fullname
from staff;


 
-- Question - 97] The accounts team wants to see bookings where the TotalAmount is greater than ₹10,000 to track high-value customers. 
select *from bookings
where TotalAmount >10000;

-- Question - 98] Show all unique payment methods in descending order. JOIN between Customers and Bookings. 
select distinct PaymentMethod 
from payments
order by PaymentMethod desc;


-- Question - 99] List staff members who share the same Role. (Staff self join) 
SELECT a.FirstName AS StaffA, b.FirstName AS StaffB, a.Role
FROM Staff a
JOIN Staff b ON a.Role = b.Role AND a.StaffID < b.StaffID;


-- Question - 100] Show customer first name, last name, and TotalAmount of their bookings using 
select c.firstname,c.lastname,b.TotalAmount
from customers c
join bookings b on c.customerID= b.customerID;


-- Question - 101] Display the first 4 bookings only. 
select *from bookings
limit 4;


-- Question - 102] Show all unique staff first names. 
select distinct FirstName
from staff;

-- Question - 103] Insert 5 new room records with type, price, and capacity into the Rooms table.
INSERT INTO rooms (RoomType, PricePerNight, Capacity) VALUES
('Economy', 1500.00, 1),
('Deluxe Twin', 3200.00, 2),
('Family Suite', 7000.00, 4),
('Executive Suite', 8500.00, 2),
('Presidential Suite', 12000.00, 5);

 
-- Question - 104] Display each customer’s full name and city using CONCAT_WS. 
select CONCAT_WS(' ',  FirstName,Lastname)AS fullname,city
from customers;



-- Question - 105] Show all unique cities in descending order from the Customers table.
select distinct city
from customers
order by city desc;

 
-- Question - 106] The analytics team wants to list all cities where maximum CustomerID is more 100
select city ,max(customerId) as customerId
from customers
group by city
having max(customerId) >100 ;


-- Question - 107] The HR team wants to see staff whose FirstName is 'Priya' for employee recognition. 
select *from staff
where FirstName ='Priya';


-- Question - 108] Display the last 2 staff members from the Staff table. 
select *from staff
order by StaffID desc
limit 2;

-- Question - 109] Create a VIEW BookingSummary showing BookingID, CustomerID, RoomID, and TotalAmount. 
CREATE OR REPLACE VIEW BookingSummary AS
SELECT BookingID, CustomerID, RoomID, TotalAmount
FROM Bookings;

-- Question - 110] Show all unique RoomIDs in descending order.
   select distinct roomID
   from rooms
   order by roomID;
   
   
-- Question - 111] Display each staff’s role with their full name. 
select role ,CONCAT(Firstname,'' ,lastname) as fullname
from staff;

-- Question - 112] The receptionist wants to offer Suite rooms under ₹7000 to business travelers.
select*from rooms
where RoomType='Suite' and PricePerNight < 7000;
 
-- Question - 113] Display the first 3 staff alphabetically by their first names.
select *from staff
order by FirstName desc
limit 3;

 
-- Question - 114] List all bookings ordered by CheckInDate. 
select *from bookings
order by CheckInDate;

-- Question - 115] Show all unique StaffIDs from the bookings. 
select distinct StaffID
from bookings;

-- Question - 116] Display the first 4 customers’ full names only. 
select *from customers
order by Firstname desc
limit 4;



-- Question - 117] Show all unique room types offered by the hotel. 
select distinct RoomType
from rooms;

-- Question - 118] Display the phone number of the Waiter only. 
select phone
from staff
where role ='Waiter';

-- Question - 119] Show all bookings where TotalAmount > 5000. 
select*from bookings
where TotalAmount > 5000;

-- Question - 120] The HR team wants to update Role = 'Senior Manager' where StaffID = 12. 
update staff 
set Role = 'Senior Manager'
where StaffID = 12;

-- Question - 121] List all staff working as Managers. 
select*from staff
where Role='mangers' ;

-- Question - 122] Show the last 2 registered customers for follow-up. 
select *from customers
order by CustomerID desc
limit 2;


-- Question - 123] Display each booking’s BookingID with TotalAmount using CONCAT. 
select concat(BookingID ,'',TotalAmount)as bookinginfo
from bookings;

-- Question - 124] Insert 5 staff members into the Staff table with their role, phone, and email. 
INSERT INTO Staff (FirstName, LastName, Role, Phone, Email) VALUES
('Anita', 'Deshmukh', 'Receptionist', '9001234567', 'anita.deshmukh@hotel.com'),
('Rohit', 'Verma', 'Manager', '9002345678', 'rohit.verma@hotel.com'),
('Pooja', 'Singh', 'Chef', '9003456789', 'pooja.singh@hotel.com'),
('Aman', 'Khan', 'Waiter', '9004567890', 'aman.khan@hotel.com'),
('Kavita', 'Iyer', 'Security', '9005678901', 'kavita.iyer@hotel.com');

-- Question - 125] Display the RoomType and Price of only Suite rooms. 
select RoomType,PricePerNight
from rooms
where RoomType='suite';

-- Question - 126] The admin wants to delete all payments linked to BookingID = 15.
delete from payments
where  BookingID = 15;


-- Question - 127] Display all unique capacities in descending order. 
select distinct capacity
from rooms
order by capacity desc;


-- Question - 128] Show the first 4 rooms sorted alphabetically by RoomType. 
select *from rooms
order by RoomType asc
limit 4;

-- Question - 129] The cashier wants a report of payments where Amount < ₹1500 for small transactions. 
select*from payments
where amount <15000;


-- Question - 130] Show each booking’s BookingID with TotalAmount using CONCAT.
select CONCAT ( BookingID,' ', TotalAmount) as bookinginfo
from bookings;

 
-- Question - 131] Display the last 2 added rooms from the Rooms table. 
select *from rooms
order by RoomID desc
limit 2;


-- Question - 132] List all customers whose FirstName = 'Amit' AND City = 'Nagpur' for personal attention. 
select*from customers
where FirstName = 'Amit'  AND City = 'Nagpur';

-- Question - 133] Insert 5 new customer details into the Customers table. 
INSERT INTO Customers (FirstName, LastName, Email, Phone, City) VALUES
('Amit', 'Kulkarni', 'amit.kulkarni@hotel.com', '9011111111', 'Nagpur'),
('Priya', 'Menon', 'priya.menon@hotel.com', '9022222222', 'Bangalore'),
('Suresh', 'Gupta', 'suresh.gupta@hotel.com', '9033333333', 'Delhi'),
('Ritika', 'Shah', 'ritika.shah@hotel.com', '9044444444', 'Mumbai'),
('Arun', 'Nair', 'arun.nair@hotel.com', '9055555555', 'Chennai');

-- Question - 134] Show staff full names combined into one column. 
select  concat( Firstname,' ' ,lastname)as fullname
from staff;

-- Question - 135] Show all room details separated by commas using CONCAT_WS. 
select CONCAT_WS('  ',RoomID ,RoomType,PricePerNight, Capacity)as roomdetails
from rooms;


-- Question - 136] Display each customer’s name and phone number together using CONCAT. 
select CONCAT(FirstName,'',Phone)ascustomerdetails
from customers;

-- Question - 137] Display all payment details in one line using CONCAT_WS. 
select CONCAT_WS('', PaymentID, BookingID, PaymentDate, PaymentMethod ,Amount)as paymentsdetails
from payments;


-- Question - 138] Show the last 2 bookings in the table. 
select *from bookings
order by bookingId desc
limit 2;

-- Question - 139] List all payments ordered by PaymentDate. 
select *from payments
order by PaymentDate;

-- Question - 140] Show the 2 highest payments received. loyalty program. 
select  *from payments
order by amount desc
limit 2;

-- Question - 141] The marketing team wants to check customers whose FirstName is 'Rahul' for a 
select *from customers
where FirstName ='Rahul';

-- Question - 142] Display each PaymentID with its method using CONCAT. 
select concat('PaymentID:' , paymentId   ,'-method:'  ,paymentMethod  )AS paymentInfo
from Payments;

-- Question - 143] The operations team wants to list all PaymentMethods used more than 5 times. 
select PaymentMethod,count(*)
from payments
group by paymentmethod
having count(*);


-- Question - 144] Show the 2 most expensive rooms for VIP guests. 
SELECT *FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 2;


-- Question - 145] Show each room’s RoomType and Price using CONCAT_WS. 
select CONCAT_WS('|', roomtype, PricePerNight) as roominfo
from rooms;

-- Question - 146] Display the first 3 staff alphabetically by their first names. 
select  FirstName,Lastname,Role,phone,Email
from staff
order by FirstName desc
limit 3;


-- Question - 147] List all bookings handled by StaffID = 2. 
select *from bookings
where StaffID = 2;

-- Question - 148] The analytics team wants to find the city where average CustomerID is greater than 50. 
select city
from customers
group by city
having avg(CustomerID)>50;



-- Question - 149] The hotel wants to display the 2 most expensive rooms for VIP guests. 
select *from rooms
order by price desc
limit 2;

-- Question - 150] Show all unique first names of customers for a duplicate check. 
select distinct Fisrtname
from customers;


-- Question - 151] Show all unique roles in descending order. 
select distinct role
from staff
order by role desc;


-- Question - 152] Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery) 
select avg(Capacity) from rooms;

select *from rooms
where capacity >(select avg(Capacity) from rooms);


-- Question - 153] Display all rooms by capacity in ascending order. 
select  *from rooms
order by  capacity asc;


-- Question - 154] Display the first 4 payments only. 
select *from payments
limit 4;

-- Question - 155] Show each payment’s ID, Method, Amount in one line. 
select  concat(paymentId, '-',paymentmethod,'-' ,Amount) as paymentdetails
from payments;


-- Question - 156] List all bookings where TotalAmount > 5000. (Customers subquery) reallocation. ₹10,000. 
select *from bookings
where TotalAmount > 5000;

-- Question - 157] Find all customers whose CustomerID is greater than the average CustomerID. 
SELECT AVG(CustomerID) FROM Customers;

select *from customers
where CustomerID >(SELECT AVG(CustomerID) FROM Customers);


-- Question - 158] The HR manager wants to see staff whose Role is not 'Chef' for role 
select*from staff
where role='Chef';

-- Question - 159] The accounts team wants to check bookings where TotalAmount is greater than 
select *from bookings
where TotalAmount>1000;


-- Question - 160] Display each staff’s role with their full name. 
select concat(firstname,'' ,Lastname)as fullname
from staff;

-- Question - 161] List staff members who share the same Role. (Staff self join) 
SELECT s1.StaffID, s1.FirstName, s1.LastName, s1.Role, s1.Phone, s1.Email, s2.StaffID, s2.Role 
FROM staff s1
JOIN staff s2
ON s1.StaffID = s2.StaffID
   AND s1.Role = s2.Role;




-- Question - 162] Show Customer Name and Payment Amount by joining Customers, Bookings, and Payments. 
select concat(c.Firstname,'  ' ,c.Lastname) as fullname,p.amount as paymentamount
from customers c
join bookings b on c.CustomerId= b. CustomerId
join payments p on b.bookingID= b.bookingId;


-- Question - 163] Display all bookings where TotalAmount > 5000.
select bookingID,CustomerID,RoomID ,StaffID,CheckInDate,CheckOutDate,TotalAmount
from bookings
where TotalAmount > 5000;

-- Question - 164] The front desk wants to see customers whose Phone starts with '98'. 
select *from customers
where Phone like'%98';

-- Question - 165] Identify customers who live in the same city. (Customers self join) 
SELECT c1.CustomerID AS Customer1, c1.FirstName AS FirstName1, 
       c2.CustomerID AS Customer2, c2.FirstName AS FirstName2, 
       c1.City
FROM Customers c1
JOIN Customers c2 ON c1.City = c2.City AND c1.CustomerID < c2.CustomerID;

-- Question - 166] The operations manager wants to check bookings with CheckOutDate before '2023-12-31'. 
select  BookingID,CustomerID,RoomID ,StaffID,CheckInDate,CheckOutDate,TotalAmount
from bookings
where CheckOutDate <'2023-12-31';

-- Question - 167] Display all unique StaffIDs from the bookings. 
select distinct staffId
from bookings;

-- Question - 168] Create a VIEW OnlinePayments showing all payments made by PaymentMethod = 'Online'. 
CREATE VIEW OnlinePayments AS
SELECT * FROM payments
WHERE PaymentMethod = 'Online';


-- Question - 169] Display all unique payment methods in descending order. 
select distinct paymentmethod 
from payments
order by  paymentmethod desc; 

-- Question - 170] Display each payment’s ID with Amount using CONCAT. 
select concat( paymentID, '-' ,amount) As paymentinfo
from payments;


-- Question - 171] Show all unique RoomIDs in descending order. 
select distinct RoomID
from rooms
order by RoomId desc;

-- Question - 172] The analytics team wants to list all cities where maximum CustomerID is more than 100. 
SELECT City
FROM Customers
GROUP BY City
HAVING MAX(CustomerID) > 100;


-- Question - 173] List staff emails ordered by their roles. (Bookings subquery) recommendations. 
select email,role
from staff
order by role;

-- Question - 174] Find bookings where TotalAmount exceeds the average TotalAmount. 
select avg(TotalAmount )from bookings;

select*from bookings
where  totalamount> (select avg(TotalAmount )from bookings);

-- Question - 175] Show all rooms where PricePerNight > ₹5000 for premium customer 
select *from rooms
where PricePerNight >5000;

-- Question - 176] Show all unique capacities in descending order. 
select distinct capacity
from rooms
order by capacity desc;

-- Question - 177] Display the first 4 rooms sorted alphabetically by RoomType. 
select *from rooms
order by roomType asc
limit 4;

-- Question - 178] Show all unique staff first names. 
select distinct firstname
from staff;


-- Question - 179] Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery) 
select max(PricePerNight)from rooms;

select*from rooms
where PricePerNight> (select max(PricePerNight)from rooms
where Capacity= 2);

-- Question - 180] Show all unique cities in descending order from the Customers table.
select distinct city
from customers
order by city desc;

-- Question - 181] List all bookings where TotalAmount > 5000. 
select *from  bookings
where TotalAmount > 5000;

-- Question - 182] Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.
select p.paymentID, concat(c.Fisrtname,' ',c.lastname) as customername,b.bookingId
FROM Payments p
JOIN Bookings b ON p.BookingID = b.BookingID
JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE p.PaymentMethod = 'Credit Card';
 
-- Question - 183] Display each booking’s BookingID with TotalAmount using CONCAT. 
select concat(BookingID,'-', totalamount) as bookingsinfo
from bookings;

-- Question - 184] Show all bookings handled by StaffID = 2. 
select*from bookings
where StaffId=2;

-- Question - 185] Display the last 2 added rooms from the Rooms table. 
select *from rooms
order by RoomID desc
limit 2;

-- Question - 186] List all rooms where capacity is greater than 2.
select*from rooms
where capacity > 2;


-- Question - 187] Display the last 2 staff members from the Staff table. 
select *from staff
order by staffId desc
limit 2;

-- Question - 188] Show all unique roles available in the hotel. 
select distinct role
from rooms;

-- Question - 189] Display the last 2 payments. 
select *from payments
order by PaymentID desc
limit 2;
 
-- Question - 190] The manager wants to see bookings where CustomerID IN (2,4,6,8) to track repeat guests. 
select *from bookings
where customerID IN (2,4,6,8);

-- Question - 191] Show all unique first names of customers for a duplicate check.
select distinct Firstname
from customers;


-- Question - 192] Display all bookings where TotalAmount > 5000. 
select *from bookings
where TotalAmount > 5000;


-- Question - 193] The admin wants to delete all payments where Amount < 1000. 
delete from payments
where Amount < 1000;

-- Question - 194] Display all unique RoomIDs in descending order. 
select distinct RoomId
from rooms
order by RoomId desc;


-- Question - 195] List customers who made more than 5 bookings. 
select customerID,count(*) AS bookingsinfo
from bookings
group by customerID
having count(*)>5 ;

-- Question - 196] Display all rooms by capacity in ascending order. 
select *from rooms
order by capacity asc;


-- Question - 197] Show each booking’s BookingID with TotalAmount using CONCAT. 
select concat( BookingID,  '-'  ,TotalAmount)as bookinginfo
from bookings;


-- Question - 198] List all staff working as Managers. 

select *from staff
where role="manger";

-- Question - 199] Show customers whose FirstName length > 5 characters for a name-pattern study. 
select *from  customers
where length (FirstName)> 5;

-- Question - 200] Display all unique capacities in descending order.      
select distinct capacity
from rooms
order by capacity desc;
  
-- Question - 201] List staff members who share the same Role. (Staff self join) 
SELECT s1.StaffID AS Staff1_ID, s1.FirstName AS Staff1_Name,
       s2.StaffID AS Staff2_ID, s2.FirstName AS Staff2_Name,
       s1.Role
FROM Staff s1
JOIN Staff s2 ON s1.Role = s2.Role AND s1.StaffID < s2.StaffID;

-- Question - 202] Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'. 
SELECT p.PaymentID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, p.BookingID
FROM Payments p
JOIN Bookings b ON p.BookingID = b.BookingID
JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE p.PaymentMethod = 'Credit Card';

-- Question - 203] Display the first 4 payments only.
 select *from payments
 limit 4;
 
-- Question - 204] Show each payment’s ID, Method, Amount in one line. 
select concat( PaymentID,  '-' ,PaymentMethod, Amount)AS bookingsinfo
from payments;

-- Question - 205] Create a VIEW HighValueBookings showing all bookings with TotalAmount > 20,000. 
create view HighValueBookings AS
select *from bookings
where TotalAmount> 20000;

-- Question - 206] Create a trigger to automatically delete a payment when its corresponding booking is deleted. 
DELIMITER //

CREATE TRIGGER trg_DeletePaymentAfterBooking
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    DELETE FROM Payments
    WHERE BookingID = OLD.BookingID;
END;
//

DELIMITER ;

-- Question - 207] Create a trigger to prevent insertion of a booking where CheckOutDate < CheckInDate. 
DELIMITER //

CREATE TRIGGER trg_PreventInvalidBooking
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
    IF NEW.CheckOutDate < NEW.CheckInDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CheckOutDate cannot be before CheckInDate';
    END IF;
END;
//

DELIMITER ;



-- Question - 208] Create a trigger to automatically update TotalAmount in Bookings when a payment is inserted in Payments.

DELIMITER //

CREATE TRIGGER trg_UpdateTotalAmountAfterPayment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    UPDATE Bookings
    SET TotalAmount = TotalAmount + NEW.Amount
    WHERE BookingID = NEW.BookingID;
END;
//

DELIMITER ;
