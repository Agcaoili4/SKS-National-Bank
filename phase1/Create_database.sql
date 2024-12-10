-- Patrick MacDonald, Jansen Agcaoili, Bijoy Roy, Ethan Pelletier
USE master
GO
GO
-- Terminate connections to the BVC_Portal database
ALTER DATABASE SKS_National_Bank
SET
    SINGLE_USER
WITH
ROLLBACK IMMEDIATE;
GO
IF EXISTS (SELECT name
FROM sys.databases
WHERE name = 'SKS_National_Bank')
BEGIN
	DROP DATABASE SKS_National_Bank
END
GO

-- The Above wont run with out logging out and back in if you are connected to the db
CREATE DATABASE SKS_National_Bank
GO
USE SKS_National_Bank
GO

CREATE TABLE Address
(
	Address_ID INT IDENTITY PRIMARY KEY,
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
	Employee_Address_ID INT NOT NULL,
	Role VARCHAR(150)NOT NULL,
	-- The Manager_ID column is an integer that be null.
	-- It references the ID of the manager from the same table,
	-- indicating the employee's manager.
	Manager_ID INT,
	Start_Date DATE NOT NULL,
	Employee_First_Name VARCHAR(70),
	Employee_Last_Name VARCHAR(70),	
	FOREIGN KEY (Employee_Address_ID) REFERENCES Address(Address_ID) ON DELETE CASCADE
);

CREATE TABLE Facilities_Employees 
(
	Facility_ID INT NOT NULL,
	Employee_ID INT NOT NULL,
	CONSTRAINT FK_Facilities_Employees_Facility_ID FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON DELETE CASCADE
);

CREATE TABLE Account_Types 
(
	Account_Type_ID INT IDENTITY PRIMARY KEY,
	Account_Type_Name VARCHAR(50) NOT NULL
	
);

CREATE TABLE Accounts 
(
	Account_ID INT IDENTITY CONSTRAINT PK_Account_ID PRIMARY KEY,
	Account_Type_ID INT NOT NULL,
	Facility_ID INT NOT NULL,
	Balance money NOT NULL,
	Date_Last_transaction DATE NOT NULL,
	Check_Number INT,
	Interest_rate DECIMAL(5,2),
	CONSTRAINT FK_Accounts_Account_Type_ID FOREIGN KEY (Account_Type_ID) REFERENCES Account_Types(Account_Type_ID) ON DELETE CASCADE,
	CONSTRAINT FK_Facility_Facility_ID FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON DELETE CASCADE
);

CREATE TABLE Customers_Accounts 
(
	Customer_ID INT NOT NULL,
	Account_ID INT NOT NULL,
	FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE NO ACTION,
	CONSTRAINT FK_Customers_Accounts_Account_ID FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
	PRIMARY KEY (Customer_ID, Account_ID)
);

CREATE TABLE Employees_Accounts 
(
	Employee_ID INT NOT NULL,
	Account_ID INT NOT NULL,
	FOREIGN KEY (Employee_ID) REFERENCES Bank_Employees(Employee_ID) ON DELETE NO ACTION,
	CONSTRAINT FK_Employees_Accounts_Account_ID FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE,
	PRIMARY KEY (Employee_ID, Account_ID)
);

CREATE TABLE Transfers
(
	Transfer_ID INT IDENTITY PRIMARY KEY,
	Account_ID INT NOT NULL,
	Amount money NOT NULL,
	Transfer_Date DATE NOT NULL,
	CONSTRAINT FK_Transfers_Account_ID FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID) ON DELETE CASCADE
);