
--The purpose of this script is to show the use of GRANT and REVOKE commands.
--Before taht we must know a little about security and how it works.

use master
go



IF EXISTS (select * from sys.sql_logins sl where name = 'ilima2')
BEGIN
   DROP LOGIN ilima2
END

CREATE LOGIN ilima2
WITH PASSWORD = '123456@DEli'
MUST_CHANGE, CHECK_EXPIRATION = ON,
--CHECK_POLICY = OFF,
DEFAULT_DATABASE = master, DEFAULT_LANGUAGE = us_english
GO



IF (SELECT is_disabled FROM sys.sql_logins sl WHERE name = 'ilima2') = 1
BEGIN
   ALTER LOGIN ilima2 ENABLE
END
GO

--New Password 1234567890ppH

REVOKE VIEW DEFINITION ON SCHEMA :: dbo TO ilima2
go

REVOKE SELECT ON "dbo"."aTable" TO "ilima2"
go

--The following command used to work for granting permission for ALL.
--However, it has been deprecated and will not work any more, thanks goodness
GRANT ALL ON aTable TO ilima2;
go

--What should be done?
--The documentation says that all im plies the following
-- BACKUP DATABASE
-- BACKUP LOG
-- CREATE DATABASE
-- CREATE DEFAULT
-- CREATE FUNCTION
-- CREATE PROCEDURE
-- CREATE RULE
-- CREATE TABLE
-- CREATE VIEW

GRANT CREATE TABLE TO ilima2
GRANT ALTER ON SCHEMA :: dbo TO ilima2;
go

USE Basics
GO


--switch FROM wINDOWS TO sql aUTHENTICATION --Right click on the server name and select properties -- security tab -> Enable SQL Server and Windows Authentication mode
--Restart the server
CREATE USER ilima2 FOR LOGIN ilima2 WITH DEFAULT_SCHEMA = [dbo]
GO


DROP USER IF EXISTS  ilima2



--Create another login to test out user transfer.
CREATE LOGIN ilima3
WITH PASSWORD = '123456@DEli'
MUST_CHANGE, CHECK_EXPIRATION = ON,
--CHECK_POLICY = OFF,
DEFAULT_DATABASE = master, DEFAULT_LANGUAGE = us_english
GO

ALTER LOGIN ilima2 ENABLE


--This may happen if user already exists but login does not.
--What if I want to map a login to an existing user?
EXEC sp_change_users_login 'Update_One', 'ilima2', 'ilima2';  

--What if I want to map it to a different user? Will previous login lose access?
EXEC sp_change_users_login 'Update_One', 'ilima2', 'ilima3';  


ALTER ROLE [db_owner] ADD MEMBER ilima2
GO




ALTER ROLE [db_owner] DROP MEMBER ilima2
GO

EXEC sp_addrolemember 'db_owner', 'ilima2'

EXEC sp_droprolemember 'db_owner', 'ilima2'


--Creating ROLES
--We can GRANT permission to aly objects directly to the user or to the role.
--The Roles makses much more sense since a user can have multiple roles and each roles would grant different privileges.
--Think of Roles as you thinlk of Groups. 
--Wehn we create a role it is much easier for maintenance as well.
--Let's think of this scenario where a company has different leadership levels, each one would have acces to do different things, however the manager would have access to do
-- all that the employees below him also has.

--Let's create few roles to demosntrate.

IF (SELECT COUNT(*) 
FROM SYSUSERS 
WHERE name = 'Junior' 
AND issqlrole = 1) = 0 
BEGIN
   CREATE ROLE Junior
END


SELECT *
FROM SYSUSERS 
WHERE name = 'Junior'
GO

ALTER ROLE [Junior] ADD MEMBER ilima2
GO



