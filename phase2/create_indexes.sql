USE SKS_NATIONAL_BANK;
----------------------------------------------------------------------------------------------------------------------------
-- Replace the default clustered index.

ALTER TABLE Accounts DROP CONSTRAINT FK_Facility_Facility_ID ;
ALTER TABLE Facilities_Employees DROP CONSTRAINT FK_Facilities_Employees_Facility_ID;

-- Drop the primary key constraint if it exists
DECLARE @pk_name NVARCHAR(128);

SELECT @pk_name = name
FROM sys.key_constraints
WHERE parent_object_id = OBJECT_ID('Facilities') AND type = 'PK';

-- Drop the primary key constraint if it exists
IF @pk_name IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Facilities DROP CONSTRAINT ' + @pk_name);
END;
GO

-- Create clustered index 
CREATE CLUSTERED INDEX Added_Facilities_Facility_Name_CLI
ON Facilities (Facility_Name);
GO
--                         -----------------------
-- Check if the clustered index exists on Facilities
-- IF EXISTS (SELECT name 
--            FROM sys.indexes 
--            WHERE object_id = OBJECT_ID('Facilities') 
--            AND name = 'Added_Facilities_Facility_Name_CLI')
-- BEGIN
--     PRINT 'Clustered index exists on Facilities.'
-- END
-- ELSE
-- BEGIN
--     PRINT 'Clustered index does not exist on Facilities.'
-- END;

-- EXEC sp_helpindex 'Facilities';

----------------------------------------------------------------------------------------------------------------------------
--  Replace default clustered index of any table with a new composite clustered index
-- First drop the existing primary and foreign key constraints
ALTER TABLE Accounts
DROP CONSTRAINT FK_Accounts_Account_Type_ID;

-- Find the primary key constraint name for Account_Types
DECLARE @pk_name NVARCHAR(128);

SELECT @pk_name = name
FROM sys.key_constraints
WHERE parent_object_id = OBJECT_ID('Account_Types') AND type = 'PK';

-- Drop the primary key constraint if it exists
IF @pk_name IS NOT NULL
BEGIN
    EXEC('ALTER TABLE Account_Types DROP CONSTRAINT ' + @pk_name);
END;
GO
-- Create the composite clustered index on Account_Types 

CREATE CLUSTERED INDEX Added_Account_Types_Account_Type_ID_CLI
ON Account_Types(Account_Type_ID, Account_Type_Name);
GO
--                         -----------------------
-- Check if the composite clustered index exists on Account_Types
-- IF EXISTS (SELECT name 
--            FROM sys.indexes 
--            WHERE object_id = OBJECT_ID('Account_Types') 
--            AND name = 'Added_Account_Types_Account_Type_ID_CLI')
-- BEGIN
--     PRINT 'Composite clustered index exists on Account_Types.'
-- END
-- ELSE
-- BEGIN
--     PRINT 'Composite clustered index does not exist on Account_Types.'
-- END;

-- EXEC sp_helpindex 'Account_Types';

----------------------------------------------------------------------------------------------------------------------------
-- Create a composite non-clustered index for any table 










-- Drop FK from Transfers
-- ALTER TABLE Transfers
-- DROP CONSTRAINT FK_Transfers_Account_ID;
-- ALTER TABLE Employees_Accounts DROP CONSTRAINT FK_Employees_Accounts_Account_ID;
-- ALTER TABLE Customers_Accounts DROP CONSTRAINT FK_Customers_Accounts_Account_ID;

-- -- Find the primary key constraint name for Account_Types
-- DECLARE @pk_name NVARCHAR(128);
-- SELECT @pk_name = name
-- FROM sys.key_constraints
-- WHERE parent_object_id = OBJECT_ID('Accounts') AND type = 'PK';
-- -- Drop Pk from 
-- IF @pk_name IS NOT NULL
-- BEGIN
--     EXEC('ALTER TABLE Accounts DROP CONSTRAINT ' + @pk_name);
-- END;
-- GO



-- --  Find the primary key constraint name for Transfers and drop it 

-- DECLARE @pk_name NVARCHAR(128);

-- SELECT @pk_name = name
-- FROM sys.key_constraints
-- WHERE parent_object_id = OBJECT_ID('Transfers') AND type = 'PK';
-- -- Drop Pk from 
-- IF @pk_name IS NOT NULL
-- BEGIN
--     EXEC('ALTER TABLE Transfers DROP CONSTRAINT ' + @pk_name);
-- END;
-- GO


