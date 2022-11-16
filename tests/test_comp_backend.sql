-- NOTE: Many backend tests will be invalid due to the presence of a cid in the invoice table being removed. Keep this in mind while running tests. 
-- PASS: After populating full, the invoices that were inserted as "in good standing" 
    -- should have a total amount = amount paid and the customers should be in good standing too 
    -- check
    SELECT * FROM Invoice 
    SELECT * FROM Customer -- two customers in bad standing

-- PASS: If a customer pays some of their invoice, their balance should be impacted 
UPDATE Invoice SET amount_paid = 200 WHERE vin = (SELECT vin FROM Vehicle WHERE cid = 10501 AND sid = 30003) AND sid = 30003 
    -- check invoice amount paid should be updated 
    SELECT * FROM Invoice WHERE sid = 30003 AND vin = (SELECT vin FROM Vehicle WHERE cid = 10501 AND sid = 30003)
    -- check that standing is still poor, but balance is only 10 
    SELECT * FROM Customer WHERE sid = 30003 AND cid = 10501

-- PASS: A customer can pay off their balance completely 
UPDATE Invoice SET amount_paid = 210 WHERE vin = (SELECT vin FROM Vehicle WHERE cid = 10501 AND sid = 30003) AND sid = 30003 
    -- check invoice amount paid should be updated and status is good 
    SELECT * FROM Invoice WHERE sid = 30003 AND vin = (SELECT vin FROM Vehicle WHERE cid = 10501 AND sid = 30003)
    -- check that standing is now in good standing and balance is 0 
    SELECT * FROM Customer WHERE sid = 30003 AND cid = 10501

-- PASS: A customer who schedules a new service now goes back into bad standing with a balance 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (100, 'Belt Replacement', 101)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (100, 30003, 347812569, 10501, 4, 1, 1, 4, 1, 1, 'P39VN198')
   -- check amount_paid is 0 and status is 0 
   SELECT * FROM Invoice WHERE id = 100
   -- check standing is now 0 and balance is back up by the amount of the invoice 
   SELECT * FROM Customer WHERE sid = 30003 AND cid = 10501

-- PASS: Can insert a service center 
INSERT INTO Service_Center(sid, address, telephone, manager_id, mechanic_minimum_rate, mechanic_maximum_rate) VALUES (30004, 'testing address', 8888888888, 888999333, 25, 45)
    -- check 
    SELECT * FROM Service_Center WHERE sid = 30004

-- FAIL : cannot insert service center with same id, address or telephone number
INSERT INTO Service_Center(sid, address, telephone, manager_id) VALUES (30004, 'testing address2', 8888888887, 888999334)
INSERT INTO Service_Center(sid, address, telephone, manager_id) VALUES (30005, 'testing address', 8888888887, 888999334)
INSERT INTO Service_Center(sid, address, telephone, manager_id) VALUES (30005, 'testing address2', 8888888888, 888999334)

-- FAIL : an employee eid must be 9-digits 
INSERT INTO Service_Center(sid, address, telephone, manager_id) VALUES (30005, 'testing address', 8888888888, 88)

-- FAIL : a service center can be 'o', 'Open' or 'c', 'Close' on saturdays
INSERT INTO Service_Center(sid, address, telephone, manager_id, saturday) VALUES (30005, 'testing address', 8888888888, 888999334, 'yes')

-- PASS : two managers can have the same id if they belong to different service centers 
INSERT INTO Service_Center(sid, address, telephone, manager_id) VALUES (30005, 'testing address3', 8888888777, 123456789)
    -- check 
    SELECT * FROM Service_Center WHERE manager_id = 123456789

-- PASS : a recepionist employee is generated when added to service center
INSERT INTO Employee(sid, eid, role) VALUES (30004, 123456789, 'receptionist')
    -- check 
    SELECT * FROM Service_Center WHERE sid = 30004
    SELECT * FROM Receptionist WHERE sid = 30004

-- FAIL : a receptionist cannot also be a manager 
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888999333, 'receptionist')

-- FAIL : cannot add two receptionists per store
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888999666, 'receptionist')

-- PASS : A mechanic can be added 
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888999666, 'mechanic')
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888996666, 'mechanic')
    -- check 
    SELECT * FROM Mechanic WHERE sid = 30004
    SELECT * FROM Employee WHERE sid = 30004 AND role = 'mechanic'
    SELECT * FROM Service_Center WHERE sid = 30004  -- should still be in pending mode 

