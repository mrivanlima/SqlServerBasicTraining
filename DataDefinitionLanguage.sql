
USE master
GO

--How to create a database using scripts.
IF DB_ID('Basics') IS NULL
BEGIN

	CREATE DATABASE Basics
	ON 
		(
			NAME = N'Basic', 
			FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Basic.mdf',
			SIZE = 64MB, 
			MAXSIZE = UNLIMITED,
			FILEGROWTH = 64MB)
	LOG ON 
		(
			NAME = N'Basic_LOG', 
			FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Basic_Log.ldf', 
			SIZE = 512MB, 
			MAXSIZE = UNLIMITED,
			FILEGROWTH = 64MB)
END
GO

USE Basics
GO


--There two ways to check if a table already exists.
--Using OBJECT_ID function.
IF OBJECT_ID('dbo.Person', 'U') IS NOT NULL 
BEGIN
  DROP TABLE dbo.Person
END
GO

--Using EXISTS
--It won't matter which one is used. We just need to use 1 of them
--From now on, I will only be using  EXISTS
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'Person')
BEGIN
	DROP TABLE Person
END

CREATE TABLE Person
( PersonId INT IDENTITY (1, 1)
, PersonFirstName NVARCHAR(40) NOT NULL
, PersonMiddleName NVARCHAR (100) NOT NULL
, PersonLastName NVARCHAR(50) NOT NULL
, PersonGender BIT NULL
, PersonCreatedBy INT NOT NULL
, PersonUpdatedBy INT NULL
, PersonCreatedDate DATETIME2 NOT NULL
)
GO

ALTER TABLE Person
	ADD PersonUpdatedDate DATETIME2 NULL
GO

ALTER TABLE Person
   ALTER COLUMN PersonMiddleName NVARCHAR(40) NULL
GO

DROP TABLE Person
GO

--For DDL we saw 
--CREATE
--ALTER
--DROP

--We mentioned
--TRUNCATE

--For more advanced courses we will talk about
--COLLATIONS
--DISABLE TRIGGER
--ENABLE TRIGGER
--RENAME
--UPDATE STATISTICS

--Core Table -- it has an auto-numbered primary key. It has many other datatype fields. This is a good place to look up for indexes.
--Lookup Table --More for classification (categories, types, tags, etc). Nota an auto number primary key. It may have few more columns. If core table has field representing some type of classification. The best thing to do is to add a lookup table.
--List Table -- Very similar to Lookup but records can constantly be added. It should have an auto-numbered primary key. Few other datatype columns. Few indexes.
--Detail Table --It has specifics about the core table. it should have an auto-numbered primary key and it has only one refrence in the core table
--Cross-Reference Table -- It creates a many-to-many relationship between two other tables. It can have an auto-numbered primary key, however, the more important is to have keys associated with core tables.

--This is a Core table.
--Without this table, business does not function
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'Person')
BEGIN
	DROP TABLE Person
END

CREATE TABLE Person
( PersonId INT IDENTITY (1, 1)
, PersonFirstName NVARCHAR(40) NOT NULL
, PersonMiddleName NVARCHAR (100) NOT NULL
, PersonLastName NVARCHAR(50) NOT NULL
, PersonCreatedBy INT NOT NULL
, PersonUpdatedBy INT NULL
, PersonCreatedDate DATETIME2 NOT NULL
)
GO

--This is another Core Table
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'Address')
BEGIN
	DROP TABLE Address
END

CREATE TABLE Address
( AddressId INT IDENTITY (1, 1)
, StreetAddress1 NVARCHAR(60) NOT NULL
, StreetAddress2 NVARCHAR (60) NULL
, AddressTypeId  TINYINT NOT NULL
, ZipCodeID		 INT NOT NULL
, AddressCreatedBy INT NOT NULL
, AddressUpdatedBy INT NULL
, AddressCreatedDate DATETIME2 NOT NULL
, AddressUpdatedDate DATETIME2 NOT NULL
)
GO

--This is a Lookup table
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'AddressType')
BEGIN
	DROP TABLE AddressType
END

