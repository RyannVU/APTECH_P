USE master
GO
IF EXISTS (SELECT * FROM sys.databases WHERE Name='Aptech')
DROP DATABASE Aptech
GO
CREATE DATABASE Aptech
GO
USE Aptech
GO

CREATE TABLE CLASSES(
	ClassName char(6) PRIMARY KEY,
	Teacher varchar(30),
	TimeSlot varchar(30) NOT NULL,
	Class int NOT NULL,
	Lab int NOT NULL
);
--1.
CREATE UNIQUE INDEX MyClusteredIndex
ON CLASSES(ClassName)
WITH(PAD_INDEX = on, FillFactor = 70, Ignore_DUP_KEY = on);
--2.
CREATE NONCLUSTERED INDEX TeacherIndex
ON CLASSES(Teacher);
--3.
DROP INDEX CLASSES.TeacherIndex;
--4.
CREATE UNIQUE INDEX MyClusteredIndex
ON CLASSES(ClassName)
WITH(DROP_EXISTING = ON, ALLOW_ROW_LOCKS = ON ,
ALLOW_PAGE_LOCKS= ON, MAXDOP = 2);
--5.
CREATE NONCLUSTERED INDEX TeacherIndex
ON CLASSES(Class,Lab);
--6.
EXEC sys.sp_helpindex N'CLASSES';