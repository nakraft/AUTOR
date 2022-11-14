-- mechanic swap functionality 
-- should FAIL not the real invoice (20001)
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_week, donor_timeslot_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_week, recieve_timeslot_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 1, 4, 2, 5, 3, 5, 5, 7)
INSERT INTO Mechanic_Swap_Request (donor_eid, recieve_eid, donor_timeslot_week, donor_timeslot_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_week, recieve_timeslot_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (123405678, 123450678, 1, 2, 1, 1, 1, 2, 1, 1)

--- should fail, busy during swap (20002)
INSERT INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES (8, 'Compressor Repair', 111)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (8, 30002, 423186759, 10053, 2, 1, 4, 2, 1, 6, '5TR3K914', 1)
INSERT INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES (9, 'Compressor Repair', 111)
INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (8, 30002, 423186759, 10053, 2, 1, 4, 2, 1, 6, '5TR3K914', 1)


INSERT INTO Mechanic_Swap_Request (sid, donor_eid, recieve_eid, donor_timeslot_week, donor_timeslot_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_week, recieve_timeslot_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 125689347, 423186759, 2, 1, 3, 5, 2, 1, 4, 6)


-- should PASS
INSERT INTO Mechanic_Swap_Request(sid, donor_eid, recieve_eid, donor_timeslot_week, donor_timeslot_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_week, recieve_timeslot_day, recieve_timeslot_begin, recieve_timeslot_end) VALUES (30002, 423186759, 125689347, 2, 4, 2, 5, 3, 5, 5, 7)

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