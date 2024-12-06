-- Patrick MacDonald, Jansen Agcaoili, Bijoy Roy, Ethan Pelletier

-- Sample Data

USE SKS_National_Bank
GO




INSERT INTO Address
	(City_Name, Province_Name, Street_Number, Street_Name, Appt_Number)
VALUES
	('New York', 'NY', 123, '5th Ave', '1A'),
	('Los Angeles', 'CA', 456, 'Sunset Blvd', '2B'),
	('Chicago', 'IL', 789, 'Michigan Ave', '3C'),
	('Houston', 'TX', 101, 'Main St', '4D'),
	('Phoenix', 'AZ', 202, 'Central Ave', '5E'),
	('Philadelphia', 'PA', 303, 'Market St', '6F'),
	('San Antonio', 'TX', 404, 'Broadway', '7G'),
	('San Diego', 'CA', 505, 'Ocean Blvd', '8H'),
	('Dallas', 'TX', 606, 'Elm St', '9I'),
	('San Jose', 'CA', 707, 'Santa Clara St', '10J'),
	('Austin', 'TX', 808, 'Congress Ave', '11K'),
	('Jacksonville', 'FL', 909, 'Bay St', '12L'),
	('Fort Worth', 'TX', 1010, 'Main St', '13M'),
	('Columbus', 'OH', 1111, 'High St', '14N'),
	('Charlotte', 'NC', 1212, 'Tryon St', '15O'),
	('San Francisco', 'CA', 1313, 'Market St', '16P'),
	('Indianapolis', 'IN', 1414, 'Meridian St', '17Q'),
	('Seattle', 'WA', 1515, 'Pine St', '18R'),
	('Denver', 'CO', 1616, 'Colfax Ave', '19S'),
	('Washington', 'DC', 1717, 'Pennsylvania Ave', '20T'),
	('Boston', 'MA', 1818, 'Boylston St', '21U'),
	('El Paso', 'TX', 1919, 'Mesa St', '22V'),
	('Nashville', 'TN', 2020, 'Broadway', '23W'),
	('Memphis', 'TN', 2323, 'Beale St', '26Z'),
	('Louisville', 'KY', 2424, 'Main St', '27A'),
	('Baltimore', 'MD', 2525, 'Pratt St', '28B'),
	('Milwaukee', 'WI', 2626, 'Water St', '29C'),
	('Albuquerque', 'NM', 2727, 'Central Ave', '30D'),
	('Tucson', 'AZ', 2828, 'Speedway Blvd', '31E'),
	('Fresno', 'CA', 2929, 'Fulton St', '32F'),
	('Sacramento', 'CA', 3030, 'Capitol Mall', '33G'),
	('Kansas City', 'MO', 3131, 'Main St', '34H'),
	('Mesa', 'AZ', 3232, 'Main St', '35I'),
	('Atlanta', 'GA', 3333, 'Peachtree St', '36J'),
	('Omaha', 'NE', 3434, 'Dodge St', '37K'),
	('Colorado Springs', 'CO', 3535, 'Tejon St', '38L'),
	('Raleigh', 'NC', 3636, 'Fayetteville St', '39M'),
	('Miami', 'FL', 3737, 'Biscayne Blvd', '40N'),
	('Virginia Beach', 'VA', 3838, 'Atlantic Ave', '41O'),
	('Oakland', 'CA', 3939, 'Broadway', '42P'),
	('Minneapolis', 'MN', 4040, 'Nicollet Ave', '43Q'),
	('Tulsa', 'OK', 4141, 'Peoria Ave', '44R'),
	('Arlington', 'TX', 4242, 'Abram St', '45S'),
	('New Orleans', 'LA', 4343, 'Canal St', '46T'),
	('Wichita', 'KS', 4444, 'Douglas Ave', '47U'),
	('Cleveland', 'OH', 4545, 'Euclid Ave', '48V'),
	('Detroit', 'MI', 2121, 'Woodward Ave', '24X'),
	('Oklahoma City', 'OK', 2222, 'Reno Ave', '25Y'),
	('Las Vegas', 'NV', 4646, 'Las Vegas Blvd', '49W'),
	('Portland', 'OR', 4747, 'Burnside St', '50X'),
	('Louisville', 'KY', 4848, 'Bardstown Rd', '51Y'),
	('Baltimore', 'MD', 4949, 'Charles St', '52Z'),
	('Milwaukee', 'WI', 5050, 'Wisconsin Ave', '53A'),
	('Albuquerque', 'NM', 5151, 'Lomas Blvd', '54B'),
	('Tucson', 'AZ', 5252, 'Speedway Blvd', '55C'),
	('Fresno', 'CA', 5353, 'Shaw Ave', '56D'),
	('Sacramento', 'CA', 5454, 'J St', '57E'),
	('Kansas City', 'MO', 5555, 'Main St', '58F'),
	('Mesa', 'AZ', 5656, 'Southern Ave', '59G'),
	('Atlanta', 'GA', 5757, 'Peachtree St', '60H'),
	('Omaha', 'NE', 5858, 'Dodge St', '61I'),
	('Colorado Springs', 'CO', 5959, 'Academy Blvd', '62J'),
	('Raleigh', 'NC', 6060, 'Capital Blvd', '63K'),
	('Miami', 'FL', 6161, 'Flagler St', '64L'),
	('Virginia Beach', 'VA', 6262, 'Virginia Beach Blvd', '65M'),
	('Oakland', 'CA', 6363, 'International Blvd', '66N'),
	('Minneapolis', 'MN', 6464, 'Hennepin Ave', '67O'),
	('Tulsa', 'OK', 6565, '21st St', '68P'),
	('Arlington', 'TX', 6666, 'Cooper St', '69Q'),
	('New Orleans', 'LA', 6767, 'Magazine St', '70R'),
	('Wichita', 'KS', 6868, 'Kellogg Ave', '71S'),
	('Cleveland', 'OH', 6969, 'Lorain Ave', '72T'),
	('Detroit', 'MI', 7070, 'Gratiot Ave', '73U'),
	('Oklahoma City', 'OK', 7171, 'Western Ave', '74V'),
	('Las Vegas', 'NV', 7272, 'Tropicana Ave', '75W'),
	('Portland', 'OR', 7373, 'Division St', '76X'),
	('Louisville', 'KY', 7474, 'Dixie Hwy', '77Y'),
	('Baltimore', 'MD', 7575, 'Eastern Ave', '78Z'),
	('Milwaukee', 'WI', 7676, 'Greenfield Ave', '79A'),
	('Albuquerque', 'NM', 7777, 'Menaul Blvd', '80B'),
	('Oakland', 'CA', 3939, 'Broadway', '42P'),
	('Minneapolis', 'MN', 4040, 'Nicollet Ave', '43Q'),
	('Tulsa', 'OK', 4141, 'Peoria Ave', '44R'),
	('Arlington', 'TX', 4242, 'Abram St', '45S'),
	('New Orleans', 'LA', 4343, 'Canal St', '46T'),
	('Wichita', 'KS', 4444, 'Douglas Ave', '47U'),
	('Cleveland', 'OH', 4545, 'Euclid Ave', '48V'),
	('Detroit', 'MI', 2121, 'Woodward Ave', '24X'),
	('Oklahoma City', 'OK', 2222, 'Reno Ave', '25Y');

