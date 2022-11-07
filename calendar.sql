CREATE TABLE Calendar (
    timeslot_day NUMBER(1) CHECK (timeslot_day >= 1 AND timeslot_day <= 6),
    timeslot_week NUMBER(1) CHECK (timeslot_week IN (1,2,3,4)),
	timeslot NUMBER CHECK (timeslot >= 1 AND timeslot <= 11), -- 1 corresonds to 8AM, 5 corresponds to 1 PM. Lunch hour is skipped.
	invoice_id NUMBER(10),
	sid NUMBER(10) NOT NULL,
    eid NUMBER(10) NOT NULL,
	id NUMBER(10),
	PRIMARY KEY (timeslot_week, timeslot_day, timeslot, sid, eid), 
    FOREIGN KEY (invoice_id) REFERENCES Invoice, 
    FOREIGN KEY (sid) REFERENCES Service_Center 
        ON DELETE CASCADE, 
    FOREIGN KEY (eid, sid) REFERENCES Mechanic
        ON DELETE CASCADE
);

CREATE TABLE Mechanic_Out (
    timeslot_day NUMBER(1) CHECK (timeslot_day >= 1 AND timeslot_day <= 6),
    timeslot_week NUMBER(1) CHECK (timeslot_week IN (1,2,3,4)),
	timeslot NUMBER CHECK (timeslot >= 1 AND timeslot <= 11), -- 1 corresonds to 8AM, 5 corresponds to 1 PM. Lunch hour is skipped.
	sid NUMBER(10),
    eid NUMBER(10),
	PRIMARY KEY (timeslot_week, timeslot_day, timeslot, sid, eid),
    FOREIGN KEY (sid) REFERENCES Service_Center 
        ON DELETE CASCADE, 
    FOREIGN KEY (eid, sid) REFERENCES Mechanic
        ON DELETE CASCADE
);
        
-- to be used where the list is empty and timeslots get added when filled 
CREATE TRIGGER time_slot_checks
    BEFORE UPDATE ON Calendar
    FOR EACH ROW
    DECLARE 
        saturday_open EXCEPTION;
        saturday_hours EXCEPTION;
        saturday VARCHAR(5);
    BEGIN 
    
        SELECT s.saturday INTO saturday
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        
        IF (saturday = 'close' OR saturday = 'c') AND :new.timeslot_day = 6 THEN 
            RAISE saturday_open; 
        ELSIF (saturday = 'open' OR saturday = 'o') AND :new.timeslot NOT IN (2,3,4) THEN 
            RAISE saturday_hours;
        END IF;
        
    END; 
/ 

CREATE TRIGGER time_slot_checks_mecahnic_out
    BEFORE UPDATE ON Mechanic_Out
    FOR EACH ROW
    DECLARE 
        saturday_open EXCEPTION;
        saturday_hours EXCEPTION;
        saturday VARCHAR(5);
    BEGIN 
    
        SELECT s.saturday INTO saturday
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        
        IF (saturday = 'close' OR saturday = 'c') AND :new.timeslot_day = 6 THEN 
            RAISE saturday_open; 
        ELSIF (saturday = 'open' OR saturday = 'o') AND :new.timeslot NOT IN (2,3,4) THEN 
            RAISE saturday_hours;
        END IF;
        
    END; 
/ 

-- THIS SHOULD BE ADDED AS ID FIELD CALCULAteD AND INSErted ON FRONT END FOR VALUE
-- CREATE TRIGGER update_id 
--     AFTER INSERT ON Calendar 
--     FOR EACH ROW 
--     DECLARE 
--         PRAGMA AUTONOMOUS_TRANSACTION;
--         idd NUMBER(10); 
--         sat_open VARCHAR(5); 
--     BEGIN 
    
--         SELECT s.saturday INTO sat_open
--         FROM Service_Center s 
--         WHERE s.sid = :new.sid;
        
--         IF (sat_open = 'open' OR sat_open = 'o') AND :new.timeslot_day != 6  THEN 
--           idd := ((:new.timeslot_week - 1) * 58) + ((:new.timeslot_day - 1) * 11) + :new.timeslot;
--         ELSIF (sat_open = 'open' OR sat_open = 'o') AND :new.timeslot_day = 6  THEN 
--           idd := ((:new.timeslot_week - 1) * 58) + ((:new.timeslot_day - 1) * 11) + :new.timeslot - 1;
--         ELSE
--             idd := ((:new.timeslot_week - 1) * 55) + ((:new.timeslot_day - 1) * 11) + :new.timeslot;
--         END IF;
        
