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


    
    
