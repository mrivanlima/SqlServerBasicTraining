--Before we start talking about this one, this is what I need for you to do to make sure that we are understanding the concepts so far.
--Make sure you create all using a SQL script

--Step 1 Create a Login Named Student
--Step 2 Create a User Named Student for login Student
--Step 3 Create a Role called StudentRole
--Step 4 Add Student user to Student Role
--Step 5 ADD Junior ROLE to [db_owner] role
--Step 5 REVOKE CREATE FUNCTION to Junior ROLE


--Step 6 Login to SSMS using Student Login
--Step 7 CREATE TABLE Person conditionally on existing
  --The table should have the following
	--PersonFirstName type NVARCHAR(40)
	--PersonMiddleName type NVARCHAR(40)
	--PersonLastName type NVARCHAR (40)
	--PersonDateOfBirth type DATE
	--PersonAge type TINYINT
	--PersonGender BIT
	--PersonAddress1 NVARCHAR(200)
	--PersonAddress2 NVARCHAR (200)
	--PersonPhoneNumbers NVARCHAR(200)
	--PersonProductPurchase NVARCHAR(100)
	--PersonPurchaseDate DATETIME2
	--PersonPurchaseQuantity SMALLINT
	--PersonCreditCardNumber VARCHAR(16)
	--PersonCreditCardFlag VARCHAR(20)

--Step 8 set all except PersonMiddleName, PersonAddress2 and PersonGender to constraint NOT NULL
--Step 9 create a CHECK CONSTRAINT ON PersonAge to be bigger or equal to 18
--Step 10 create a DEFAULT CONSTRAINT ON PersonAddress2, set it to 'NOT SPECIFIED'. 
--Make sure you follow conventions on those names.

--We should now be ready for data manipulation language or DML.
--If you don't have any experience with databases, you will see no problems with the table above.
--If you have experience, you will notice by now that table is funky. Don't worry, it will be fixed by the end of the module.
--DML has to do with following statements. INSERT, UPDATE and DELETE. Some say that SELECt is also part of DML.
--I don't really care if someone or even you consider that as DML as long as you know what it is.
--In this module we won't talk about SELECT. It will have a whole session for it. We will use it in this module but not explain any about it.

--As the eplicit in the statement INSERT will insert a record into the table
--Let's see we can insert into a table using this statement.
--Let's inserto into our Person table our first value

--Insert with all columns specified. Let's call this explicit insert
INSERT INTO Person (PersonFirstName, PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonGender, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 


--Insert missing firstname value
INSERT INTO Person (PersonFirstName, PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonGender, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 

--Insert missing FirstName Column
INSERT INTO Person (PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonGender, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 

--Insert missing FirstName Column
INSERT INTO Person (PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonGender, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA')

--Insert missing Gender Column
INSERT INTO Person (PersonFirstName, PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonGender, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 

--Insert missing Gender Value
INSERT INTO Person (PersonFirstName, PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 

--Insert missing Gender Value and column. it will work since it is null.
INSERT INTO Person (PersonFirstName, PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 




--Insert Values more than 1 time
INSERT INTO Person (PersonFirstName, PersonMiddleName, PersonLastName, PersonBirthOfDate, PersonAge, PersonGender, PersonAddress1, PersonAddress2, PersonPhoneNumbers, PersonProductPurchase, PersonPurchaseDate, PersonPurchaseQuantity, PersonCreditCardNumber, PersonCreditCardFlag)
VALUES ('Jen', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA'),
('John', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 




--Insert with no columns spcified. --Let's call it implicit insert.
INSERT INTO Person VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 

--Insert with missing not null value
INSERT INTO Person VALUES ('Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 

--Insert with null values
INSERT INTO Person VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 



--Insert Values more than 1 time
INSERT INTO Person VALUES ('Joe', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA'),
('Jen', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA'),
('John', 'Black', 'White', '1980-12-23', 40, 0, '2098 West, Saint Clound, FL 345678', '3456 East, Houston, TX 564789', '407-322-89-90, 407-908-76-34', 'IPhone 12', '2020-12-12', 1, '3243123456780967, 7869098456739863, 7190587398216400', 'VISA, MASTERCARD, VISA') 


--TRUNCATE TABLE Person
SELECT * FROM Person



IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Person')
BEGIN
   DROP TABLE Person
END
GO

CREATE TABLE Person
( PersonFirstName VARCHAR(40) NOT NULL
, PersonMiddleName VARCHAR(40) NULL
, PersonLastName VARCHAR(40) NOT NULL
, PersonBirthOfDate DATE NOT NULL
, PersonAge TINYINT NOT NULL
, PersonGender BIT NULL
, PersonAddress1 NVARCHAR(200) NOT NULL
, PersonAddress2 NVARCHAR (200) NULL
, PersonPhoneNumbers NVARCHAR(200) NOT NULL
, PersonProductPurchase NVARCHAR(100) NOT NULL
, PersonPurchaseDate DATETIME2 NOT NULL
, PersonPurchaseQuantity SMALLINT NOT NULL
, PersonCreditCardNumber VARCHAR(100) NOT NULL
, PersonCreditCardFlag VARCHAR(100) NOT NULL
,CONSTRAINT CHK_Person_PersonAge CHECK (PersonAge >= 18)
)

ALTER TABLE Person
   ADD CONSTRAINT DF_Person_PersonAddress2 DEFAULT 'NOT SPECIFIED' FOR PersonAddress2 
GO


