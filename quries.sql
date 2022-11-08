--1. Which service center has the most number of customers?
select SID FROM CUSTOMER GROUP BY SID HAVING count(*)=(SELECT MAX(COUNT(*)) FROM CUSTOMER GROUP BY SID);

--2. What is the average price of an Evaporator Repair for Hondas across all service centers?
SELECT AVG(PRICE) FROM COST_DETAILS WHERE MANF='Honda' AND SERVICENAME='Evaporator Repair' AND SERVICENUMBER=(select SERVICENUMBER from Services where servicename='Evaporator Repair' MINUS select SERVICENUMBER from MAINTENANCE where servicename='Evaporator Repair')

--3. Which customer(s) have unpaid invoices in Service Center 30003
SELECT C.FIRST_NAME,C.LAST_NAME FROM VEHICLE V CROSS JOIN CUSTOMER C WHERE C.CID=V.CID AND V.SID=C.SID AND V.VIN IN (SELECT I.VIN FROM INVOICE I WHERE I.SID='30003' AND 0<(I.TOTAL_AMOUNT-I.AMOUNT_PAID))

--4. List all services that are listed as both maintenance and repair services globally.
SELECT SERVICENAME FROM SERVICES GROUP BY SERVICENAME HAVING COUNT(*)>1;

--5. What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?

-- select (C1.PRICE + C2.PRICE) AS TOTAL from Cost_Details C1 CROSS JOIN Cost_Details C2 WHERE C1.SERVICENAME='A' AND C1.SERVICENUMBER=(
-- select SERVICENUMBER from schedule S where S.SERVICENAME='A')
-- AND C2.SERVICENAME='Belt Replacement' AND C2.SERVICENUMBER=(
-- select SERVICENUMBER from Services S1 where S1.SERVICENAME='Belt Replacement') AND C1.MANF = C2.MANF AND C1.MANF='Toyota'
-- AND C1.SID = C2.SID AND C1.SID IN ('30001','30002');

SELECT SUM(ABS(C2.PRICE - C1.PRICE)) 
FROM Cost_Details C1 LEFT OUTER JOIN Cost_Details C2 
ON  C1.SERVICENAME = C2.SERVICENAME 
WHERE C1.MANF = C2.MANF AND C1.MANF='Toyota' 
AND C1.SERVICENAME IN ('A', 'Belt Replacement') AND C1.SID!=C2.SID AND C1.SID='30001' AND C2.SID IN ('30001','30002');

--6. What is the next eligible maintenance schedule service for the car with VIN 34KLE19D
SELECT SCHEDULE AS CURRENT_SCHEUDLE, 
CASE WHEN SCHEDULE= 'A' THEN 'B'
WHEN SCHEDULE= 'B' THEN 'C'
ELSE 'A'
END AS NEXT_SCHEDULE FROM VEHICLE WHERE VIN='34KLE19D';



