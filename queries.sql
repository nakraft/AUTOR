--1. Which service center has the most number of customers?
select SID FROM CUSTOMER GROUP BY SID HAVING count(*)=(SELECT MAX(COUNT(*)) FROM CUSTOMER GROUP BY SID);

--2. What is the average price of an Evaporator Repair for Hondas across all service centers?
SELECT ROUND(AVG(price), 2) FROM Cost_Details WHERE Manf='Honda' AND serviceName='Evaporator Repair' AND serviceNumber=(select serviceNumber from Services where serviceName='Evaporator Repair' AND schedule IS NULL);

--3. Which customer(s) have unpaid invoices in Service Center 30003
SELECT * FROM Customer WHERE sid = 30003 AND standing = 0;

--4. List all services that are listed as both maintenance and repair services globally.
SELECT UNIQUE(serviceName) FROM Services WHERE schedule IS NOT NULL and repair_category IS NOT NULL;

--5. What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?
SELECT SUM(ABS(c2.PRICE - c1.PRICE)) FROM Cost_Details c1 LEFT OUTER JOIN Cost_Details c2 ON  c1.serviceName = c2.serviceName AND c1.serviceNumber = c2.serviceNumber WHERE c1.manf = c2.manf AND c1.manf='Toyota' AND (c1.serviceName, c1.serviceNumber) IN (('A', 113), ('Belt Replacement', 101)) AND c1.sid='30001' AND c2.sid = '30002';

--6. What is the next eligible maintenance schedule service for the car with VIN 34KLE19D
SELECT Schedule FROM Vehicle WHERE VIN='34KLE19D';