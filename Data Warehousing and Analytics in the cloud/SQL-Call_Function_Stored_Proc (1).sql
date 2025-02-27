SET SQL_SAFE_UPDATES = 0;
CALL `customer`.`Customer.PrCustomerChurn`();

SELECT COUNT(*) FROM Customer.CustomerChurn;

SELECT * FROM Customer.CustomerChurn ORDER BY CustomerId DESC LIMIT 5;

CREATE TABLE Customer.CustomerChurn_Version1 AS SELECT * FROM Customer.CustomerChurn;

SHOW CREATE TABLE Customer.CustomerChurn_Version1;

SELECT COUNT(*) FROM Customer.CustomerChurn_Version1;

SELECT * FROM Customer.CustomerChurn_Version1 ORDER BY CustomerId DESC LIMIT 5;

TRUNCATE TABLE Customer.CustomerChurn_Stage;

SELECT COUNT(*) FROM Customer.CustomerChurn_Stage;

SELECT * FROM Customer.CustomerChurn_Stage ORDER BY CustomerId DESC LIMIT 5;

CALL `customer`.`Customer.PrCustomerChurn`();

SELECT COUNT(*) FROM Customer.CustomerChurn_Version1;

SELECT COUNT(*) FROM Customer.CustomerChurn;

SELECT * FROM Customer.CustomerChurn_Version1
LEFT JOIN Customer.CustomerChurn
ON Customer.CustomerChurn_Version1.CustomerId = Customer.CustomerChurn.CustomerId
Where Customer.CustomerChurn.CustomerId IS NULL;

SELECT a.CustomerId, a.*, b.CreateDtm AS V1_CreateDtm, b.ChangeDtm AS V1_ChangeDtm
FROM Customer.CustomerChurn a
JOIN Customer.CustomerChurn_Version1 b
ON a.CustomerId = b.CustomerId
WHERE a.Surname <> b.Surname
	OR a.Creditscore <> b.Creditscore
    OR a.Geography <> b.Geography
    OR a.Gender <> b.Gender
    OR a.Age <> b.Age
    OR a.Balance <> b.Balance
    OR a.Exited <> b.Exited
ORDER BY a.CustomerId;

SELECT * FROM Customer.CustomerChurn
LEFT JOIN Customer.CustomerChurn_Version1
ON Customer.CustomerChurn.CustomerId = Customer.CustomerChurn_Version1.CustomerId
Where Customer.CustomerChurn_Version1.CustomerId IS NULL
ORDER BY Customer.CustomerChurn.CustomerId;