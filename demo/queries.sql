-- 1. Which service center has the most number of customers?

SELECT Count(*)
FROM Customer C, Service_Center S
WHERE C.sid = S.sid
GROUP BY S.sid
-- HAVING 
ORDER BY Count(*) DESC
LIMIT 1;

-- 2. What is the average price of an Evaporator Repair for Hondas across all service centers?



-- 3. Which customer(s) have unpaid invoices in Service Center 30003

-- 4. List all services that are listed as both maintenance and repair services globally.

-- 5. What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?

-- 6. What is the next eligible maintenance schedule service for the car with VIN 34KLE19D

