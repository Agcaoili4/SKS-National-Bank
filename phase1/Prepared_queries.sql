-- Patrick MacDonald, Jansen Agcaoili, Bijoy Roy, Ethan Pelletier

USE SKS_National_Bank
GO

--Drop the stored procedure if it exists
IF OBJECT_ID('dbo.Track_Loan', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Track_Loan;
END
GO
-- 1 Tracks the top three largest loan amongst all accounts that has loan in it
CREATE PROCEDURE Track_Loan ( @accType AS NVARCHAR(100))
AS
BEGIN 
    SELECT TOP 3
        Accounts.Account_ID, Account_Types.Account_Type_Name, Accounts.Balance
    FROM 
        dbo.Accounts
	INNER JOIN
		dbo.Account_Types ON Accounts.Account_Type_ID = Account_Types.Account_Type_ID 
    WHERE 
        Account_Types.Account_Type_Name = @accType
    ORDER BY
        Accounts.Balance DESC;
END
GO

-- 2 Retrieve all employees in a branch
IF OBJECT_ID('dbo.Get_Employees', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Get_Employees
END
GO
CREATE PROCEDURE Get_Employees 
    @BranchName NVARCHAR(75)  
AS
BEGIN
    SELECT 
        be.Employee_ID, 
        f.Facility_Name, 
        be.Employee_First_Name, 
        be.Employee_Last_Name, 
        be.Role
    FROM 
        Bank_Employees be
    INNER JOIN 
        Facilities_Employees fe ON be.Employee_ID = fe.Employee_ID
    INNER JOIN 
        Facilities f ON fe.Facility_ID = f.Facility_ID
    WHERE 
        f.Facility_Name = @BranchName
    ORDER BY 
        be.Employee_First_Name;
END
GO

-- 3 Add Transfer to Account of Customer
IF OBJECT_ID('dbo.Transfer_Money', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Transfer_Money
END
GO

CREATE PROCEDURE Transfer_Money (@Account_ID AS INT, @Transfer AS MONEY, @Transfer_Date AS DATE)
AS
BEGIN
	INSERT INTO Transfers
	VALUES (
		 @Account_ID, @Transfer, @Transfer_Date)
END
GO 

-- 4. Get Customer Account Summary
-- Shows all accounts and their balances for a given customer
IF OBJECT_ID('dbo.Get_Customer_Summary', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Get_Customer_Summary
END
GO

CREATE PROCEDURE Get_Customer_Summary
    @CustomerID INT
AS
BEGIN
    IF @CustomerID IS NULL OR @CustomerID < 1
    BEGIN
        RAISERROR('Invalid Customer ID', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_ID = @CustomerID)
    BEGIN
        RAISERROR('Customer not found', 16, 1);
        RETURN;
    END

    SELECT 
        c.Customer_ID,
        c.First_Name + ' ' + c.Last_Name AS Customer_Name,
        at.Account_Type_Name,
        a.Account_ID,
        a.Balance,
        a.Interest_rate,
        f.Facility_Name AS Branch_Name,
        a.Date_Last_transaction AS Last_Transaction_Date
    FROM Customers c
    INNER JOIN Customers_Accounts ca ON c.Customer_ID = ca.Customer_ID
    INNER JOIN Accounts a ON ca.Account_ID = a.Account_ID
    INNER JOIN Account_Types at ON a.Account_Type_ID = at.Account_Type_ID
    INNER JOIN Facilities f ON a.Facility_ID = f.Facility_ID
    WHERE c.Customer_ID = @CustomerID
    ORDER BY at.Account_Type_Name;
END
GO

-- 5. Calculate Branch Performance
-- Shows total deposits, loans, and customer count per branch
IF OBJECT_ID('dbo.Branch_Performance', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Branch_Performance
END
GO

CREATE PROCEDURE Branch_Performance
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        f.Facility_Name,
        COUNT(DISTINCT ca.Customer_ID) as Total_Customers,
        SUM(CASE WHEN at.Account_Type_Name IN ('Savings', 'Checking') 
            THEN a.Balance ELSE 0 END) as Total_Deposits,
        SUM(CASE WHEN at.Account_Type_Name = 'Loan' 
            THEN a.Balance ELSE 0 END) as Total_Loans,
        COUNT(DISTINCT be.Employee_ID) as Total_Employees
    FROM Facilities f
    INNER JOIN Facilities_Employees fe ON f.Facility_ID = fe.Facility_ID
    INNER JOIN Bank_Employees be ON fe.Employee_ID = be.Employee_ID
    INNER JOIN Accounts a ON f.Facility_ID = a.Facility_ID
    INNER JOIN Account_Types at ON a.Account_Type_ID = at.Account_Type_ID
    INNER JOIN Customers_Accounts ca ON a.Account_ID = ca.Account_ID
    WHERE f.Is_Branch = 1
    AND a.Date_Last_transaction BETWEEN @StartDate AND @EndDate
    GROUP BY f.Facility_Name
    ORDER BY Total_Deposits DESC;
END
GO

-- 6. Monitor Large Transactions
-- Tracks transactions above a certain threshold for compliance
IF OBJECT_ID('dbo.Monitor_Large_Transactions', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Monitor_Large_Transactions
END
GO

CREATE PROCEDURE Monitor_Large_Transactions
    @ThresholdAmount MONEY,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        t.Transfer_ID,
        t.Transfer_Date,
        t.Amount,
        c.First_Name + ' ' + c.Last_Name as Customer_Name,
        at.Account_Type_Name,
        f.Facility_Name as Branch_Name
    FROM Transfers t
    INNER JOIN Accounts a ON t.Account_ID = a.Account_ID
    INNER JOIN Customers_Accounts ca ON a.Account_ID = ca.Account_ID
    INNER JOIN Customers c ON ca.Customer_ID = c.Customer_ID
    INNER JOIN Account_Types at ON a.Account_Type_ID = at.Account_Type_ID
    INNER JOIN Facilities f ON a.Facility_ID = f.Facility_ID
    WHERE t.Amount >= @ThresholdAmount
    AND t.Transfer_Date BETWEEN @StartDate AND @EndDate
    ORDER BY t.Amount DESC;
END
GO

-- 7. Employee Performance Metrics
-- Tracks employee assignments and account management
IF OBJECT_ID('dbo.Employee_Performance', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Employee_Performance
END
GO

CREATE PROCEDURE Employee_Performance
    @FacilityID INT
AS
BEGIN
    SELECT 
        be.Employee_ID,
        be.Employee_First_Name + ' ' + be.Employee_Last_Name AS Employee_Name,
        be.Role,
        COUNT(DISTINCT ea.Account_ID) AS Accounts_Managed,
        COALESCE(SUM(a.Balance), 0) AS Total_Portfolio_Value
    FROM Bank_Employees be
    INNER JOIN Facilities_Employees fe ON be.Employee_ID = fe.Employee_ID
    LEFT JOIN Employees_Accounts ea ON be.Employee_ID = ea.Employee_ID
    LEFT JOIN Accounts a ON ea.Account_ID = a.Account_ID
    WHERE fe.Facility_ID = @FacilityID
    GROUP BY be.Employee_ID, be.Employee_First_Name, be.Employee_Last_Name, be.Role
    HAVING COUNT(DISTINCT ea.Account_ID) > 0 OR COALESCE(SUM(a.Balance), 0) > 0
    ORDER BY Total_Portfolio_Value DESC;
END
GO

select * from Employees_Accounts;

-- 8. Account Activity Report
-- Generates detailed activity report for an account
IF OBJECT_ID('dbo.Account_Activity_Report', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Account_Activity_Report
END
GO

CREATE PROCEDURE Account_Activity_Report
    @AccountID INT,
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT 
        a.Account_ID,
        at.Account_Type_Name,
        t.Transfer_Date,
        t.Amount as Transaction_Amount,
        a.Balance as Current_Balance,
        f.Facility_Name as Branch_Name,
        c.First_Name + ' ' + c.Last_Name as Customer_Name
    FROM Accounts a
    INNER JOIN Account_Types at ON a.Account_Type_ID = at.Account_Type_ID
    INNER JOIN Facilities f ON a.Facility_ID = f.Facility_ID
    INNER JOIN Customers_Accounts ca ON a.Account_ID = ca.Account_ID
    INNER JOIN Customers c ON ca.Customer_ID = c.Customer_ID
    LEFT JOIN Transfers t ON a.Account_ID = t.Account_ID
    WHERE a.Account_ID = @AccountID
    AND t.Transfer_Date BETWEEN @StartDate AND @EndDate
    ORDER BY t.Transfer_Date DESC;
END
GO

-- 9. Find Inactive Accounts
-- Identifies accounts with no recent activity
IF OBJECT_ID('dbo.Find_Inactive_Accounts', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.Find_Inactive_Accounts
END
GO

CREATE PROCEDURE Find_Inactive_Accounts
    @InactiveDays INT
AS
BEGIN
    DECLARE @CutoffDate DATE = DATEADD(DAY, -@InactiveDays, GETDATE())

    SELECT 
        a.Account_ID,
        c.First_Name + ' ' + c.Last_Name as Customer_Name,
        at.Account_Type_Name,
        a.Balance,
        a.Date_Last_transaction as Last_Activity_Date,
        DATEDIFF(DAY, a.Date_Last_transaction, GETDATE()) as Days_Inactive,
        f.Facility_Name as Branch_Name
    FROM Accounts a
    INNER JOIN Customers_Accounts ca ON a.Account_ID = ca.Account_ID
    INNER JOIN Customers c ON ca.Customer_ID = c.Customer_ID
    INNER JOIN Account_Types at ON a.Account_Type_ID = at.Account_Type_ID
    INNER JOIN Facilities f ON a.Facility_ID = f.Facility_ID
    WHERE a.Date_Last_transaction < @CutoffDate
    ORDER BY a.Date_Last_transaction;
END
GO

-- 10. High Value Customer Report
-- Identifies and reports on high-value customers
IF OBJECT_ID('dbo.High_Value_Customer_Report', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.High_Value_Customer_Report
END
GO

CREATE PROCEDURE High_Value_Customer_Report
    @MinimumTotalBalance MONEY
AS
BEGIN
    WITH CustomerTotals AS (
        SELECT 
            c.Customer_ID,
            c.First_Name + ' ' + c.Last_Name as Customer_Name,
            SUM(a.Balance) as Total_Balance,
            COUNT(DISTINCT a.Account_ID) as Number_of_Accounts,
            MAX(a.Date_Last_transaction) as Last_Activity_Date
        FROM Customers c
        INNER JOIN Customers_Accounts ca ON c.Customer_ID = ca.Customer_ID
        INNER JOIN Accounts a ON ca.Account_ID = a.Account_ID
        GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
        HAVING SUM(a.Balance) >= @MinimumTotalBalance
    )
    SELECT 
        ct.*,
        addr.City_Name,
        addr.Province_Name,
        f.Facility_Name as Primary_Branch
    FROM CustomerTotals ct
    INNER JOIN Customers c ON ct.Customer_ID = c.Customer_ID
    INNER JOIN Address addr ON c.Address_ID = addr.address_ID
    INNER JOIN Customers_Accounts ca ON c.Customer_ID = ca.Customer_ID
    INNER JOIN Accounts a ON ca.Account_ID = a.Account_ID
    INNER JOIN Facilities f ON a.Facility_ID = f.Facility_ID
    ORDER BY ct.Total_Balance DESC;
END
GO


-- 1 
EXEC Track_Loan 'loan';
-- 2 Get all employees in a branch
EXEC Get_Employees 'office 1';
-- 3 Transfer money to account 1
EXEC Transfer_Money 1, 20000.00, '2024-10-24';
-- 4 Get summary for customer ID 1
EXEC Get_Customer_Summary 1;
-- 5 Get branch performance for the last month
EXEC Branch_Performance '2023-01-01', '2023-04-01';
-- 6 Monitor transactions above $10,000
EXEC Monitor_Large_Transactions 10000.00, '2024-10-01', '2024-10-26';
-- 7 Monitor employee performance
EXEC Employee_Performance 1;
-- 8 Get account activity for account 1
EXEC Account_Activity_Report 1, '2024-10-01', '2024-10-26';
-- 9 Find accounts inactive for 90 days
EXEC Find_Inactive_Accounts 90;
-- 10 Find customers with total balance above $50,000
EXEC High_Value_Customer_Report 50000.00;
