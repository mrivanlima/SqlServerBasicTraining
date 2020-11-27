
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


--   THERE IS A SYSTEM STORED PROCEDURE CALLED SP_RENAME WHERE WE ARE ABLE TO RENAME THE NAMES OF OBJECTS INCLUDING TABLES, COLUMNS AND CONSTRAINTS.
-- wE WON'T TALK ABOUT THIS IN THIS COURSE. iT WILL BE COVERED IN A DIFFERENT COURSE.
















ALTER TABLE aTable
   ADD ColumnAdded NVARCHAR(20) NOT NULL


   SELECT * FROM aTable

ALTER TABLE aTable
   ALTER COLUMN aTableName NVARCHAR(40) NULL
GO


ALTER TABLE aTable
ALTER COLUMN aTableName DROP DEFAULT