CREATE TABLE AddressType
( AddressTypeId INT
, AddressTypeName NVARCHAR(40) NOT NULL
, AddressTypeCreatedBy INT NOT NULL
, AddressTypeAddressUpdatedBy INT NULL
, AddressTypeCreatedDate DATETIME2 NOT NULL
, AddressTypeUpdatedDate DATETIME2 NOT NULL
)
GO

--This is a List table
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'Skill')
BEGIN
	DROP TABLE Skill
END

CREATE TABLE Skill
( SkillId INT
, SkillName NVARCHAR(40) NOT NULL
, SkillCreatedBy INT NOT NULL
, SkillUpdatedBy INT NULL
, SkillCreatedDate DATETIME2 NOT NULL
, SkillUpdatedDate DATETIME2 NOT NULL
)
GO

--This is a detail table
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'PersonDetail')
BEGIN
	DROP TABLE PersonDetail
END

CREATE TABLE PersonDetail
( PersonID INT
, UserName NVARCHAR(40) NOT NULL
, [Password] NVARCHAR(200) NOT NULL
, PersonDetailCreatedBy INT NOT NULL
, PersonDetailUpdatedBy INT NULL
, PersonDetailCreatedDate DATETIME2 NOT NULL
, PersonDetailUpdatedDate DATETIME2 NOT NULL
)
GO

--This is a Cross-reference table
--Last table
IF EXISTS (SELECT * FROM sys.tables WHERE Name = 'PersonAddress')
BEGIN
	DROP TABLE PersonAddress
END

CREATE TABLE PersonAddress
( PersonAddressID INT
, PersonID INT
, AddressID INT
, PersonAddressCreatedBy INT NOT NULL
, PersonAddressUpdatedBy INT NULL
, PersonAddressCreatedDate DATETIME2 NOT NULL
, PersonAddressUpdatedDate DATETIME2 NOT NULL
)
GO

--Table anatomy

DROP TABLE aTable
--DDL  --Object  --tablename --delimiter --columname --ColumnType -- Constraint --Property --seed,increment --comma
CREATE TABLE aTable ( aTableId INT PRIMARY KEY IDENTITY (1, 1), 
                     --columname --ColumnType -- Constraint
                      aTableName NVARCHAR(20) NOT NULL,
					  ColumnToBeDropped NVARCHAR(20) NULL,
					  --columname --ColumnType -- Constraint --Value
					  aDefaultTableColumn NVARCHAR(20) DEFAULT 'Table Cloumn',
					  aColumnCheck INT CHECK (aColumnCheck > 10),
					  aColumnUnique INT UNIQUE,
					  aSecondColumnUnique INT,
					  CONSTRAINT UC_aTableSecondColumnUnique UNIQUE (aSecondColumnUnique)
)
GO


ALTER TABLE aTable
   DROP COLUMN aTableId

ALTER TABLE aTable
   DROP COLUMN aTableName

ALTER TABLE aTable
   DROP COLUMN ColumnToBeDropped
GO

ALTER TABLE aTable
   DROP COLUMN aDefaultTableColumn

ALTER TABLE aTable
   DROP COLUMN aColumnCheck

ALTER TABLE aTable
   DROP COLUMN aColumnUnique

ALTER TABLE aTable
   DROP COLUMN aSecondColumnUnique

ALTER TABLE aTable
   DROP CONSTRAINT PK__aTable__6A98E7A259B715E2

ALTER TABLE aTable
   DROP CONSTRAINT DF__aTable__aDefault__571DF1D5

ALTER TABLE aTable
   DROP CONSTRAINT CK__aTable__aColumnC__5812160E

ALTER TABLE aTable
   DROP CONSTRAINT UQ__aTable__1F48EF8CF1C9972E

ALTER TABLE aTable
   DROP CONSTRAINT UC_aTableSecondColumnUnique


--Let's add them all back

ALTER TABLE aTable
  ADD aTableId INT PRIMARY KEY

ALTER TABLE aTable
   ADD aTableName NVARCHAR(20) NOT NULL

ALTER TABLE aTable
   ADD ColumnToBeDropped NVARCHAR(20)

ALTER TABLE aTable
   ADD aDefaultTableColumn NVARCHAR(20)

ALTER TABLE aTable
   ADD CONSTRAINT DF_aTable_aDefaultTableColumn DEFAULT 'A Default Table Cloumn' FOR aDefaultTableColumn

