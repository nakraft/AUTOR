CREATE TABLE Service_Center (
	sid NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
	telephone NUMBER(10),
    address VARCHAR(100),
    mechanic_minimum_rate NUMBER,
    mechanic_maximum_rate NUMBER,
    mechanic_hourly_rate NUMBER,
    saturday VARCHAR(5) DEFAULT 'close' CHECK (saturday IN ('open', 'o', 'close', 'c') ),
    manager_id NUMBER,
    receptionist_id NUMBER(10),
    available VARCHAR(9) DEFAULT 'pending' CHECK (available IN ('available', 'pending')), 
	PRIMARY KEY (sid), 
	CHECK (mechanic_maximum_rate >= mechanic_minimum_rate)
);

CREATE TABLE Employee (
	eid NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
	phone NUMBER(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	username VARCHAR(50),
	password VARCHAR(50),
	address VARCHAR(100),
	email VARCHAR(50),
    start_date VARCHAR(20) DEFAULT '2022-01-01',
	sid NUMBER(10) NOT NULL,
	role VARCHAR(20) NOT NULL, 
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (sid) REFERENCES Service_Center
        ON DELETE CASCADE
); 

CREATE TABLE Mechanic (
	eid NUMBER,
	sid NUMBER(10),
	rate NUMBER,
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (eid, sid) REFERENCES Employee(eid, sid)
        ON DELETE CASCADE, 
    FOREIGN KEY (sid) REFERENCES Service_Center(sid)
        ON DELETE CASCADE
);

CREATE TABLE Receptionist (
	eid NUMBER,
	sid NUMBER(10) UNIQUE,
	salary REAL,
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (eid, sid) REFERENCES Employee(eid, sid)
        ON DELETE CASCADE, 
    FOREIGN KEY (sid) REFERENCES Service_Center(sid)
        ON DELETE CASCADE
); 

CREATE TABLE Manager (
	eid NUMBER(9),
    sid NUMBER(10) UNIQUE,
    salary REAL,
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (eid, sid) REFERENCES Employee(eid, sid)
        ON DELETE CASCADE, 
    FOREIGN KEY (sid) REFERENCES Service_Center(sid)
        ON DELETE CASCADE
);

CREATE TABLE Work_Event (
	serviceName VARCHAR(50),
    serviceNumber NUMBER(10),
	PRIMARY KEY (serviceName, serviceNumber)
);

CREATE TABLE Cost_Details (
	manf VARCHAR(50),
	price REAL,
    sid NUMBER(10) NOT NULL,
    serviceName VARCHAR(50),
	serviceNumber NUMBER(10),
	PRIMARY KEY (manf, sid, serviceName, serviceNumber),
    FOREIGN KEY (sid) REFERENCES Service_Center(sid),
    FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
);

CREATE TABLE Duration_Details (
	manf VARCHAR(50),
	dur INTEGER,
    serviceName VARCHAR(50),
	serviceNumber NUMBER(10),
	PRIMARY KEY (manf, serviceName, serviceNumber),
    FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
);

CREATE TABLE Schedule (
	serviceName VARCHAR(1) CHECK (serviceName IN ('A', 'B', 'C') ),
    serviceNumber NUMBER(10),
	PRIMARY KEY (serviceName, serviceNumber),
    FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
	    ON DELETE CASCADE
);

CREATE TABLE Services (
	serviceName VARCHAR(50),
    serviceNumber NUMBER(10),
    repair_category VARCHAR(50),
	PRIMARY KEY (serviceName, serviceNumber),
    FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
    	ON DELETE CASCADE
);

CREATE TABLE Maintenance (
	serviceName VARCHAR(50),
    serviceNumber NUMBER(10),
    repairType VARCHAR(50),
    schedule VARCHAR(1) CHECK (schedule IN ('A', 'B', 'C') ),
	PRIMARY KEY (serviceName, serviceNumber),
	FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
	    ON DELETE CASCADE
);

CREATE TABLE Maintenance_Schedule (
	mname VARCHAR(50),
    mnumber NUMBER(10),
    sname VARCHAR(50),
    snumber NUMBER(10),
	PRIMARY KEY (mname, mnumber, sname, snumber),
    FOREIGN KEY (mname, mnumber) REFERENCES Maintenance(serviceName,serviceNumber),
    FOREIGN KEY (sname, snumber) REFERENCES Schedule(serviceName,serviceNumber)
);

CREATE TABLE Customer (
	cid NUMBER(9) GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
    sid NUMBER(10) NOT NULL,
	phone NUMBER(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
    status NUMBER(1) DEFAULT 1,
    standing NUMBER(1) DEFAULT 0,
    address VARCHAR(100),
    email VARCHAR(50),
    username VARCHAR(50),
	password VARCHAR(50),
	PRIMARY KEY (cid, sid),
    FOREIGN KEY (sid) REFERENCES Service_Center
        ON DELETE CASCADE
);

CREATE TABLE Vehicle (
    vin VARCHAR(10),
    manf CHAR(50),
    year NUMBER,
    mileage REAL,
    schedule CHAR(1) DEFAULT 'A',
    cid NUMBER(9) NOT NULL,
    sid NUMBER(10) NOT NULL,
    PRIMARY KEY (vin),
    FOREIGN KEY (cid, sid) REFERENCES Customer
        ON DELETE CASCADE
);

CREATE TABLE Invoice_HasService (
	id NUMBER(10),
	serviceName VARCHAR(50),
    serviceNumber NUMBER(10),
	PRIMARY KEY (id, serviceName, serviceNumber),
	FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
);

CREATE TABLE Invoice (
	id NUMBER(10) GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
	total_amount REAL,
	amount_paid REAL DEFAULT 0,
    sid NUMBER(10),
    start_timeslot_week NUMBER CHECK (start_timeslot_week IN (1,2,3,4)),
    start_timeslot_day NUMBER CHECK (start_timeslot_day >= 1 AND start_timeslot_day <= 6),
    start_timeslot NUMBER CHECK (start_timeslot >= 1 AND start_timeslot <= 11), 
    end_timeslot_week NUMBER CHECK (end_timeslot_week IN (1,2,3,4)),
    end_timeslot_day NUMBER CHECK (end_timeslot_day >= 1 AND end_timeslot_day <= 6),
    end_timeslot NUMBER CHECK (end_timeslot >= 1 AND end_timeslot <= 11), 
	vin VARCHAR(10),
	eid NUMBER(9),
    cid NUMBER(9),
    status NUMBER(1) DEFAULT 0 CHECK (status IN (0, 1)),
	PRIMARY KEY (id),
	FOREIGN KEY (sid) REFERENCES Service_Center,
	FOREIGN KEY (vin) REFERENCES Vehicle,
    FOREIGN KEY (eid, sid) REFERENCES Mechanic,
    FOREIGN KEY (cid, sid) REFERENCES Customer
);

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
    id NUMBER(10),
	PRIMARY KEY (timeslot_week, timeslot_day, timeslot, sid, eid),
    FOREIGN KEY (sid) REFERENCES Service_Center 
        ON DELETE CASCADE, 
    FOREIGN KEY (eid, sid) REFERENCES Mechanic
        ON DELETE CASCADE
);

CREATE TABLE Mechanic_Swap_Request (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
    sid NUMBER(10),
    donor_eid NUMBER, 
    recieve_eid NUMBER, 
    donor_timeslot_day NUMBER CHECK (donor_timeslot_day >= 1 AND donor_timeslot_day <= 6),
    donor_timeslot_week NUMBER CHECK (donor_timeslot_week IN (1,2,3,4)),
    donor_timeslot_begin NUMBER CHECK (donor_timeslot_begin >= 1 AND donor_timeslot_begin <= 11), 
    donor_timeslot_end NUMBER CHECK (donor_timeslot_end >= 1 AND donor_timeslot_end <= 11), 
    recieve_timeslot_day NUMBER CHECK (recieve_timeslot_day >= 1 AND recieve_timeslot_day <= 6),
    recieve_timeslot_week NUMBER CHECK (recieve_timeslot_week IN (1,2,3,4)),
    recieve_timeslot_begin NUMBER CHECK (recieve_timeslot_begin >= 1 AND recieve_timeslot_begin <= 11), 
    recieve_timeslot_end NUMBER CHECK (recieve_timeslot_end >= 1 AND recieve_timeslot_end <= 11), 
    state NUMBER DEFAULT 0 CHECK (state IN (0, 1, 2)),
    PRIMARY KEY (id, sid), 
    FOREIGN KEY (donor_eid, sid) REFERENCES Mechanic (eid, sid)
        ON DELETE CASCADE,
    FOREIGN KEY (recieve_eid, sid) REFERENCES Mechanic (eid, sid)
        ON DELETE CASCADE, 
    FOREIGN KEY (sid) REFERENCES Service_Center 
        ON DELETE CASCADE
);

-- Beginning all triggers

CREATE TRIGGER add_manager_as_employee
    AFTER INSERT ON Service_Center
    FOR EACH ROW
    BEGIN
        INSERT INTO Employee (eid, sid, role) 
        VALUES (:new.manager_id, :new.sid, 'manager');
    END;
/

CREATE TRIGGER employee_isa
    AFTER INSERT ON Employee
    FOR EACH ROW
    DECLARE 
        staffed NUMBER;
    BEGIN
        IF :new.role = 'manager' THEN
            INSERT INTO Manager (eid, sid) 
            VALUES (:new.eid, :new.sid);
        ELSIF :new.role = 'receptionist' THEN 
            INSERT INTO Receptionist (eid, sid)
            VALUES (:new.eid, :new.sid); 
        ELSIF :new.role = 'mechanic' THEN 
            INSERT INTO Mechanic (eid, sid) 
            VALUES (:new.eid, :new.sid); 
        END IF;
        SELECT COUNT(e.eid) INTO staffed
        FROM Mechanic e
        WHERE e.sid = :new.sid; 
        IF staffed >= 3 THEN 
            UPDATE Service_Center s
            SET s.available = 'available'
            WHERE s.sid = :new.sid;
        END IF;
    END;
/

CREATE TRIGGER service_isa
    BEFORE INSERT ON Services
    FOR EACH ROW
    BEGIN
        INSERT INTO work_event (serviceName, serviceNumber) 
        VALUES (:new.serviceName, :new.serviceNumber);
    END;
/

CREATE TRIGGER schedule_isa
    BEFORE INSERT ON Schedule
    FOR EACH ROW
    BEGIN
        INSERT INTO work_event (serviceName, serviceNumber) 
        VALUES (:new.serviceName, :new.serviceNumber);
    END;
/
                    
CREATE TRIGGER maintence_isa
    BEFORE INSERT ON Maintenance
    FOR EACH ROW
    DECLARE cat VARCHAR(50);
    BEGIN
        IF (:new.repairType = 'repair') THEN
            SELECT DISTINCT s.repair_category INTO cat
                    FROM Services s
                    WHERE s.serviceName = :new.serviceName;
            INSERT INTO Services (serviceName, serviceNumber, repair_category) 
            VALUES (:new.serviceName, :new.serviceNumber, cat);
        ELSE
            INSERT INTO work_event (serviceName, serviceNumber) 
            VALUES (:new.serviceName, :new.serviceNumber);
        END IF;
    END;
/

CREATE TRIGGER maintence_isa_schedule
    AFTER INSERT ON Maintenance
    FOR EACH ROW
    DECLARE schedNumber NUMBER(10);
    BEGIN
        SELECT DISTINCT s.serviceNumber INTO schedNumber 
        FROM Schedule s
        WHERE s.serviceName = :new.schedule;
        INSERT INTO Maintenance_Schedule (mname, mnumber, sname, snumber) 
        VALUES (:new.serviceName, :new.serviceNumber, :new.schedule, schedNumber);
    END;
/
    
CREATE TRIGGER rate_in_check
    BEFORE UPDATE ON Mechanic 
    FOR EACH ROW
    DECLARE 
        out_of_range EXCEPTION;
        mechanic_min_rate NUMBER;
        mechanic_max_rate NUMBER;
    BEGIN 
        SELECT DISTINCT s.mechanic_minimum_rate INTO mechanic_min_rate 
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        SELECT DISTINCT s.mechanic_maximum_rate INTO mechanic_max_rate 
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        IF :new.rate < mechanic_min_rate OR :new.rate > mechanic_max_rate THEN
            RAISE out_of_range;
        END IF; 
    END; 
/

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
        ELSIF (saturday = 'open' OR saturday = 'o') AND (:new.timeslot NOT IN (2,3,4) AND :new.timeslot_day = 6)  THEN 
            RAISE saturday_hours;
        END IF; 
    END; 
/ 

CREATE TRIGGER receptionist_for_center
    BEFORE INSERT ON Employee
    FOR EACH ROW
    BEGIN
        IF :new.role = 'receptionist' THEN 
            UPDATE Service_Center
            SET Service_Center.receptionist_id = :new.eid
            WHERE Service_Center.sid = :new.sid;
        END IF;
    END;
/

CREATE TRIGGER mechanic_requests_time_off
    BEFORE INSERT ON Mechanic_Out
    FOR EACH ROW
    DECLARE 
        mechanics_present NUMBER; 
        service_on NUMBER;
        not_approved EXCEPTION;
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
        SELECT COUNT(eid) INTO mechanics_present 
        FROM Calendar c 
        WHERE c.timeslot_week = :new.timeslot_week AND c.timeslot_day = :new.timeslot_day AND c.timeslot = :new.timeslot AND c.sid = :new.sid;
        SELECT COUNT(*) INTO service_on
        FROM Calendar 
        WHERE timeslot_week = :new.timeslot_week AND timeslot_day = :new.timeslot_day AND timeslot = :new.timeslot AND sid = :new.sid AND eid = :new.eid AND invoice_id IS NOT NULL;
        IF mechanics_present < 4 OR service_on != 0 THEN 
            RAISE not_approved;
        ELSE 
            DELETE FROM Calendar 
            WHERE timeslot_week = :new.timeslot_week AND timeslot_day = :new.timeslot_day AND timeslot = :new.timeslot AND sid = :new.sid AND eid = :new.eid;
        END IF;
    END; 
/

CREATE TRIGGER generate_mechanic_schedule 
    AFTER INSERT ON Mechanic
    FOR EACH ROW
    DECLARE 
        saturday VARCHAR(5);
    BEGIN 
        SELECT s.saturday INTO saturday
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        -- if saturday closed 
        IF (saturday = 'closed' OR saturday = 'c') THEN 
            FOR week_number IN 1..4 LOOP
                FOR day_number IN 1..5 LOOP
                    FOR timeslot IN 1..11 LOOP
                        INSERT INTO Calendar(timeslot_week, timeslot_day, timeslot, sid, eid, id)  
                        VALUES (week_number, day_number, timeslot, :new.sid, :new.eid, ((week_number - 1) * 55) + ((day_number - 1) * 11) + timeslot);
                    END LOOP;
                END LOOP;
            END LOOP;
        ELSIF (saturday = 'open' OR saturday = 'o') THEN 
            -- if saturday open
            FOR week_number IN 1..4 LOOP
                FOR day_number IN 1..6 LOOP
                    IF day_number <= 5 THEN 
                        FOR timeslot IN 1..11 LOOP
                            INSERT INTO Calendar(timeslot_week, timeslot_day, timeslot, sid, eid, id)  
                            VALUES (week_number, day_number, timeslot, :new.sid, :new.eid, ((week_number - 1) * 58) + ((day_number - 1) * 11) + timeslot);
                        END LOOP;
                    ELSIF day_number = 6 THEN 
                        FOR timeslot IN 2..4 LOOP
                            INSERT INTO Calendar(timeslot_week, timeslot_day, timeslot, sid, eid, id)  
                            VALUES (week_number, day_number, timeslot, :new.sid, :new.eid, ((week_number - 1) * 58) + ((day_number - 1) * 11) + timeslot - 1);
                        END LOOP;
                    END IF;
                END LOOP;
            END LOOP;
        END IF;
    END; 
/

CREATE TRIGGER invoice_checks 
    BEFORE INSERT ON Invoice 
    FOR EACH ROW 
    DECLARE 
        saturday_open EXCEPTION;
        saturday_hours EXCEPTION;
        saturday VARCHAR(5);
        length_services NUMBER; 
        dura NUMBER;
        wrongTime EXCEPTION;
    BEGIN 
        -- checks to make sure it is being scheduled for a time that is allowable by the calendar 
        SELECT s.saturday INTO saturday
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        IF (saturday = 'close' OR saturday = 'c') AND (:new.start_timeslot_day = 6 OR :new.end_timeslot_day = 6) THEN 
            RAISE saturday_open; 
        ELSIF (saturday = 'open' OR saturday = 'o') AND ((:new.start_timeslot NOT IN (2,3,4) AND :new.start_timeslot_day = 6) OR (:new.end_timeslot NOT IN (2,3,4) AND :new.end_timeslot_day = 6)) THEN 
            RAISE saturday_hours;
        END IF; 
        -- ensures the length of the invoice matches the expectations for the service durations 
        SELECT SUM(d.dur) INTO length_services  
        FROM Invoice_HasService i 
        LEFT JOIN Duration_Details d 
        ON i.serviceName = d.serviceName AND i.serviceNumber = d.serviceNumber 
        WHERE d.manf = (SELECT manf FROM Vehicle WHERE vin = :new.vin) AND i.id = :new.id;
        SELECT COUNT(*) INTO dura
        FROM Calendar
        WHERE eid = :new.eid AND sid = :new.sid AND timeslot_week >= :new.start_timeslot_week 
            AND timeslot_week <= :new.end_timeslot_week AND timeslot_day >= :new.start_timeslot_day
            AND timeslot_day <= :new.start_timeslot_day AND timeslot >= :new.start_timeslot
            AND timeslot <= :new.end_timeslot;
        IF length_services != dura THEN 
            raise wrongTime;
        END IF; 
    END;
/

CREATE TRIGGER invoice_propogate
    AFTER INSERT ON INVOICE
    FOR EACH ROW
    DECLARE
        start_id NUMBER; 
        end_id NUMBER;
        aa NUMBER;
        bb NUMBER;
        cc NUMBER;
    BEGIN 
        -- get the two timeslot values 
        SELECT UNIQUE(id) INTO start_id
        FROM Calendar
        WHERE timeslot_week = :new.start_timeslot_week 
            AND timeslot_day = :new.start_timeslot_day AND timeslot = :new.start_timeslot AND eid = :new.eid;
        SELECT UNIQUE(id) INTO end_id
        FROM Calendar
        WHERE timeslot_week = :new.end_timeslot_week 
            AND timeslot_day = :new.end_timeslot_day AND timeslot = :new.end_timeslot AND eid = :new.eid;
        UPDATE Calendar 
        SET invoice_id = :new.id
        WHERE id >= start_id AND id <= end_id AND sid = :new.sid AND eid = :new.eid;
        -- update vehicles if needed 
        SELECT COUNT(serviceName) INTO aa
        FROM Invoice_HasService 
        WHERE id = :new.id AND serviceName = 'A';
        SELECT COUNT(serviceName) INTO bb
        FROM Invoice_HasService 
        WHERE id = :new.id AND serviceName = 'B';
        SELECT COUNT(serviceName) INTO cc
        FROM Invoice_HasService 
        WHERE id = :new.id AND serviceName = 'B';
        IF aa > 0 THEN 
            UPDATE Vehicle 
            SET schedule = 'B'
            WHERE vin = :new.vin; 
        END IF; 
        IF bb > 0 THEN 
            UPDATE Vehicle 
            SET schedule = 'C'
            WHERE vin = :new.vin; 
        END IF; 
        IF cc > 0 THEN 
            UPDATE Vehicle 
            SET schedule = 'A'
            WHERE vin = :new.vin; 
        END IF; 
    END; 
/ 

CREATE TRIGGER request_swap
    BEFORE INSERT ON Mechanic_Swap_Request
    FOR EACH ROW 
    DECLARE 
        recieve_begin_id NUMBER; 
        donor_begin_id NUMBER;
        invalid_eid EXCEPTION;
        busy_error EXCEPTION;
        too_many_hours EXCEPTION;
        donor_hours NUMBER; 
        recieve_hours NUMBER;
    BEGIN
        -- get the two timeslot values 
        SELECT DISTINCT(c.id) INTO donor_begin_id
        FROM Calendar c 
        WHERE c.timeslot_week = :new.donor_timeslot_week 
            AND c.timeslot_day = :new.donor_timeslot_day AND c.timeslot = :new.donor_timeslot_begin;
        SELECT DISTINCT(c.id) INTO recieve_begin_id
        FROM Calendar c 
        WHERE c.timeslot_week = :new.recieve_timeslot_week 
            AND c.timeslot_day = :new.recieve_timeslot_day AND c.timeslot = :new.recieve_timeslot_begin;
        -- make sure there exists an invoice with that id and that eid with that timeslot in the invoice table for both donor and recipeint 
        IF NOT EXISTS (SELECT * FROM Invoice WHERE timeslot_id_start = donor_begin_id AND timeslot_id_end = (donor_begin_id + :new.donor_timeslot_end - :new.donor_timeslot_begin) AND eid = :new.donor_eid AND sid = :new.sid) 
            OR NOT EXISTS (SELECT * FROM Invoice WHERE timeslot_id_start = recieve_begin_id AND timeslot_id_end = (recieve_begin_id + :new.recieve_timeslot_end - :new.recieve_timeslot_begin) AND eid = :new.recieve_eid AND sid = :new.sid) THEN 
            raise invalid_eid;
        END IF;
        -- make sure there does not exist an invoice with that id and the eid of the other person in either of those slots (double booked)
        IF EXISTS (SELECT * FROM Invoice WHERE timeslot_id_start = donor_begin_id AND timeslot_id_end = (donor_begin_id + :new.donor_timeslot_end - :new.donor_timeslot_begin) AND eid = :new.recieve_eid AND sid = :new.sid) 
            OR EXISTS (SELECT * FROM Invoice WHERE timeslot_id_start = recieve_begin_id AND timeslot_id_end = (recieve_begin_id + :new.recieve_timeslot_end - :new.recieve_timeslot_begin) AND eid = :new.donor_eid AND sid = :new.sid) THEN 
            raise busy_error;
        END IF;
        -- make sure that this rebooking does not cause either person to become overbooked 
        SELECT COUNT(*) INTO donor_hours
        FROM Calendar
        WHERE eid = :new.donor_eid AND sid = :new.sid AND timeslot_week = :new.recieve_timeslot_week AND invoice_id IS NOT NULL;
        SELECT COUNT(*) INTO recieve_hours
        FROM Calendar
        WHERE eid = :new.recieve_eid AND timeslot_week = :new.donor_timeslot_week AND invoice_id IS NOT NULL;
        IF (:new.donor_timeslot_week = :new.recieve_timeslot_week AND ((donor_hours - (:new.donor_timeslot_end - :new.donor_timeslot_begin) + (:new.recieve_timeslot_end - :new.recieve_timeslot_begin)) > 50 OR 
                (recieve_hours + (:new.donor_timeslot_end - :new.donor_timeslot_begin) - (:new.recieve_timeslot_end - :new.recieve_timeslot_begin)) > 50)) OR 
            (:new.donor_timeslot_week != :new.recieve_timeslot_week AND ((donor_hours + (:new.recieve_timeslot_end - :new.recieve_timeslot_begin)) > 50 OR 
                (recieve_hours + (:new.donor_timeslot_end - :new.donor_timeslot_begin)) > 50)) THEN 
                raise too_many_hours;
        END IF; 
    END;
/