INSERT INTO Facilities
	(Address_ID, Is_Branch, Facility_Name)
VALUES
	(1, 1, 'Branch 1'),
	(2, 1, 'Branch 2'),
	(3, 1, 'Branch 3'),
	(4, 1, 'Branch 4'),
	(5, 0, 'Office 1'),
	(6, 0, 'Office 2');


INSERT INTO Customers
	(Address_ID, First_Name, Last_Name)
VALUES
	(11, 'John', 'Doe'),
	(12, 'Jane', 'Smith'),
	(13, 'Michael', 'Johnson'),
	(14, 'Emily', 'Davis'),
	(15, 'David', 'Brown'),
	(16, 'Sarah', 'Miller'),
	(17, 'James', 'Wilson'),
	(18, 'Jessica', 'Moore'),
	(19, 'Daniel', 'Taylor'),
	(20, 'Laura', 'Anderson'),
	(21, 'Robert', 'Thomas'),
	(22, 'Linda', 'Jackson'),
	(23, 'William', 'White'),
	(24, 'Barbara', 'Harris'),
	(25, 'Charles', 'Martin');

INSERT INTO Bank_Employees
	(Employee_Address_ID, Role, Manager_ID, Start_Date, Employee_First_Name, Employee_Last_Name)
VALUES
	(26, 'Teller', 1, '2020-01-01', 'Alice', 'Johnson'),
	(27, 'Manager', 1, '2019-02-01', 'Bob', 'Smith'),
	(28, 'Loan Officer', 2, '2021-03-01', 'Charlie', 'Brown'),
	(29, 'Customer Service', 2, '2020-04-01', 'Diana', 'Prince'),
	(30, 'Security', 3, '2018-05-01', 'Evan', 'Peters'),
	(31, 'IT Support', 3, '2019-06-01', 'Fiona', 'Gallagher'),
	(32, 'Accountant', 4, '2020-07-01', 'George', 'Michael'),
	(33, 'HR', 4, '2021-08-01', 'Hannah', 'Montana'),
	(34, 'Branch Manager', NULL, '2017-09-01', 'Ian', 'Curtis'),
	(35, 'Assistant Manager', 5, '2018-10-01', 'Jack', 'Sparrow'),
	(36, 'Teller', 6, '2019-11-01', 'Karen', 'Walker'),
	(37, 'Loan Officer', 6, '2020-12-01', 'Leo', 'DiCaprio'),
	(38, 'Customer Service', 7, '2021-01-01', 'Mia', 'Wallace'),
	(39, 'Security', 7, '2019-02-01', 'Nina', 'Simone'),
	(40, 'IT Support', 8, '2020-03-01', 'Oscar', 'Wilde'),
	(41, 'Teller', 1, '2021-04-01', 'Paul', 'Allen'),
	(42, 'Loan Officer', 1, '2021-05-01', 'Quincy', 'Adams'),
	(43, 'Customer Service', 2, '2021-06-01', 'Rachel', 'Green'),
	(44, 'Security', 2, '2021-07-01', 'Steve', 'Rogers'),
	(45, 'IT Support', 3, '2021-08-01', 'Tony', 'Stark'),
	(46, 'Accountant', 3, '2021-09-01', 'Uma', 'Thurman'),
	(47, 'HR', 4, '2021-10-01', 'Victor', 'Frankenstein'),
	(48, 'Branch Manager', NULL, '2021-11-01', 'Wanda', 'Maximoff'),
	(49, 'Assistant Manager', 5, '2021-12-01', 'Xander', 'Cage'),
	(50, 'Teller', 5, '2022-01-01', 'Yara', 'Greyjoy'),
	(51, 'Loan Officer', 6, '2022-02-01', 'Zara', 'Larsson'),
	(52, 'Customer Service', 6, '2022-03-01', 'Aaron', 'Paul'),
	(53, 'Security', 7, '2022-04-01', 'Betty', 'White'),
	(54, 'IT Support', 7, '2022-05-01', 'Chris', 'Evans'),
	(55, 'Accountant', 8, '2022-06-01', 'Daisy', 'Ridley'),
	(56, 'HR', 8, '2022-07-01', 'Eddie', 'Redmayne'),
	(57, 'Branch Manager', NULL, '2022-08-01', 'Felicity', 'Jones'),
	(58, 'Assistant Manager', 31, '2022-09-01', 'Gina', 'Rodriguez'),
	(59, 'Teller', 10, '2022-10-01', 'Henry', 'Cavill'),
	(60, 'Loan Officer', 10, '2022-11-01', 'Isla', 'Fisher'),
	(61, 'Customer Service', 10, '2022-12-01', 'Jack', 'Black');

