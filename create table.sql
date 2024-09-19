CREATE TABLE account (
    id SERIAL PRIMARY KEY,
    balance_account NUMERIC,
    status VARCHAR(50),
    created_at TIMESTAMP,
    client_id INTEGER,
    account_type_id INTEGER,
    branch_id INTEGER);

CREATE TABLE Account_types (
    ID SERIAL PRIMARY KEY,
    Description_Type TEXT);

CREATE TABLE Branches (
    ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Manager VARCHAR(100));

CREATE TABLE Clients (
    ID SERIAL PRIMARY KEY,
    First_Name VARCHAR(100),
    Last_Name VARCHAR(100),
    DOB DATE,
    Address TEXT,
    Sex CHAR(1),
    Created_Time TIMESTAMP,
    Contact_no VARCHAR(20),
    Work_no VARCHAR(20));

CREATE TABLE Transactions (
    ID SERIAL PRIMARY KEY,
    Amount_Transactions DECIMAL(10, 2) DEFAULT NULL,
    Date_issued TIMESTAMP,
    Deposit DECIMAL(10, 2),
    Withdraw DECIMAL(10, 2),
    Transfer DECIMAL(10, 2) DEFAULT NULL,
    Transaction_type_ID INT,
    Source_Account_ID INT,
    Destination_Account_ID INT DEFAULT NULL);

CREATE TABLE Transaction_types (
    ID SERIAL PRIMARY KEY,
    Transaction_type VARCHAR(100),
    Description TEXT,
    Transaction_fee DECIMAL(10, 2));


SELECT ID, First_Name, Last_Name, COUNT(*)
FROM Clients
GROUP BY ID, First_Name, Last_Name
HAVING COUNT(*) > 1;

SELECT ID, First_Name, Last_Name, COUNT(*)
FROM acc3ount
GROUP BY ID, First_Name, Last_Name
HAVING COUNT(*) > 1;