-- PASS : a 3 mechanics can be added
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888966666, 'mechanic')
    -- check 
    SELECT * FROM Service_Center WHERE sid = 30004     -- now in available mode as 3 mechanics, receptionist and saturday open all there

-- PASS : a salary can be added to the mechanic (it must be within the allowable measures for the store)
UPDATE Mechanic SET rate = 30 WHERE sid = 30004 AND eid = 888999666
    -- check 
    SELECT * FROM Mechanic WHERE sid = 30004

-- FAIL : a salary can not be added outside allowable ranges 
UPDATE Mechanic SET rate = 20 WHERE sid = 30004 AND eid = 888999666
UPDATE Mechanic SET rate = 46 WHERE sid = 30004 AND eid = 888999666

-- FAIL : With only three mechanics at the service center no one can request time off 
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (1, 1, 1, 30004, 888966666)

-- PASS : Anouther mechanic can be added and now the day can be taken off 
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888966655, 'mechanic')
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (1, 1, 1, 30004, 888966666)
    -- check Calendar day 1 for this mechanic should be empty
    SELECT * FROM Mechanic_Out
    SELECT * FROM Calendar WHERE sid = 30004 AND eid = 888966666 AND timeslot_week = 1 AND timeslot_day = 1

-- FAIL : A mechanic cannot ask for the same time off twice 
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (1, 1, 1, 30004, 888966666)

-- FAIL : Anouther mechanic cannot ask for the time off now as there is already a person out from it (20005 error)
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (1, 1, 1, 30004, 888999666)

-- FAIL : Schedule someone to work... a mechanic cannot take this time off either -- NOTE THIS ONLY WORKS AS INVOICE_ID ALREADY IS 1 
    -- setup steps 
    UPDATE Calendar SET invoice_id = 1 WHERE eid = 888999666 AND sid = 30004 and id = 2
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (1, 1, 2, 30004, 888999666)
    -- revert steps 
    UPDATE Calendar SET invoice_id = NULL WHERE eid = 888999666 AND sid = 30004 and id = 2

-- FAIL : a service must be in one of the 6 repair subcategories (error 20001 thrown)
INSERT INTO Services(serviceName, serviceNumber, repair_category) VALUES('Evaporator Repair', 113, 'Heating Services')

-- PASS : a new service can be added (just a repair)
INSERT INTO Services(serviceName, serviceNumber, repair_category) VALUES('Evaporator Repair', 113, 'Heating and A/C Services')
    -- check 
    SELECT * FROM Services WHERE serviceNumber = 113

-- PASS : a new maintenance service can be added
INSERT INTO Services(serviceName, serviceNumber, schedule, repair_category) VALUES('Windsheild Fluid Add', 117, 'A', 'Engine Services')
    -- check 
    SELECT * FROM Maintenance_Schedule WHERE sname = 'A'
    SELECT * FROM Services WHERE schedule IS NOT NULL

-- NOTE: no downward inclusion has been done, 2 insert statements must be made in database given that we want to prevent insert in currently mutating table

-- FAIL : A maintenance service must belong to an actual schedule 
INSERT INTO Services(serviceName, serviceNumber, schedule, repair_category) VALUES('Windsheild Fluid', 118, 'D', 'Engine Services')
  
-- FAIL : A service cannot be added that is actually a schedule 
INSERT INTO Services(serviceName, serviceNumber) VALUES('A', 113)

-- FAIL : A customer id must be an integer
INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES('AAA','Virginia','Potts',30003,'vpotts','potts')

-- PASS : A customer should be inactive when they are first added to the system 
INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10, 'Virginia','Old',30003,'vold','old')
    -- check 
    SELECT * FROM Customer WHERE sid = 30003 AND status = 0 AND cid = 10

-- PASS : A customer can have a vehicle added for it 
INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('4Y1BL651','Toyota',53500,'A',2006,10,30003)
    -- check a customer should now be active 
    SELECT * FROM Customer WHERE sid = 30003 AND status = 1 AND cid = 10
    -- check a car should now be included 
    SELECT * FROM Vehicle WHERE cid = 10 AND sid = 30003 

