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
-- add address, email, phone_no in customer table
*/

SELECT cid, first_name, last_name, address, email, phone_no WHERE cid=$CID AND sid=$SID;
SELECT vin, manf, year, mileage FROM Vehicle WHERE cid=$CID AND sid=$SID;

*/ b. add car
USER INPUT: A. VIN number B. Car Manufacturer name C. Current mileage D. Year
*/

INSERT INTO Vehicle(vin, manf, mileage, year, cid, sid) VALUES ($VIN, $MANF, $MILEAGE, $YEAR, $CID, $SID)

*/ c. delete car
USER INPUT:  VIN number
*/
DELETE FROM Vechicle WHERE vin=$VIN;



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
--user picks one

------- Execute the below as a single transaction. Roll back if there is an error with any ----------
-- insert into Invoice
INSERT INTO Invoice (id, total_amount, amount_paid, sid, timeslot_date, timeslot, vin, eid) VALUES
($ID, $COST, 0, $SID, $TIMESLOT_DATE, $TIMESLOT, $VIN, $EID)

CREATE TRIGGER UPDATE_TIMESLOT
    AFTER INSERT ON Invoice
    FOR EACH ROW
    BEGIN
        UPDATE Time_Slot SET id=$ID where timeslot_date=$TIMESLOT_DATE, timeslot=$TIMESLOT, sid=$SID, eid=$EID
    END;

-- insert into Invoice_HasService table
INSERT ALL
    INTO Invoice_HasService ( id, name, number ) VALUES ( $ID, 'Belt Repair', '112' )
    INTO Invoice_HasService ( id, name, number) VALUES ( $ID, 'Engine Repair', '114' )
SELECT 1 FROM dual;

-- inserto into Invoice_HasSchedule table
INSERT INTO Invoice_HasSchedule (id, name, number) VALUES ( $ID, 'A', '119' )
------- Execute the above as a single transaction. Roll back if there is an error with any ----------







