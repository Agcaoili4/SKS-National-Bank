-- Patrick MacDonald, Jansen Agcaoili, Bijoy Roy, Ethan Pelletier

-- Create a login and user named “customer_group_[?]” where [?] is your
-- group letter. (For example, “customer_group_A”.)
-- Their password should be “customer”.
-- Their user account should only be able to read tables that are related
-- to customers, based on your ERD. (For example, tables related to
-- customer information, accounts, loans, and payments).

USE Master;

USE SKS_National_Bank;
select * from accounts;

GO

CREATE LOGIN customer_group_G WITH PASSWORD = 'customer';

CREATE USER customer_group_G FOR LOGIN customer_group_G;

GRANT SELECT ON Customers TO customer_group_G;

GRANT SELECT ON Accounts TO customer_group_G;

GRANT SELECT ON Customers_Accounts TO customer_group_G;

GRANT SELECT ON Transfers TO customer_group_G;

GRANT SELECT ON Address TO customer_group_G;

GRANT SELECT ON Employees_Accounts TO customer_group_G;
GRANT SELECT ON Account_Types TO customer_group_G;
GO
-- Remove the public role from the customer_group_G user
-- EXEC sp_droprolemember 'public',
-- 'customer_group_G';

GO
-- Query to check the user and their permissions
SELECT
    princ.name AS user_name,
    perm.permission_name,
    perm.state_desc AS permission_state,
    obj.name AS object_name,
    obj.type_desc AS object_type
FROM sys.database_principals AS princ
    JOIN sys.database_permissions AS perm ON perm.grantee_principal_id = princ.principal_id
    JOIN sys.objects AS obj ON obj.object_id = perm.major_id
WHERE
    princ.name = 'customer_group_G';

-- select * from Address;
-- select * from Bank_Employees;
-- UPDATE Address SET City_Name = 'Toronto' WHERE Address_ID = 1;

-- Create a login and user named “accountant_group_[?]” where [?] is your
-- group letter. (For example, “accountant_group_B”.)
-- Their password should be “accountant”.
-- Their user account should be able to read all tables.
-- Their user account should not be able to update tables that are related
-- to accounts, payments and loans, based on your ERD.

CREATE LOGIN accountant_group_G WITH PASSWORD = 'accountant';

CREATE USER accountant_group_G FOR LOGIN accountant_group_G;

GRANT SELECT ON Accounts TO accountant_group_G;

GRANT SELECT ON Transfers TO accountant_group_G;

GRANT SELECT ON Account_Types TO accountant_group_G;

Grant Select ON Employees_Accounts TO accountant_group_G;

GRANT SELECT ON Customers_Accounts TO accountant_group_G;

GRANT SELECT ON Customers TO accountant_group_G;

GRANT SELECT ON Address TO accountant_group_G;

GRANT SELECT ON Facilities TO accountant_group_G;

GRANT SELECT ON Bank_Employees TO accountant_group_G;

GRANT SELECT ON Facilities_Employees TO accountant_group_G;


-- Remove the public role from the customer_group_A user
-- EXEC sp_droprolemember 'public', 'accountant_group_G';

GO
-- Query to check the user and their permissions
SELECT
    princ.name AS user_name,
    perm.permission_name,
    perm.state_desc AS permission_state,
    obj.name AS object_name,
    obj.type_desc AS object_type
FROM sys.database_principals AS princ
    JOIN sys.database_permissions AS perm ON perm.grantee_principal_id = princ.principal_id
    JOIN sys.objects AS obj ON obj.object_id = perm.major_id
WHERE
    princ.name = 'accountant_group_G';

-- SELECT * FROM Accounts;
-- UPDATE Accounts SET Balance = 1000 WHERE Account_ID = 1;


--- Test Queries 

-- select * from Address;
-- select * from Bank_Employees;
-- UPDATE Address SET City_Name = 'Toronto' WHERE Address_ID = 1;

-- SELECT * FROM Accounts;
-- UPDATE Accounts SET Balance = 1000 WHERE Account_ID = 1;