-- PASS : A car should be deleted and the customer should have 0 status again 
DELETE FROM Vehicle WHERE cid = 10 AND sid = 30003 
    -- check a customer should now be inactive 
    SELECT * FROM Customer WHERE sid = 30003 AND cid = 10
    -- check a car should not be included 
    SELECT * FROM Vehicle WHERE cid = 10 AND sid = 30003 

-- PASS : A customer can have 2 vehicles attributes to it 
INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('4Y1BL651','Toyota',53500,'A',2006,10,30003)
INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('4Y1BL650','Toyota',73500,'C',2006,10,30003)
    -- check a customer should now be active 
    SELECT * FROM Customer WHERE sid = 30003 AND cid = 10
    -- check a car should now be included 
    SELECT * FROM Vehicle WHERE cid = 10 AND sid = 30003 

-- PASS : A car should be deleted and the customer should still have an active status 
DELETE FROM Vehicle WHERE cid = 10 AND sid = 30003 AND vin = '4Y1BL651'   
    -- check a customer should still be active 
    SELECT * FROM Customer WHERE sid = 30003 AND cid = 10
    -- only 1 car should be left 
    SELECT * FROM Vehicle WHERE cid = 10 AND sid = 30003 

-- FAIL : A vehicle must be alphanumeric only 
INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('4Y1B*651','Toyota',53500,'A',2006,10,30003)

-- PASS : A service can be scheduled (invoice added) When the employee is free and the length 
-- of the services listed matches the length of the time alotted 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (8, 'Tire Balancing', 109)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (8, 30003, 123405678, 10, 1, 3, 9, 1, 3, 10, '4Y1BL650')
    -- check 
    SELECT * FROM Calendar WHERE invoice_id = 8 -- two timeslots should be schedules 
    SELECT * FROM Invoice WHERE id = 8 -- amount paid should be 0, total amount should be 95

-- FAIL : A service cannot be scheduled when the employee is not free (error 20003) (even if only part of their time overlaps)
    -- setup 
    INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(11, 'Virginia','New',30003,'vnew','new')
    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('4Y1BL651','Toyota',53500,'A',2006,11,30003)
    INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (9, 'Tire Balancing', 109)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (9, 30003, 123405678, 11, 1, 3, 10, 1, 3, 11, '4Y1BL651')
  
-- FAIL : A service cannot be scheduled when the duration of the service is not the same length as the duration requested (error 20003)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (9, 30003, 123405678, 11, 2, 3, 8, 2, 3, 11, '4Y1BL651')
  
-- FAIL : A service cannot be scheduled on a saturday if the store isn't open then (error 20001)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (9, 30003, 123405678, 11, 1, 6, 2, 1, 6, 3, '4Y1BL651')

-- FAIL : A service cannot be scheduled on a saturday at a time when the store isn't open (error 20002)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (9, 30001, 241368579, 10001, 3, 6, 4, 3, 6, 5, '4Y1BL658')

-- PASS : A mechanic can work 49 hours a week 
-- NOTE: we have not added prices for this service_center, so we do not expect them to have prices generated everywhere 
    -- setup 
    SELECT * FROM Calendar WHERE invoice_id IS NOT NULL AND eid = 888966655 AND sid = 30004 -- checks to make sure currently no services scheduled for this guy 
    INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10001,'Peter','Parker',30004,'pparker1','parker')
    INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10002,'Diana','Prince',30004,'dprince1','prince')
    INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10003,'Billy','Batson',30004,'bbatson1','batson')

    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('AAAAAAAA','Toyota',53000,'C',2007,10001,30004)
    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('AAAAAAAB','Honda',117000,'C',1999,10001,30004)
    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('CCCCCCCC','Nissan',111000,'C',2015,10002, 30004)
    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('CCCCCCCD','Toyota',53000,'C',2007,10002,30004)
    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('EEEEEEEE','Honda',117000,'C',1999,10003,30004)
    INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('EEEEEEEF','Nissan',111000,'C',2015,10003,30004)

-- PASS : A mechanic can be scheduled 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'C', 115)
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'Power Lock Repair', 106)
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'Muffler Repair', 104)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (10, 30004, 888966655, 10001, 1, 1, 1, 1, 2, 5, 'AAAAAAAA')
    -- check that insert was good 
    SELECT COUNT(*) FROM Calendar WHERE sid = 30004 AND invoice_id IS NOT NULL -- should see 16 entries 