ALTER TABLE aTable
   ADD aColumnCheck INT

ALTER TABLE aTable
   ADD CONSTRAINT CK_aTable_aColumnCheck CHECK(aColumnCheck > 20)

ALTER TABLE aTable
   ADD aColumnUnique INT UNIQUE

ALTER TABLE aTable
   ADD CONSTRAINT UQ_aTable_aColumnUnique UNIQUE (aColumnUnique)


--Can I modify datatypes?

ALTER TABLE aTable
   ALTER COLUMN aTableId BIGINT

ALTER TABLE aTable
   ALTER COLUMN aTableName NVARCHAR(100)

ALTER TABLE aTable
   ALTER COLUMN aTableName INT

-- THERE IS A SYSTEM STORED PROCEDURE CALLED SP_RENAME WHERE WE ARE ABLE TO RENAME THE NAMES OF OBJECTS INCLUDING TABLES, COLUMNS AND CONSTRAINTS.
-- WE WON'T TALK ABOUT THIS IN THIS COURSE. iT WILL BE COVERED IN A DIFFERENT COURSE.

--So, here are best practices but not mandatory.
--For any keywords in SQL SERVER we should use capital letter (CREATE, ALTER, TABLE, etc...)
--Table name should be singular
--Column Names should be <tableName> Followed by Attribute. For example PersonID for a table called Person with Attribute ID.
--Table should have audit columns always. They are CreatedBy, CreatedDate, UpdatedBy, UpdatedDate.
--Datatypes should be well thought.


--For any CONSTRAINT that also create a different object in the database, we should name it and follow patterns.
--These are the patterns based on the type of CONSTRAINT
--PRIMARY KEY CONSTRAINT PK_<TableName>_<ColumnName>(s)
--UNIQUE KEY CONSTRAINT UQ_<TableName>_<ColumnName(s)>
--DEFAULT CONSTRAINT DF_<TableName>_<ColumnName>
--CHECK CONSTRAINT CHK_<TableName>_<ColumnName>


--Data Types
--Bit -0 or 1 - On or Off
--Byte - 8 bits
--1KB - 1024  Bytes
--8KB - 8,192 Bytes



--128   64   32    16   8   4   2   1 
-- 0     0    0     0   0   0   0   0 = 0
-- 0     0    0     0   0   0   0   1 = 1
-- 0     0    0     0   0   0   1   0 = 2
-- 0     0    0     0   0   0   1   1 = 3
-- 0     0    0     0   0   1   0   0 = 4
-- 0     0    0     0   0   1   0   1 = 5
--                   .
--                   .
--                   .
-- 1     1    1     1   1   1   1   1 = 255

--256  512 1024 2048 4096 8192 16384 32768

--select 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384 + 32768 + 256

--Based on that we can now study datatypes. It is very important to get the right datatype for better Satabase performance.