INSERT INTO Facilities_Employees
	(Employee_ID, Facility_ID)
VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 1),
	(2, 2),
	(3, 1),
	(3, 4),
	(4, 1),
	(4, 5),
	(5, 1),
	(5, 2),
	(6, 1),
	(6, 3),
	(7, 1),
	(7, 4),
	(8, 1),
	(8, 5),
	(9, 1),
	(9, 2),
	(10, 1),
	(10, 3),
	(11, 1),
	(11, 4),
	(12, 1),
	(12, 5),
	(13, 1),
	(13, 2),
	(14, 1),
	(14, 3),
	(15, 1),
	(15, 4),
	(16, 1),
	(16, 5),
	(17, 1),
	(17, 2),
	(18, 1),
	(18, 3),
	(19, 1),
	(19, 4),
	(20, 1),
	(20, 5),
	(21, 1),
	(21, 2),
	(22, 1),
	(22, 3),
	(23, 1),
	(23, 4),
	(24, 1),
	(24, 5),
	(25, 1),
	(25, 2),
	(26, 1),
	(26, 3),
	(27, 1),
	(27, 4),
	(28, 1),
	(28, 5),
	(29, 1),
	(29, 2),
	(30, 1),
	(30, 3),
	(31, 6),
	(31, 4),
	(32, 1),
	(32, 6),
	(33, 1),
	(33, 2),
	(34, 1),
	(34, 3),
	(35, 1),
	(35, 4),
	(36, 1),
	(36, 6),
	(37, 1),
	(37, 2),
	(38, 1),
	(38, 3),
	(39, 1);