-- PASS : A mechanic can be scheduled 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'C', 115)
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'Power Lock Repair', 106)
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'Muffler Repair', 104)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (11, 30004, 888966655, 10001, 1, 2, 6, 1, 3, 10, 'CCCCCCCC')
    SELECT COUNT(*) FROM Calendar WHERE sid = 30004 AND invoice_id = 11
    SELECT * FROM Vehicle WHERE vin = 'CCCCCCCC' -- check to make sure the schedule should next be A to complete 

-- PASS : A mechanic can be scheduled without a break between 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'C', 115)
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'Power Lock Repair', 106)
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'Muffler Repair', 104)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (12, 30004, 888966655, 10001, 1, 3, 11, 1, 5, 4, 'EEEEEEEE')
    -- check that a mechanic has been scheduled for 48 hours 
    SELECT COUNT(*) FROM Calendar WHERE sid = 30004 AND invoice_id = 12
    SELECT COUNT(*) FROM Calendar WHERE sid = 30004 AND eid = 888966655 AND invoice_id IS NOT NULL

-- PASS: a mechanic can be be scheduled for a timeslot next week 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'C', 115)
INSERT INTO Invoice(id, sid, eid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (13, 30004, 888966655, 2, 1, 1, 2, 1, 9, 'AAAAAAAB')
    -- check 
    SELECT * FROM Calendar WHERE sid = 30004 AND invoice_id = 13

-- FAIL: a mechanic can not be scheduled for more than 50 hours a week 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'A', 113)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (14, 30004, 888966655, 10001, 1, 5, 5, 1, 5, 7, 'CCCCCCCC')

-- PASS : but another mechanic can be working then 
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (14, 30004, 888966666, 10001, 1, 5, 5, 1, 5, 7, 'CCCCCCCC')
    -- check 
    SELECT * FROM Calendar WHERE sid = 30004 and eid = 888966666 AND invoice_id IS NOT NULL

-- PASS : the earlier mechanic can get scheduled for the other two hours though 
    -- setup 
    SELECT COUNT(*) FROM Calendar WHERE sid = 30004 AND invoice_id IS NOT NULL AND eid = 888966655 AND timeslot_week = 1
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'Muffler Repair', 104)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (15, 30004, 888966655, 10001, 1, 5, 5, 1, 5, 6, 'EEEEEEEE')
    -- check (should be at 50 hours)
    SELECT COUNT(*) FROM Calendar WHERE sid = 30004 AND invoice_id IS NOT NULL AND eid = 888966655 AND timeslot_week = 1

-- PASS : A customer tries to pay part of their invoice 
UPDATE Invoice SET amount_paid = 10 WHERE sid = 30003 AND cid = 10501 AND id = 1
    -- check (should be 10 dollars paid)
    SELECT * FROM Invoice WHERE sid = 30003 AND cid = 10501 AND id = 1

-- PASS : A customer tries to pay the rest of their invoice 
UPDATE Invoice SET amount_paid = amount_paid + 200 WHERE sid = 30003 AND cid = 10501 AND id = 1
    -- check (should be paid in full with a good status)
    SELECT * FROM Invoice WHERE sid = 30003 AND cid = 10501 AND id = 1 AND status = 1
    -- check (A customer should have a standing of 1 when their account is in good standing)

-- FAIL : A mechanic cannot request time off when they are already working ( should throw 20005 error)
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (1, 3, 6, 30004, 888966655)

-- PASS : A mechanic can request to take time off 
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (4, 5, 1, 30004, 888966655)
    -- check the timeslot 1 should be absent from this query 
    SELECT * FROM Calendar WHERE sid = 30004 AND eid = 888966655 AND invoice_id IS NULL AND timeslot_week = 4 AND timeslot_day = 5
    -- check the person should be scheduled for this time off
    SELECT * FROM Mechanic_Out WHERE eid = 888966655

-- FAIL : a mechanic cannot get booked for a invoice if they are on vacation 
INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (17, 'A', 113)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (17, 30004, 888966655, 10001, 4, 4, 11, 4, 5, 2, 'CCCCCCCC')