--Main Datatypes
--Numeric
--BIT Values(0,l NULL) --Storage (minmum 1 Byte. It will depend on how many bit columns in the table.
--See example:
CREATE TABLE aBitTable
( BitColumn1 BIT
)
--This table has reserved 1 byte of storage. Now remember 1 byte has 8 bits so the second table has also reserved 1 byte of data.
DROP TABLE aBitTable
GO
CREATE TABLE aBitTable2
( BitColumn1 BIT
, BitColumn2 BIT
, BitColumn3 BIT
, BitColumn4 BIT
, BitColumn5 BIT
, BitColumn6 BIT
, BitColumn7 BIT
, BitColumn8 BIT
)
--In other words if there are from1 to 8 columns of the BIT datatype, the table will reserve 1 byte for those columns. If there are more
-- BIT columns, the table will add another byte per 8 more bits. So If there are from 9 BIT columns to 16 there will be 2 bytes if there are
-- 17 Bit columns to 24 there will 3 bytes and so forth.
--Many developers belive that a BIT will only take 1 BIT of storage in SQL Server, but that is not he case the minimum amount is 1 byte.

DROP TABLE aBitTable2
GO

--TINYINT Values(0 to 255) --Storage (1 byte)  -- These values are good to know for interviews.
--SMALLINT Values(-32,768 to 32,767) --Sorage(2 bytes) --These values are good to know for interviews.
--INT Values(-2147,483,648 to 2,147,483,647) --Storage (4 bytes) -- The bytes are good to know.
--BIGINT Values(-2^63 to 2^63 -1) --Storage(8 bytes) -- The bytes are good to know.
--DECIMAL OR NUMERIC --Storage(5 bytes to 13 bytes) -- It will depend on the precision.
--MONEY --Storage (8 bytes)
--SMALLMONEY --Storage (4 bytes)

--Thse were the main numeric types. Lets now check some date types.
--DATETIME --Storage (8 bytes)
--SMALLDATETIME -- Stoorage (4 bytes)
--DATE --Storage (3 bytes)
--DATETIME2 --Storage (6 to 8 bytes)

--These were the main date datatypes. Let's see now string datatypes.
--CHAR --Storage ( 1 byte to 8000 bytes). It takes 1 byte per character. If CAHR(100) is definied it means it will take 100 bytes no matter what.
--NCHAR --Storage (1 byte to 8000 bytes). It takes 2 bytes per character. If NCHAR(100) is defined, it means it will take 200 bytes no matter what.
--VARCHAR --Storage (2 bytes + (1 to 8000 bytes)). It takes 2 bytes plus the number of charcters. If VARCHAR(100) is defined, it means it will take 102 bytes if all characters are used.
--NVARCHAR --Storage (2 bytes + (2 to 4000 bytes)). It takes 2 bytes plus 2x the number of charcters. If NVARCHAR(100) is defined, it means it will take 202 bytes if all characters are used.

--These are the ones to be found or created all the time. there are some others not very used but that can be found. 
--They are:
--UNIQUEIDENTIFIER
--TIMESTAMP
--XML
--TABLE
--CURSOR
--SQL_VARIANT
--IMAGE
--TEXT
--NTEXT
--VARBINARY
--BINARY
--We will not worry about these for the purpose of this course.

--Let's now create a table followinf all the conventions and calculate how many bytes per row that table can hold.
--a Page holds 8,060 bytes of row data. A page has 8,192 Bytes total - 96 bytes from Page Header - OffsetArray 36 bytes.

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Person')
BEGIN
   DROP TABLE Person
END
GO

CREATE TABLE Person
( PersonID INT
, PersonFirstName VARCHAR(40) NOT NULL
, PersonMiddleName VARCHAR(40) NULL
, PersonLastName VARCHAR(40) NOT NULL
, PersonDateOfBirth DATE NOT NULL
, PersonAge TINYINT 
, PersonGender BIT
, PersonNickName VARCHAR(50)
, PersonCreatedBy INT
, PersonCreatedDate DATETIME2
, PersonUpdatedBy INT
, PersonUpdatedDate DATETIME2
, CONSTRAINT PK_PersonID PRIMARY KEY (PersonID)
, CONSTRAINT CHK_Person_PersonAge CHECK(PersonAge > 13)

)
GO

ALTER TABLE Person
   ADD CONSTRAINT DF_Person_PersonNickName DEFAULT 'None' FOR PersonNickName 
GO

--how many bytes per row? Remember that VARCHAR is dynamic, so we will calculate for the worst scenario.
--PersonID INT - 4 bytes
--, PersonFirstName VARCHAR(40) NOT NULL - 42 bytes
--, PersonMiddleName VARCHAR(40) NULL -42 bytes
--, PersonLastName VARCHAR(40) NOT NULL - 42 bytes
--, PersonDateOfBirth DATE NOT NULL - 3 bytes
--, PersonAge TINYINT - 1 byte
--, PersonGender BIT - 1 byte
--, PersonNickName VARCHAR(50) - 52 bytes
--, PersonCreatedBy INT -4 bytes
--, PersonCreatedDate DATETIME2 - 8 bytes
--, PersonUpdatedBy INT - 4 bytes
--, PersonUpdatedDate DATETIME2 - 8 bytes

SELECT 4 + 42 + 42 + 42 + 3 + 1 + 1 + 52 + 4 + 8 + 4 + 8
--211 BYTES

--How many will it fit in a 8kb page?
select 8060 / 211
--It will fit 38 rows per page.
























