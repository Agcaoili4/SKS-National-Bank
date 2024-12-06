-- Patrick MacDonald, Jansen Agcaoili, Bijoy Roy, Ethan Pelletier

USE SKS_National_Bank;

CREATE TABLE Audit (
    ID INT IDENTITY PRIMARY KEY,
    Message VARCHAR(100) NOT NULL,
    Timestamp DATE NOT NULL
);
-- NEW CUSTOMER TRIGGER
GO
CREATE TRIGGER Audit_New_Customer_Trigger ON Customers
AFTER INSERT AS
BEGIN
INSERT INTO
    Audit (Message, Timestamp)
VALUES (
        'New customer added by user: ' + SUSER_SNAME(),
        GETDATE()
    );

END;

GO
-- Add Customer sample query
-- INSERT INTO Customers (Address_ID, First_Name, Last_Name)
-- VALUES (88, 'New', 'Customer');
-- SELECT * FROM Audit;
-- Loan payment trigger
GO
CREATE TRIGGER Audit_Loan_Payment_Trigger ON Transfers
AFTER INSERT AS
BEGIN
INSERT INTO
    Audit (Message, Timestamp)
SELECT 'Loan payment made from account ' + CAST(i.Account_ID AS VARCHAR(10)) + ' with amount $' + CAST(i.Amount AS VARCHAR(10)), GETDATE ()
FROM
    inserted i
    INNER JOIN Accounts a ON i.Account_ID = a.Account_ID
    INNER JOIN Account_Types at ON a.Account_Type_ID = at.Account_Type_ID
WHERE
    at.Account_Type_Name = 'Loan';

END;

GO
-- -- Query to test the trigger
-- BEGIN TRANSACTION;
-- INSERT INTO Transfers (Account_ID, Amount,Transfer_Date)
-- VALUES (13, + 101, GETDATE());
-- UPDATE Accounts
-- SET Balance = Balance + 101, Date_Last_transaction = GETDATE()
-- WHERE Account_ID = 13;
-- COMMIT TRANSACTION;

-- SELECT * FROM Audit;
-- SELECT * FROM Accounts WHERE Account_ID = 13;
-- Select * From Transfers;

GO
Alter TRIGGER Audit_Savings_Account_Opened_Trigger ON Accounts
AFTER INSERT AS
BEGIN
INSERT INTO
    Audit (Message, Timestamp)
SELECT 'Savings account opened by user: ' + SUSER_SNAME(), GETDATE()
FROM inserted i
    INNER JOIN Account_Types at ON i.Account_Type_ID = at.Account_Type_ID
WHERE
    at.Account_Type_Name = 'Savings';

END;


GO
-- Query to test the trigger
-- BEGIN TRANSACTION;

-- INSERT INTO
--     Accounts (
--         Account_Type_ID,
--         Facility_ID,
--         Balance,
--         Date_Last_Transaction
--     )
-- VALUES (2, 1, 100, GETDATE ());

-- INSERT INTO
--     Customers_Accounts (Customer_ID, Account_ID)
-- VALUES (1, SCOPE_IDENTITY ());

-- COMMIT TRANSACTION;

-- SELECT * FROM Audit;

-- SELECT * FROM Accounts;
-- SELECT * FROM Customers_Accounts;