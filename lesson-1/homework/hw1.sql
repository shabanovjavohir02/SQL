Lesson 1

1
-- Data: Raw facts or information (like numbers, names, or dates).
-- Database: A collection of organized data stored for easy access and management.
-- Relational Database: A database that stores data in related tables using keys.
-- Table: A structure made of rows and columns used to store data in a database.

2
-- Five key features of SQL Server:
-- 1. Supports large-scale data storage
-- 2. High security and user management
-- 3. Backup and restore options
-- 4. Advanced data analysis tools
-- 5. Integration with other Microsoft services

3
-- Authentication modes:
-- 1. Windows Authentication
-- 2. SQL Server Authentication

4
CREATE DATABASE SchoolDB

5
CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
)

6
-- SQL Server: The main software that stores and manages databases.
-- SSMS: A tool used to connect to SQL Server and run SQL queries.
-- SQL: The language used to communicate with SQL Server to manage data.

7
-- DQL (Data Query Language): SELECT → retrieves data.
-- DML (Data Manipulation Language): INSERT, UPDATE, DELETE → manages data.
-- DDL (Data Definition Language): CREATE, ALTER, DROP → defines structure.
-- DCL (Data Control Language): GRANT, REVOKE → manages access.
-- TCL (Transaction Control Language): COMMIT, ROLLBACK → controls transactions.

8
INSERT INTO Students VALUES (1, 'Ali', 20)
INSERT INTO Students VALUES (2, 'Sara', 22)
INSERT INTO Students VALUES (3, 'John', 19)

9
-- Steps to restore AdventureWorksDW2022.bak in SSMS:
-- 1. Open SSMS and connect to your server.
-- 2. Right-click on "Databases" → Select "Restore Database".
-- 3. Choose "Device" → Click "Browse" → Add the .bak file.
-- 4. Select the backup file and check "Restore" box.
-- 5. Click "OK" to restore the database.
