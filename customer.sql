*/Customer Privileges */


*/ 1. view and update profile
        a. view profile
        b. add car
        c. delete car*/

*/ view profile
display:
A. Customer ID
B. Full name
C. Address
D. Email Address
E. Phone Number
F. List of All Cars
Notes:
-- add address, email, phone_no in customer table - added
*/

SELECT cid, first_name, last_name, address, email, phone FROM Customer WHERE cid=$CID AND sid=$SID;
-- SELECT cid, first_name, last_name, address, email, phone FROM Customer WHERE cid=10001 AND sid=30001;
SELECT vin, manf, year, mileage FROM Vehicle WHERE cid=$CID AND sid=$SID;
-- SELECT vin, manf, year, mileage FROM Vehicle WHERE cid=10001 AND sid=30001;

*/ b. add car
USER INPUT: A. VIN number B. Car Manufacturer name C. Current mileage D. Year
*/

INSERT INTO Vehicle(vin, manf, mileage, year, cid, sid) VALUES ($VIN, $MANF, $MILEAGE, $YEAR, $CID, $SID)

*/ c. delete car
USER INPUT:  VIN number
*/
DELETE FROM Vehicle WHERE vin=$VIN;



*/ 2. View and Schedule Service */

*/ a. View Service History
    INPUT : $CID AND $SID*/
SELECT I.id, I.sid, I.vin, I.eid, I.timeslot, I.amount_paid, E.name from Invoice AS I, Employee as E where E.eid = I.eid AND vin in (SELECT vin from Vehicle where cid=$CID AND sid=$SID)
-- number of services
SELECT count(*) FROM Invoice_HasService WHERE id = $ID
-- schedule
SELECT name FROM Invoice_HasSchedule WHERE id = $ID


*/ b. Schedule Service */
Ask customer to choose a Vehicle:
SELECT vin, manf, year, mileage FROM Vehicle WHERE cid=$CID AND sid=$SID;

*/ 1. Add Schedule Maintenance */

-- get current schedule
SELECT schedule from Vechicle where vin=$VIN

-- get the number for the schedule
SELECT name, number FROM Schedule WHERE name=$CURRENT_SCHEDULE

-- get the cost of each maintenance for the schedule
*/SELECT M.mname, M.mnumber, C.cost FROM Maintenance_Schedule AS M, Cost_Details AS C
WHERE M.sname=$SCHEDULE_NAME AND M.snumber=$SCHEDULE_NUMBER AND C.name=M.mname
AND C.number=M.mnumber AND C.sid=$SID AND C.manf=(SELECT manf from Vehicle where vin=$VIN)*/
SELECT cost from Cost_details
WHERE name=$SCHEDULE_NAME AND number=$SCHEDULE_NUMBER AND sid=$SID AND manf=(SELECT manf from Vehicle where vin=$VIN)

-- get the duration for each maintenance in the schedule
*/SELECT M.mname, M.mnumber, D.duration FROM Maintenance_Schedule AS M, Duration_Details AS D
WHERE M.sname=$SCHEDULE_NAME AND M.snumber=$SCHEDULE_NUMBER AND
D.name=M.mname AND D.number=M.mnumber AND D.manf=(SELECT manf from Vehicle where vin=$VIN)*/
SELECT SUM(duration) FROM Duration_Details
WHERE name=$SCHEDULE_NAME AND number=$SCHEDULE_NUMBER
AND manf=(SELECT manf from Vehicle where vin=$VIN)


*/ 2. Add Schedule Repair */
-- Display repair category to user
SELECT DISTINCT repair_category FROM Services

-- user picks a repair category
SELECT name, number FROM Services WHERE repair_category=$REPAIR_CATEGORY

*/ 3. Schedule services in cart */
-- find cost
SELECT SUM(cost) FROM Cost_Details
WHERE (name, number) in (('Belt Repair', '112'),('Engine Repair', '114'))
AND sid=$SID AND manf=(SELECT manf from Vehicle where vin=$VIN)

-- find duration
SELECT SUM(duration) FROM Duration_Details
WHERE (name, number) in (('Belt Repair', '112'),('Engine Repair', '114'))
AND manf=(SELECT manf from Vehicle where vin=$VIN)

-- find available slot and mechanic
SELECT timeslot_date, timeslot, eid WHERE sid=$SID AND id=NULL
--user picks consecutive time slots as per the duration

------- Execute the below as a single transaction. Roll back if there is an error with any ----------
-- insert into Invoice
INSERT INTO Invoice (id, total_amount, amount_paid, duration, sid, vin, eid) VALUES
($ID, $COST, 0, $duration, $SID, $VIN, $EID)

-- perform this for each time slot selected
UPDATE Time_Slot SET id=$ID where timeslot_date=$TIMESLOT_DATE, timeslot=$TIMESLOT, sid=$SID, eid=$EID


-- insert into Invoice_HasService table
INSERT ALL
    INTO Invoice_HasService ( id, name, number ) VALUES ( $ID, 'Belt Repair', '112' )
    INTO Invoice_HasService ( id, name, number) VALUES ( $ID, 'Engine Repair', '114' )
SELECT 1 FROM dual;

-- inserto into Invoice_HasSchedule table
INSERT INTO Invoice_HasSchedule (id, name, number) VALUES ( $ID, 'A', '119' )
------- Execute the above as a single transaction. Roll back if there is an error with any ----------



*/ 4. Invoices */

*/ a. View Invoice */
-- User inputs the ID
-- determine paid and upaid by doing total_amount - amount_paid in the UI
SELECT * FROM Invoice WHERE id=$ID
-- Get all the time slot
SELECT timeslot_date, timeslot FROM Time_Slot WHERE id=$ID

*/ a. Pay Invoice */
UPDATE Invoice SET amount_paid=total_amount WHERE id=$ID