--         UPDATE Calendar
--         SET id = idd 
--         WHERE sid = :new.sid AND timeslot_week = :new.timeslot_week AND timeslot_day = :new.timeslot_day AND timeslot = :new.timeslot;
--     END; 
-- /

INSERT ALL 
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 1, 30001, 132457689, 1)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 2, 30001, 132457689, 2)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 3, 30001, 132457689, 3)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 4, 30001, 132457689, 4)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 5, 30001, 132457689, 5)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 6, 30001, 132457689, 6)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 7, 30001, 132457689, 7)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 8, 30001, 132457689, 8)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 9, 30001, 132457689, 9)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 10, 30001, 132457689, 10)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 1, 11, 30001, 132457689, 11)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 1, 30001, 132457689, 12)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 2, 30001, 132457689, 13)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 3, 30001, 132457689, 14)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 4, 30001, 132457689, 15)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 5, 30001, 132457689, 16)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 6, 30001, 132457689, 17)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 7, 30001, 132457689, 18)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 8, 30001, 132457689, 19)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 9, 30001, 132457689, 20)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 10, 30001, 132457689, 21)
  INTO Calendar(time_slot_week, time_slot_day, timeslot, sid, eid, id)  VALUES (1, 2, 11, 30001, 132457689, 22)
SELECT *
  FROM dual;

CREATE TRIGGER mechanic_joins
    AFTER UPDATE ON Mechanic 
    FOR EACH ROW
    BEGIN 
        -- add the mechanic to the full extent of the calendar with null invoice_ids
        -- this should be identical to the above insert into staetments, but automated based on growing the numbers for the full month ahead. 
        
    END; 
/

CREATE TRIGGER mechanic_requests_time_off
    BEFORE UPDATE ON Mechanic_Out
    FOR EACH ROW
    DECLARE 
        mechanics_present NUMBER; 
        service_on NUMBER;
        not_approved EXCEPTION;
    BEGIN 
        
        SELECT COUNT(eid) INTO mechanics_present
        FROM ((SELECT e.eid FROM Mechanic e WHERE sid = :new.sid) EXCEPT 
                (SELECT o.eid FROM Mechnic_Out o WHERE o.time_slot_week = :new.time_slot_week AND o.time_slot_day = :new.time_slot_day AND o.timelot = :new.timeslot AND o.sid = :new.sid));
        
        SELECT COUNT(*) INTO service_on
        FROM Calendar 
        WHERE time_slot_week = :new.time_slot_week AND time_slot_day = :new.time_slot_day AND timelot = :new.timeslot AND sid = :new.sid AND eid = :new.eid AND invoice_id IS NOT NULL;
        
        IF mechanics_present < 3 OR service_on != 0 THEN 
            RAISE not_approved;
        ELSE 
            DELETE FROM Calendar 
            WHERE time_slot_week = :new.time_slot_week AND time_slot_day = :new.time_slot_day AND timelot = :new.timeslot AND sid = :new.sid AND eid = :new.eid;
        END IF;
        
    END; 
/

--- testing query for getting the listing of available times for a service 

-- get the duration for a particular service needed for that manufactorer 
SELECT SUM(dd.dur) 
FROM duration_details dd
WHERE dd.manf = 'Honda' AND ((dd.serviceNumber = 101 AND dd.serviceName = 'Belt Replacement') OR (dd.serviceNumber = 110 AND dd.serviceName = 'Wheel Alignment'));

-- get all the timeslots where the service could fit.
SELECT c.timeslot_week, c.timeslot_day, c.timeslot, c.eid 
FROM Calendar c
WHERE sid = 30001 AND c.invoice_id IS NULL AND 2 - 1 = (SELECT COUNT(c2.id) 
                                                        FROM Calendar c2
                                                        WHERE c2.id > c.id AND c2.id < c.id + 2 AND c.eid = c2.eid AND c2.invoice_id IS NULL;)-- 2 is duration and should be a variable
GROUP BY c.eid, c.timeslot_week, c.timeslot_day, c.timeslot;

-- TODO: the id here needs to be updated so that in each service center, id is growing to keep track of the calendar slot. Multiple ids can exist, so the full key is eid, sid, id