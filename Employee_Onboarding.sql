-- Create the New Database where the new tables will be inserted.
CREATE DATABASE Company_Employees;


-- Specify the name of the Database that will be used from the list of Databases on the Schemas list.
-- Notice: This source code was written in MySQL Workbench. 
USE Company_Employees;


-- Table Employees: Stores the employee being onboarded.
-- Create the new table Employees. 
CREATE TABLE Employees
(
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Start_Date DATE,
    Job_Title VARCHAR(100),
    Department VARCHAR(100),
    Manager_ID INT,
    status ENUM('Pending','Active','On Hold','Terminated') DEFAULT 'Pending'
);


-- Table Departments: This is optional, however it is a best practice.
-- Create the new table Departments. 
-- Please Notice: If you want. (You can later link employees.department → department_id.)
CREATE TABLE Departments 
(
    Department_ID INT AUTO_INCREMENT PRIMARY KEY,
    Department_Name VARCHAR(100)
);


-- Table Onboarding Tasks.
-- Reusable task templates (e.g., “Complete I‑9”, “Laptop setup”).
CREATE TABLE Onboarding_Tasks 
(
    Task_ID INT AUTO_INCREMENT PRIMARY KEY,
    Task_Name VARCHAR(100), 
    DESCRIPTION TEXT,
    Responsible_Role VARCHAR(60), -- HR, IT, Manager
    Default_Due_Days INT
);


-- Table Employee Task 
-- Assignments (Tracks which employee has which tasks and their status).
-- This is the heart of the onboarding workflow.
CREATE TABLE Employee_Tasks 
(
    Employee_Task_ID INT AUTO_INCREMENT PRIMARY KEY,
    Employee_ID INT,
    Task_ID INT,
    Assigned_Date DATE,
    Due_Date DATE,
    Completed_Date DATE,
    STATUS ENUM('Not Started','In Progress','Completed','Overdue', 'Backgound Check') DEFAULT 'Not Started',
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Task_ID) REFERENCES Onboarding_Tasks(Task_ID)
);


-- Table Documents. (Tracks required documents).
CREATE TABLE Documents 
(
    Document_ID INT AUTO_INCREMENT PRIMARY KEY,
    Document_Name VARCHAR(100),
    Required BOOLEAN DEFAULT TRUE
);


-- Table Employee Documents.
-- Tracks whether each employee has submitted/acknowledged documents.
CREATE TABLE Employee_Documents 
(
    Employee_Document_ID INT AUTO_INCREMENT PRIMARY KEY,
    Employee_ID INT,
    Document_ID INT,
    Submitted_Date DATE,
    STATUS ENUM('Pending','Submitted','Approved','Rejected') DEFAULT 'Pending',
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (document_id) REFERENCES documents(document_id)
);


-- Tables: Equipment, Employee Equipment & Access (optional but powerful).
CREATE TABLE Equipment 
(
    Equipment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Equipment_Name VARCHAR(100),
    Equipment_Type VARCHAR(50)
);

CREATE TABLE Employee_Equipment 
(
    Employee_Equipment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Employee_ID INT,
    Equipment_ID INT,
    Assigned_Date DATE,
    Returned_Date DATE,
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID)
);



