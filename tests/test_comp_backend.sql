-- PASS: Can insert a service center 
INSERT INTO Service_Center(sid, address, telephone, manager_id) VALUES (30004, 'testing address', 8888888888, 888999333)
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

-- FAIL : With only three mechanics at the service center no one can request time off 
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid, id) VALUES (1, 1, 1, 30004, 888966666, 1)

-- PASS : Anouther mechanic can be added and now the day can be taken off 
INSERT INTO Employee(sid, eid, role) VALUES (30004, 888966655, 'mechanic')
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid, id) VALUES (1, 1, 1, 30004, 888966666, 1)
    -- check 
    SELECT * FROM Mechanic_Out

-- FAIL : A mechanic cannot ask for the same time off twice 
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid, id) VALUES (1, 1, 1, 30004, 888966666, 1)

-- FAIL : Anouther mechanic cannot ask for the time off now as there is already a person out from it (20005 error)
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid, id) VALUES (1, 1, 1, 30004, 888999666, 1)

-- FAIL : Schedule someone to work... a mechanic cannot take this time off either -- NOTE THIS ONLY WORKS AS INVOICE_ID ALREADY IS 1 
UPDATE Calendar SET invoice_id = 1 WHERE eid = 888999666 AND sid = 30004 and id = 2
INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid, id) VALUES (1, 1, 2, 30004, 888999666, 2)
UPDATE Calendar SET invoice_id = 0 WHERE eid = 888999666 AND sid = 30004 and id = 2

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

