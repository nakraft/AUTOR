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

-- START TESTING HERE IN MORGEN
-- FAIL : make sure that switching the times will not allow for the donor to become over booked 
       -- setup 
       -- rerun populating full 
       -- make sure that the recieve person has 48 hours for 2 weeks in a row scheduled 
       INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10021,'Peter','Parker',30002,'pparker1','parker')
       INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10022,'Diana','Prince',30002,'dprince1','prince')
       INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10023,'Billy','Batson',30002,'bbatson1','batson')
       INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('AAAAAAAA','Toyota',53000,'C',2007,10021,30002)
       INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('CCCCCCCC','Nissan',111000,'C',2015,10022, 30002)
       INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('EEEEEEEE','Honda',117000,'C',1999,10023,30002)

       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'C', 115)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'Power Lock Repair', 106)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'Muffler Repair', 104)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (10, 30002, 125689347, 10021, 3, 1, 1, 3, 2, 5, 'AAAAAAAA')
       
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'C', 115)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'Power Lock Repair', 106)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'Muffler Repair', 104)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (11, 30002, 125689347, 10022, 3, 2, 6, 3, 3, 10, 'CCCCCCCC') -- TODO, make sure vehicle belongs to this person
 
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'C', 115)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'Belt Replacement', 101)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'Muffler Repair', 104)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (12, 30002, 125689347, 10023, 3, 3, 11, 3, 4, 11, 'EEEEEEEE')

       -- check to make sure 47 hours in week 3 
       SELECT COUNT(*) FROM Calendar WHERE sid = 30002 AND eid = 125689347 AND invoice_id IS NOT NULL AND timeslot_week = 3

       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'C', 115)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'Power Lock Repair', 106)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'Muffler Repair', 104)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (13, 30002, 125689347, 10021, 4, 1, 3, 4, 2, 7, 'AAAAAAAA')
       
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'C', 115)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'Power Lock Repair', 106)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'Muffler Repair', 104)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (14, 30002, 125689347, 10022, 4, 2, 8, 4, 4, 1, 'CCCCCCCC')
 
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'C', 115)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'Power Lock Repair', 106)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'Muffler Repair', 104)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (15, 30002, 125689347, 10023, 4, 4, 2, 4, 5, 6, 'EEEEEEEE')
       -- check to make sure 48 hours in week 3 
       SELECT COUNT(*) FROM Calendar WHERE sid = 30002 AND eid = 125689347 AND invoice_id IS NOT NULL AND timeslot_week = 4

       -- make the donor have a timeslot sometime at the end of week 3 and beginning of 4 (DO not overlap with scheduled times)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (17, 'Power Lock Repair', 106)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (17, 30002, 423186759, 10023, 3, 5, 11, 4, 1, 1, 'EEEEEEEE') 
--- *** RUN AFTER POPULATING FULL MARKER *** Uncomment the tab in populating full and then start testing after this
-- FAIL : make sure that switching the times will not allow for the reciever to become over booked ()
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 3, 4, 5, 1, 11, 1, 2, 2, 1, 1, 3, 5)

-- FAIL : make sure that switching the times will not allow for the donor to become over booked 
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 125689347, 423186759, 2, 2, 1, 1, 3, 5, 3, 4, 5, 1, 11, 1)

-- PASS : it should be able to swap if it will not have issues because the time is split between the two weeks 
       -- setup
       UPDATE Calendar SET invoice_id = NULL WHERE invoice_id = 17 
       DELETE FROM Invoice WHERE id = 17
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (17, 30002, 423186759, 10023, 3, 6, 2, 4, 1, 2, 'EEEEEEEE') 
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 3, 4, 6, 1, 2, 2, 2, 2, 1, 1, 3, 5)
       -- check, event included with status of 0 
       SELECT * FROM Mechanic_Swap_Request 

-- PASS : check to make sure that two things happening at the same time can be swapped 
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (18, 'A', 113)
       INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (19, 'A', 113)
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (18, 30001, 132457689, 10001, 1, 3, 11, 1, 4, 2, '4Y1BL658') 
       INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (19, 30001, 314275869, 10002, 1, 4, 1, 1, 4, 3, '7A1ST264') 
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30001, 132457689, 314275869, 1, 1, 3, 4, 11, 2, 1, 1, 4, 4, 1, 3)
       -- check, event included with status of 0 
       SELECT * FROM Mechanic_Swap_Request 

-- PASS : Upon selecting reject and updating the swap value to 2, nothing should have happened in the calendar or in the invoice list 
       SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 3 AND r.timeslot_day = 5 AND r.timeslot >= 5 AND r.timeslot <= 7) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))
-- to update the status to 2 (reject)
UPDATE Mechanic_Swap_Request SET status = 1 WHERE id = 1
       -- check : the eids should be swapped in invoice and in calendar 
       SELECT * FROM Invoice WHERE sid = 30002
       SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 3 AND r.timeslot_day = 5 AND r.timeslot >= 5 AND r.timeslot <= 7) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))

-- PASS : Upon selecting yes and updating the swap value to 1, ensure that the correct measures are taken to move the values in the Calendar and Invoice 
       -- pre-check. Determine which invoice id both people have 
       SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 2 AND r.timeslot_day = 1 AND r.timeslot >= 3 AND r.timeslot <= 5) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))
       SELECT * FROM Invoice WHERE sid = 30002
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 2, 4, 4, 2, 5, 2, 2, 1, 1, 3, 5)
-- to update the status to 2 (reject)
UPDATE Mechanic_Swap_Request SET status = 2 WHERE id = 1
       -- check nothing should occur
       SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 2 AND r.timeslot_day = 1 AND r.timeslot >= 3 AND r.timeslot <= 5) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))
       SELECT * FROM Invoice WHERE sid = 30002
       SELECT * FROM Mechanic_Swap_Request
-- to update the status to 1 (accept)
UPDATE Mechanic_Swap_Request SET status = 1 WHERE id = 1
       -- check : the eids should be swapped in invoice and in calendar 
       SELECT * FROM Invoice WHERE sid = 30002
       SELECT d.timeslot_week, d.timeslot_day, d.timeslot, d.eid, d.invoice_id, r.timeslot_week, r.timeslot_day, r.timeslot, r.eid, r.invoice_id FROM Calendar d INNER JOIN Calendar r ON r.timeslot_week = d.timeslot_week AND r.timeslot_day = d.timeslot_day AND r.timeslot = d.timeslot WHERE d.sid = 30002 AND r.sid = 30002 AND r.eid = 125689347 AND d.eid = 423186759 AND ((r.timeslot_week = 2 AND r.timeslot_day = 1 AND r.timeslot >= 3 AND r.timeslot <= 5) OR (r.timeslot_week = 2 AND r.timeslot_day = 4 AND r.timeslot >= 2 AND r.timeslot <= 5))

/* 
END TESTS 
Tables to utilize when querying results front end 
*/
-- to view by requesting Mechanic 
SELECT s.id, m.first_name, m.last_name, s.recieve_timeslot_week, s.recieve_timeslot_day, s.recieve_timeslot_begin, s.recieve_timeslot_end, s.donor_timeslot_week, s.donor_timeslot_day,s.donor_timeslot_begin, s.donor_timeslot_end FROM Employee m, Mechanic_Swap_Request s WHERE s.sid = 30002 AND s.recieve_eid = 125689347 AND s.donor_eid = m.eid AND s.status = 0
 -- recieve id should be the current mechanics ID 