--- the full name and account balance of all clients with active bank accounts?
SELECT c.First_Name || ' ' || c.Last_Name AS Full_Name, a.Balance_account
FROM clients c
INNER JOIN account a ON c.ID = a.Client_ID
WHERE a.Status = 'Active';

--- Identify all clients and their most recent transaction details, including clients who have not made any transactions
SELECT c.First_Name, c.Last_Name, t.Amount_Transactions, t.Date_issued
FROM clients as c
LEFT JOIN transactions as t
ON c.ID = t.Source_Account_ID
WHERE t.Date_issued IS NOT NULL
ORDER BY c.First_Name, c.Last_Name, t.Date_issued DESC;

----Show all accounts and their withdrawal transactions, including accounts that have never made withdrawals
SELECT a.ID AS Account_ID, a.Balance_account, t.Withdraw AS Withdrawn_Amount
FROM transactions as t
RIGHT JOIN account as a
ON t.Source_Account_ID = a.ID
WHERE t.Withdraw IS NOT NULL;

--- Show all branches along with their details, even if they don't currently have any active accounts assigned to them
SELECT b.ID, b.Name, b.Location, b.Manager, COUNT(a.ID) AS Number_of_Accounts
FROM branches as b
LEFT JOIN account as a 
ON b.ID = a.Branch_ID
GROUP BY b.ID, b.Name, b.Location, b.Manager
ORDER BY COUNT(a.ID) DESC;

--- Show all branches along with the total number of accounts and total transactions they manage
SELECT b.ID AS Branch_ID, b.Name AS Branch_Name, COUNT(a.ID) AS Total_Accounts, COUNT(t.ID) AS Total_Transactions
FROM branches as b
FULL OUTER JOIN account as a
ON b.ID = a.Branch_ID
FULL OUTER JOIN transactions t
ON a.ID = t.Source_Account_ID
GROUP BY b.ID, b.Name;

