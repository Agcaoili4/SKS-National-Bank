USE master
GO

IF EXISTS (SELECT name
FROM sys.databases
WHERE name = 'SKS_National_Bank')
BEGIN
	DROP DATABASE SKS_National_Bank
END


CREATE DATABASE SKS_National_Bank
GO
USE SKS_National_Bank
GO

CREATE TABLE Address
(
	address_ID INT IDENTITY PRIMARY KEY,
	City_Name VARCHAR(60) NOT NULL,
	Province_Name VARCHAR(60) NOT NULL,
	Street_Number int NOT NULL,
	Street_Name VARCHAR(60) NOT NULL,
	Appt_Number VARCHAR(10)
);


CREATE TABLE Facilities
(
	Facility_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	Is_Branch BIT NOT NULL,
	--Can store 0 or 1 acts as BOOL
	Facility_Name VARCHAR(75) UNIQUE,
	FOREIGN KEY (Address_ID) REFERENCES Address(address_ID) ON DELETE CASCADE
);

CREATE TABLE Customers
(
	Customer_ID INT IDENTITY PRIMARY KEY,
	Address_ID INT NOT NULL,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(100) NOT NULL,
	FOREIGN KEY (address_ID) REFERENCES Address(address_ID) ON DELETE CASCADE
);

CREATE TABLE Bank_Employees
(
	Employee_ID INT IDENTITY PRIMARY KEY,
	Facility_ID INT NOT NULL,
	Employee_Address_ID INT NOT NULL,
	Role VARCHAR(150)NOT NULL,
	Manager_ID INT NOT NULL,
	Start_Date DATE NOT NULL,
	Employee_First_Name VARCHAR(70),
	Employee_Last_Name VARCHAR(70),
	FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Employee_Address_ID) REFERENCES Address(Address_ID) ON DELETE CASCADE
);

CREATE TABLE Account_Types
(
	Account_Type_ID INT IDENTITY PRIMARY KEY,
	Account_Type_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Accounts
(
	Account_ID INT IDENTITY PRIMARY KEY,
	Account_Type_ID INT NOT NULL,
	Facility_ID INT NOT NULL,
	Balance money NOT NULL,
	Data_Last_transaction DATE NOT NULL,
	Check_Number INT,
	Interest_rate DECIMAL(5,2),
	FOREIGN KEY (Account_Type_ID) REFERENCES Account_Types(Account_Type_ID) ON DELETE CASCADE,
	FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON DELETE CASCADE
);

CREATE TABLE Customers_Accounts
(
	Customer_ID INT NOT NULL,
	Account_ID INT NOT NULL,
	FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
	PRIMARY KEY (Customer_ID, Account_ID)
);

CREATE TABLE Employees_Accounts
(
	Employee_ID INT NOT NULL,
	Account_ID INT NOT NULL,
	FOREIGN KEY (Employee_ID) REFERENCES Bank_Employees(Employee_ID) ON DELETE NO ACTION,
	FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
);

CREATE TABLE Transfers
(
	Transfer_ID INT IDENTITY PRIMARY KEY,
	Account_ID INT NOT NULL,
	Amount money NOT NULL,
	Transfer_Date DATE NOT NULL,
	FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
);