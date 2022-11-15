-- regenerate database before this line of testing is undergone

-- mechanic swap functionality 

-- PASS : testing basic swap functionality 
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 5)
       -- check the swap is requested (no actions should yet take place)
       SELECT * FROM Mechanic_Swap_Request
       
-- FAIL : should FAIL not the real invoice (no data found error caused by trying to grab the id of a null value)
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 6, 2, 2, 1, 1, 3, 5)
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 4)

-- FAIL : you cannot swap if the reciever is busy at that time 
       -- setup 
       DELETE FROM Mechanic_Swap_Request
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'A', 113)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (10, 30002, 125689347, 10053, 2, 4, 5, 2, 4, 7, '5TR3K914')
              -- check 
              SELECT * FROM Calendar WHERE eid = 125689347 AND invoice_id = 10
       -- FAIL : should throw a 20002 error 
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 5)

-- FAIL : you cannot swap if the donor is busy at that time 
       -- setup 
       UPDATE Calendar SET invoice_id = NULL WHERE eid = 125689347 AND invoice_id = 10 AND sid = 30002 
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'A', 113)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (11, 30002, 423186759, 10053, 2, 1, 4, 2, 1, 6, '5TR3K914')
              -- check 
              SELECT * FROM Calendar WHERE eid = 423186759 AND invoice_id = 11
       -- FAIL : should throw a 20002 error 
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 5)

-- FAIL : you cannot swap if the person would be on vacation during that time instead (error 20004 raised)
       -- rerun populating full 
       -- have the reciever go on vacation during donors time 
       INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (2, 4, 2, 30002, 125689347)
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 5)

-- FAIL : you cannot swap if the person would be on vacation during that time instead (error 20004 raised)
       -- rerun populating full 
       -- have the donor go on vacation during donors time 
       INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES (2, 1, 5, 30002, 423186759)
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 5)

-- FAIL : make sure that switching the times will not allow for the donor to become over booked 
TODO 
-- FAIL : make sure that switching the times will not allow for the reciever to become over booked 
TODO
-- PASS : Upon selecting yes and updating the swap value to 1, ensure that the correct measures are taken to move the values in the Calendar and Invoice 
TODO 

/* Tables to utilize when querying results front end */
-- to view by requesting Mechanic 
SELECT s.id, m.first_name, m.last_name, s.recieve_timeslot_week, s.recieve_timeslot_day, s.recieve_timeslot_begin, s.recieve_timeslot_end, s.donor_timeslot_week, s.donor_timeslot_day,s.donor_timeslot_begin, s.donor_timeslot_end FROM Employee m, Mechanic_Swap_Request s WHERE s.sid = 30002 AND s.recieve_eid = 125689347 AND s.donor_eid = m.eid AND s.status = 0
 -- recieve id should be the current mechanics ID 

 -- pre-check. Determine which invoice id both people have 
        SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 3 AND r.timeslot_day = 5 AND r.timeslot >= 5 AND r.timeslot <= 7) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))
 -- to update the status to 1 (accept)
 UPDATE Mechanic_Swap_Request SET status = 1 WHERE id = 1
    -- check : the eids should be swapped in invoice and in calendar 
    SELECT * FROM Invoice WHERE sid = 30002
    SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 3 AND r.timeslot_day = 5 AND r.timeslot >= 5 AND r.timeslot <= 7) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))