INSERT INTO Account_Types
	(Account_Type_Name)
VALUES
	('Checking'),
	('Savings'),
	('Loan');

INSERT INTO Accounts
	(Account_Type_ID, Facility_ID, Balance, Date_Last_transaction, Check_Number, Interest_rate)
VALUES
	(1, 1, 1000.00, '2023-01-01', 1001, 0.01),
	(1, 2, 1500.00, '2023-02-01', 1002, 0.01),
	(1, 3, 2000.00, '2023-03-01', 1003, 0.01),
	(1, 4, 2500.00, '2023-04-01', 1004, 0.01),
	(1, 4, 3000.00, '2023-05-01', 1005, 0.01),
	(2, 1, 5000.00, '2023-01-01', NULL, 0.02),
	(2, 2, 6000.00, '2023-02-01', NULL, 0.02),
	(2, 3, 7000.00, '2023-03-01', NULL, 0.02),
	(2, 4, 8000.00, '2023-04-01', NULL, 0.02),
	(2, 4, 9000.00, '2023-05-01', NULL, 0.02),
	(3, 1, -10000.00, '2023-01-01', NULL, 0.05),
	(3, 2, -15000.00, '2023-02-01', NULL, 0.05),
	(3, 3, -20000.00, '2023-03-01', NULL, 0.05),
	(3, 4, -25000.00, '2023-04-01', NULL, 0.05),
	(3, 4, -30000.00, '2023-05-01', NULL, 0.05);


INSERT INTO Customers_Accounts
	(Customer_ID, Account_ID)
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 3),
	(5, 4),
	(6, 5),
	(7, 6),
	(8, 7),
	(9, 8),
	(10, 9),
	(11, 10),
	(12, 11),
	(13, 12),
	(14, 13),
	(15, 14),
	(15, 15);


INSERT INTO Employees_Accounts
	(Employee_ID, Account_ID)
VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2),
	(5, 3),
	(6, 4),
	(7, 5),
	(8, 5),
	(9, 5),
	(10, 6),
	(10, 7),
	(11, 8),
	(12, 9),
	(13, 9),
	(14, 10),
	(15, 10),
	(16, 9),
	(17, 8),
	(18, 7),
	(19, 6),
	(20, 6),
	(21,5),
	(22, 4),
	(23, 3),
	(24, 2),
	(25, 1),
	(26, 2),
	(27, 4),
	(28, 2),
	(29, 4),
	(30, 5),
	(31, 5),
	(32, 3),
	(33, 3),
	(34, 4),
	(35, 5);
	
INSERT INTO Transfers
	(Account_ID, Amount, Transfer_Date)
VALUES
	(1, 1200.50, '2024-10-01'),
	(5, 3000.00, '2024-10-05'),
	(8, 750.75, '2024-10-07'),
	(12, 2500.00, '2024-10-10'),
	(15, 1800.00, '2024-10-12')

-- Select * from Address;
-- Select * from Facilities;
-- Select * from Customers;
-- Select * from Bank_Employees;
-- Select * from Account_Types;
-- Select * from Accounts;
-- Select * from Customers_Accounts;
-- Select * from Employees_Accounts;
-- Select * from Transfers;
