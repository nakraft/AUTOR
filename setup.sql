CREATE TABLE Service_Center (
	sid NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
	telephone NUMBER(10) UNIQUE,
    address VARCHAR(100) UNIQUE,
    mechanic_minimum_rate NUMBER,
    mechanic_maximum_rate NUMBER,
    mechanic_hourly_rate NUMBER,
    saturday VARCHAR(5) DEFAULT 'close' CHECK (saturday IN ('open', 'o', 'close', 'c') ),
    manager_id NUMBER CHECK (manager_id BETWEEN 100000000 and 999999999),
    receptionist_id NUMBER CHECK (receptionist_id BETWEEN 100000000 and 999999999),
    available VARCHAR(9) DEFAULT 'pending' CHECK (available IN ('available', 'pending')), 
	PRIMARY KEY (sid), 
	CHECK (mechanic_maximum_rate >= mechanic_minimum_rate), 
    CHECK (mechanic_hourly_rate IS NULL OR (mechanic_hourly_rate IS NOT NULL AND mechanic_maximum_rate >= mechanic_hourly_rate AND mechanic_minimum_rate <= mechanic_hourly_rate))
);

CREATE TABLE Employee (
	eid NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 100000000 INCREMENT by 1) CHECK (eid BETWEEN 100000000 and 999999999),
	phone NUMBER(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	username VARCHAR(50),
	password VARCHAR(50),
	address VARCHAR(100),
	email VARCHAR(50),
    start_date VARCHAR(20) DEFAULT '2022-01-01',
	sid NUMBER(10) NOT NULL,
	role VARCHAR(20) NOT NULL CHECK (role IN ('mechanic', 'manager', 'receptionist')), 
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (sid) REFERENCES Service_Center
        ON DELETE CASCADE
); 

CREATE TABLE Mechanic (
	eid NUMBER CHECK (eid BETWEEN 100000000 and 999999999),
	sid NUMBER(10),
	rate NUMBER,
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (eid, sid) REFERENCES Employee(eid, sid)
        ON DELETE CASCADE, 
    FOREIGN KEY (sid) REFERENCES Service_Center(sid)
        ON DELETE CASCADE
);

CREATE TABLE Receptionist (
	eid NUMBER CHECK (eid BETWEEN 100000000 and 999999999),
	sid NUMBER(10) UNIQUE,
	salary REAL,
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (eid, sid) REFERENCES Employee(eid, sid)
        ON DELETE CASCADE, 
    FOREIGN KEY (sid) REFERENCES Service_Center(sid)
        ON DELETE CASCADE
); 

CREATE TABLE Manager (
	eid NUMBER(9) CHECK (eid BETWEEN 100000000 and 999999999),
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
	price REAL CHECK (price >= 0),
    sid NUMBER(10) NOT NULL,
    serviceName VARCHAR(50),
	serviceNumber NUMBER(10),
	PRIMARY KEY (manf, sid, serviceName, serviceNumber),
    FOREIGN KEY (sid) REFERENCES Service_Center(sid),
    FOREIGN KEY (serviceName, serviceNumber) REFERENCES Work_Event
);

CREATE TABLE Duration_Details (
	manf VARCHAR(50),
	dur INTEGER CHECK (dur > 0),
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
    repair_category VARCHAR(50) CHECK (repair_category IN ('Engine Services', 'Exhaust Services', 'Electrical Services', 'Transmission Services', 'Tire Services', 'Heating and A/C Services')),
    schedule VARCHAR(1) CHECK (schedule IN ('A', 'B', 'C')),
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
    FOREIGN KEY (mname, mnumber) REFERENCES Services(serviceName,serviceNumber),
    FOREIGN KEY (sname, snumber) REFERENCES Schedule(serviceName,serviceNumber)
);

CREATE TABLE Customer (
	cid NUMBER(9) GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
    sid NUMBER(10) NOT NULL,
	phone NUMBER(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
    status NUMBER(1) DEFAULT 0, -- inactive on add. Then active when car added. 
    balance NUMBER(10) DEFAULT 0, -- tracks the balance of the customer, a partial field needed for standing to be implemented
    standing NUMBER(1) DEFAULT 1, -- starts in good standing. Then updated with updated to invoice. 
    address VARCHAR(100),
    email VARCHAR(50),
    username VARCHAR(50),
	password VARCHAR(50),
	PRIMARY KEY (cid, sid),
    FOREIGN KEY (sid) REFERENCES Service_Center
        ON DELETE CASCADE
);

CREATE TABLE Vehicle (
    vin VARCHAR(10) CHECK (REGEXP_LIKE(vin, '^[A-Za-z0-9]{8}$')),
    manf VARCHAR(50),
    year NUMBER,
    mileage REAL,
    schedule VARCHAR(1) CHECK ((schedule IS NULL) OR (schedule IN ('A', 'B', 'C'))),
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
    date_generated DATE DEFAULT CURRENT_DATE,
	vin VARCHAR(10),
	eid NUMBER(9),
    status NUMBER(1) DEFAULT 0 CHECK (status IN (0, 1)),
	PRIMARY KEY (id),
	FOREIGN KEY (sid) REFERENCES Service_Center,
	FOREIGN KEY (vin) REFERENCES Vehicle,
    FOREIGN KEY (eid, sid) REFERENCES Mechanic
);

CREATE TABLE Calendar (
    timeslot_day NUMBER(1) CHECK (timeslot_day >= 1 AND timeslot_day <= 6),
    timeslot_week NUMBER(1) CHECK (timeslot_week IN (1,2,3,4)),
	timeslot NUMBER CHECK (timeslot >= 1 AND timeslot <= 11), -- 1 corresonds to 8AM, 5 corresponds to 1 PM. Lunch hour is skipped.
	invoice_id NUMBER(10),
	sid NUMBER(10) NOT NULL,
    eid NUMBER(10) CHECK (eid BETWEEN 100000000 and 999999999),
	id NUMBER(10),
    CONSTRAINT pkcalendar
	PRIMARY KEY (timeslot_week, timeslot_day, timeslot, sid, eid) deferrable initially deferred, 
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
    eid NUMBER(10) CHECK (eid BETWEEN 100000000 and 999999999), 
	PRIMARY KEY (timeslot_week, timeslot_day, timeslot, sid, eid),
    FOREIGN KEY (sid) REFERENCES Service_Center 
        ON DELETE CASCADE, 
    FOREIGN KEY (eid, sid) REFERENCES Mechanic
        ON DELETE CASCADE
);

CREATE TABLE Mechanic_Swap_Request (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
    sid NUMBER(10),
    donor_eid NUMBER CHECK (donor_eid BETWEEN 100000000 and 999999999), 
    recieve_eid NUMBER CHECK (recieve_eid BETWEEN 100000000 and 999999999),
    donor_timeslot_begin_week NUMBER CHECK (donor_timeslot_begin_week IN (1,2,3,4)),
    donor_timeslot_end_week NUMBER CHECK (donor_timeslot_end_week IN (1,2,3,4)),
    donor_timeslot_begin_day NUMBER CHECK (donor_timeslot_begin_day >= 1 AND donor_timeslot_begin_day <= 6),
    donor_timeslot_end_day NUMBER CHECK (donor_timeslot_end_day >= 1 AND donor_timeslot_end_day <= 6),
    donor_timeslot_begin NUMBER CHECK (donor_timeslot_begin >= 1 AND donor_timeslot_begin <= 11), 
    donor_timeslot_end NUMBER CHECK (donor_timeslot_end >= 1 AND donor_timeslot_end <= 11), 
    recieve_timeslot_begin_week NUMBER CHECK (recieve_timeslot_begin_week IN (1,2,3,4)),
    recieve_timeslot_end_week NUMBER CHECK (recieve_timeslot_end_week IN (1,2,3,4)),
    recieve_timeslot_begin_day NUMBER CHECK (recieve_timeslot_begin_day >= 1 AND recieve_timeslot_begin_day <= 6),
    recieve_timeslot_end_day NUMBER CHECK (recieve_timeslot_end_day >= 1 AND recieve_timeslot_end_day <= 6),
    recieve_timeslot_begin NUMBER CHECK (recieve_timeslot_begin >= 1 AND recieve_timeslot_begin <= 11), 
    recieve_timeslot_end NUMBER CHECK (recieve_timeslot_end >= 1 AND recieve_timeslot_end <= 11), 
    status NUMBER DEFAULT 0 CHECK (status IN (0, 1, 2)),
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
            WHERE s.sid = :new.sid AND s.saturday IS NOT NULL AND s.receptionist_id IS NOT NULL;
        END IF;
    END;
/

CREATE TRIGGER service_isa
    BEFORE INSERT ON Services
    FOR EACH ROW
    DECLARE
        invalid_category EXCEPTION;
        PRAGMA exception_init( invalid_category, -20001 );
    BEGIN
        IF :new.repair_category IS NOT NULL AND :new.repair_category NOT IN ('Engine Services', 'Exhaust Services', 'Electrical Services', 'Transmission Services', 'Tire Services', 'Heating and A/C Services') THEN 
            raise invalid_category; 
        END IF; 
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

CREATE TRIGGER maintence_isa_schedule
    AFTER INSERT ON Services
    FOR EACH ROW
    DECLARE 
        schedNumber1 NUMBER(10);
    BEGIN
        IF :new.schedule IS NOT NULL THEN 
            SELECT DISTINCT s.serviceNumber INTO schedNumber1
            FROM Schedule s
            WHERE s.serviceName = :new.schedule;
            INSERT INTO Maintenance_Schedule (mname, mnumber, sname, snumber) 
            VALUES (:new.serviceName, :new.serviceNumber, :new.schedule, schedNumber1);
        END IF; 
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
        PRAGMA exception_init( not_approved, -20005 );
        saturday_open EXCEPTION;
        PRAGMA exception_init( saturday_open, -20010 );
        saturday_hours EXCEPTION;
        PRAGMA exception_init( saturday_hours, -20011 );
        saturday VARCHAR(5);
    BEGIN 
        SELECT s.saturday INTO saturday
        FROM Service_Center s 
        WHERE s.sid = :new.sid;
        IF (saturday = 'close' OR saturday = 'c') AND :new.timeslot_day = 6 THEN 
            RAISE saturday_open; 
            DBMS_OUTPUT.put_line ('The store is not open saturday, timeslot day invalid'); 
        ELSIF (saturday = 'open' OR saturday = 'o') AND (:new.timeslot NOT IN (2,3,4) AND :new.timeslot_day = 6) THEN
            RAISE saturday_hours;
            DBMS_OUTPUT.put_line ('The store is open saturday, but these timeslots are invalid'); 
        END IF;
        SELECT COUNT(eid) INTO mechanics_present 
        FROM Calendar c 
        WHERE c.timeslot_week = :new.timeslot_week AND c.timeslot_day = :new.timeslot_day AND c.timeslot = :new.timeslot AND c.sid = :new.sid;
        SELECT COUNT(*) INTO service_on
        FROM Calendar 
        WHERE timeslot_week = :new.timeslot_week AND timeslot_day = :new.timeslot_day AND timeslot = :new.timeslot AND sid = :new.sid AND eid = :new.eid AND invoice_id IS NOT NULL;
        IF mechanics_present < 4 OR service_on != 0 THEN 
            RAISE not_approved;
            DBMS_OUTPUT.put_line ('The mechanic is not allowed to take off at this time.'); 
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
        IF (saturday = 'close' OR saturday = 'c') THEN 
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
        start_id NUMBER; 
        end_id NUMBER;
        saturday_open EXCEPTION;
        PRAGMA exception_init( saturday_open, -20001 );
        saturday_hours EXCEPTION;
        PRAGMA exception_init( saturday_hours, -20002 );
        saturday VARCHAR(5);
        length_services NUMBER; 
        dura NUMBER;
        wrongTime EXCEPTION;
        PRAGMA exception_init( wrongTime, -20003 );
        hoursWorked NUMBER; 
        hoursToWork NUMBER;
        overworking EXCEPTION;
        PRAGMA exception_init( overworking, -20004 );
        serviceCalled VARCHAR(50); 
        lastSchedule VARCHAR(1);
        scheduleWrong EXCEPTION;
        PRAGMA exception_init( scheduleWrong, -20005 );
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
        -- get the two timeslot values 
        SELECT UNIQUE(id) INTO start_id
        FROM Calendar
        WHERE timeslot_week = :new.start_timeslot_week 
        AND timeslot_day = :new.start_timeslot_day AND timeslot = :new.start_timeslot AND eid = :new.eid AND sid = :new.sid;
        SELECT UNIQUE(id) INTO end_id
        FROM Calendar
        WHERE timeslot_week = :new.end_timeslot_week 
        AND timeslot_day = :new.end_timeslot_day AND timeslot = :new.end_timeslot AND eid = :new.eid AND sid = :new.sid;
        -- ensures the length of the invoice matches the expectations for the service durations 
        SELECT SUM(d.dur) INTO length_services  
        FROM Invoice_HasService i 
        LEFT JOIN Duration_Details d 
        ON i.serviceName = d.serviceName AND i.serviceNumber = d.serviceNumber 
        WHERE d.manf = (SELECT manf FROM Vehicle WHERE vin = :new.vin) AND i.id = :new.id;
        SELECT COUNT(*) INTO dura
        FROM Calendar
        WHERE eid = :new.eid AND sid = :new.sid AND id >= start_id AND id <= end_id AND invoice_id IS NULL;
        IF length_services != dura THEN 
            raise wrongTime;
        END IF; 
        -- ensure that the schedule being scheduled is the next schedule needed 
        SELECT COUNT(serviceName) INTO serviceCalled 
        FROM Invoice_HasService 
        WHERE id = :new.id AND serviceName IN ('A', 'B', 'C');
        IF serviceCalled > 1 THEN 
            raise scheduleWrong; -- you cannot have multiple schedules on one invoice 
        ELSIF serviceCalled = 1 THEN 
            SELECT serviceName INTO serviceCalled 
            FROM Invoice_HasService 
            WHERE id = :new.id AND serviceName IN ('A', 'B', 'C');
            SELECT schedule INTO lastSchedule
            FROM Vehicle 
            WHERE vin = :new.vin;
            IF (lastSchedule IS NULL AND serviceCalled != 'A') OR (lastSchedule = 'A' AND serviceCalled != 'B') 
                OR (lastSchedule = 'B' AND serviceCalled != 'C') OR (lastSchedule = 'C' AND serviceCalled != 'A') THEN 
                raise scheduleWrong; 
            END IF; 
        END IF;  
        -- ensures that if this got scheduled with this mechanic, the mechanic wouldn't be working more than the required time a week 
        -- you cannot use having here as there is no way to evaluate how many hours to be worked were attributed to a particular week 
        FOR week_number IN :new.start_timeslot_week..:new.end_timeslot_week LOOP
            SELECT COUNT(*) INTO hoursWorked
            FROM Calendar o 
            WHERE o.eid = :new.eid AND o.sid = :new.sid AND o.timeslot_week = week_number 
            AND o.invoice_id IS NOT NULL;
            SELECT COUNT(*) INTO hoursToWork
            FROM Calendar o 
            WHERE o.eid = :new.eid AND o.sid = :new.sid AND o.timeslot_week = week_number 
            AND id >= start_id AND id <= end_id; 
            IF hoursWorked + hoursToWork > 50 THEN 
                RAISE overworking;
            END IF;
        END LOOP;
        -- makes sure the invoice has the price of the invoice listed 
        SELECT SUM(c.price) INTO :new.total_amount
        FROM Invoice_HasService i 
        LEFT JOIN Cost_Details c 
        ON i.serviceName = c.serviceName AND i.serviceNumber = c.serviceNumber
        WHERE i.id = :new.id AND c.manf = (SELECT v.manf FROM Vehicle v WHERE v.vin = :new.vin) 
        AND c.sid = :new.sid;
        -- makes sure that if the balance is 0 if the status is good 
        IF :new.status = 1 THEN 
            :new.amount_paid := :new.total_amount;
        END IF;
        -- make it clear that the Customer is not in good standing after the service is inserted
        IF :new.total_amount != :new.amount_paid THEN 
            UPDATE Customer 
            SET standing = 0, balance = balance + :new.total_amount - :new.amount_paid 
            WHERE sid = :new.sid AND cid = (SELECT cid FROM Vehicle WHERE vin = :new.vin);
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
    BEGIN 
        -- get the two timeslot values 
        SELECT UNIQUE(id) INTO start_id
        FROM Calendar
        WHERE timeslot_week = :new.start_timeslot_week 
            AND timeslot_day = :new.start_timeslot_day AND timeslot = :new.start_timeslot AND eid = :new.eid AND sid = :new.sid;
        SELECT UNIQUE(id) INTO end_id
        FROM Calendar
        WHERE timeslot_week = :new.end_timeslot_week 
            AND timeslot_day = :new.end_timeslot_day AND timeslot = :new.end_timeslot AND eid = :new.eid AND sid = :new.sid;
        UPDATE Calendar 
        SET invoice_id = :new.id
        WHERE id >= start_id AND id <= end_id AND sid = :new.sid AND eid = :new.eid;
        -- update vehicles if needed 
        SELECT COUNT(serviceName) INTO aa
        FROM Invoice_HasService 
        WHERE id = :new.id AND serviceName IN ('A', 'B', 'C');
        IF aa > 0 THEN 
            UPDATE Vehicle 
            SET schedule = (SELECT serviceName FROM Invoice_HasService WHERE id = :new.id AND serviceName IN ('A', 'B', 'C'))
            WHERE vin = :new.vin; 
        END IF; 
    END; 
/ 

CREATE TRIGGER decide_status_invoice 
     AFTER UPDATE ON Invoice 
     BEGIN
         IF UPDATING('amount_paid') THEN
             UPDATE Invoice 
             SET status = 1
             WHERE total_amount = amount_paid;
         END IF;
     END;
 /

 CREATE TRIGGER update_customer_balance 
    AFTER UPDATE ON Invoice 
    FOR EACH ROW 
    BEGIN
        UPDATE Customer 
        SET balance = balance - (:new.amount_paid - :old.amount_paid)
        WHERE cid = (SELECT cid FROM Vehicle WHERE vin = :new.vin) AND sid = :new.sid; 
    END;
 /

 CREATE TRIGGER determine_customer_standing
     AFTER UPDATE ON Customer
     BEGIN
         IF UPDATING('balance') THEN
             UPDATE Customer
             SET standing = 1
             WHERE balance = 0;
         END IF;
     END;
 /

CREATE TRIGGER request_swap
    BEFORE INSERT ON Mechanic_Swap_Request
    FOR EACH ROW 
    DECLARE 
        hoursWorked NUMBER; 
        hoursToWork NUMBER; 
        donor_exists NUMBER; 
        recieve_exists NUMBER;
        start_donor_id NUMBER; 
        end_donor_id NUMBER;
        start_recieve_id NUMBER; 
        end_recieve_id NUMBER;
        invalid_eid EXCEPTION;
        PRAGMA exception_init( invalid_eid, -20001 );
        donor_free NUMBER; 
        recieve_free NUMBER;
        busy_error EXCEPTION;
        PRAGMA exception_init( busy_error, -20002 );
        too_many_hours EXCEPTION;
        PRAGMA exception_init( too_many_hours, -20003 );
        vacaDays NUMBER; 
        vacation EXCEPTION;
        PRAGMA exception_init( vacation, -20004 );
        donor_hours NUMBER; 
        recieve_hours NUMBER;
    BEGIN
        -- make sure the people and the times match the invoices to switch
        SELECT UNIQUE(id) INTO donor_exists FROM Invoice WHERE start_timeslot_week = :new.donor_timeslot_begin_week AND -- switch back to COUNT(*) if issues 
        end_timeslot_week = :new.donor_timeslot_end_week AND start_timeslot_day = :new.donor_timeslot_begin_day AND
        end_timeslot_day = :new.donor_timeslot_end_day AND start_timeslot = :new.donor_timeslot_begin and
        end_timeslot = :new.donor_timeslot_end AND eid = :new.donor_eid AND sid = :new.sid; 
        SELECT UNIQUE(id) INTO recieve_exists FROM Invoice WHERE start_timeslot_week = :new.recieve_timeslot_begin_week AND
        end_timeslot_week = :new.recieve_timeslot_end_week AND start_timeslot_day = :new.recieve_timeslot_begin_day AND
        end_timeslot_day = :new.recieve_timeslot_end_day AND start_timeslot = :new.recieve_timeslot_begin and
        end_timeslot = :new.recieve_timeslot_end AND eid = :new.recieve_eid AND sid = :new.sid; 
        IF donor_exists IS NULL OR recieve_exists IS NULL THEN  -- switch back to = 0 if issues 
            raise invalid_eid;
        END IF;
        -- make sure there does not exist an invoice with that id and the eid of the other person in either of those slots (double booked)
            -- donor availability 
        SELECT UNIQUE(id) INTO start_donor_id
        FROM Calendar
        WHERE timeslot_week = :new.donor_timeslot_begin_week AND timeslot_day = :new.donor_timeslot_begin_day 
        AND timeslot = :new.donor_timeslot_begin AND eid = :new.donor_eid AND sid = :new.sid;
        SELECT UNIQUE(id) INTO end_donor_id
        FROM Calendar
        WHERE timeslot_week = :new.donor_timeslot_end_week AND timeslot_day = :new.donor_timeslot_end_day 
        AND timeslot = :new.donor_timeslot_end AND eid = :new.donor_eid AND sid = :new.sid;
            -- counts the slots filled at the other persons time for each person
        SELECT COUNT(*) INTO donor_free 
        FROM Calendar 
        WHERE eid = :new.recieve_eid AND sid = :new.sid AND invoice_id IS NOT NULL 
        AND invoice_id != recieve_exists AND id >= start_donor_id AND id <= end_donor_id; 
            -- reciever availability 
        SELECT UNIQUE(id) INTO start_recieve_id
        FROM Calendar
        WHERE timeslot_week = :new.recieve_timeslot_begin_week AND timeslot_day = :new.recieve_timeslot_begin_day 
        AND timeslot = :new.recieve_timeslot_begin AND eid = :new.recieve_eid AND sid = :new.sid;
        SELECT UNIQUE(id) INTO end_recieve_id
        FROM Calendar
        WHERE timeslot_week = :new.recieve_timeslot_end_week AND timeslot_day = :new.recieve_timeslot_end_day 
        AND timeslot = :new.recieve_timeslot_end AND eid = :new.recieve_eid AND sid = :new.sid;
            -- counts the slots filled at the other persons time for each person
        SELECT COUNT(*) INTO recieve_free 
        FROM Calendar 
        WHERE eid = :new.donor_eid AND sid = :new.sid AND invoice_id IS NOT NULL
        AND invoice_id != donor_exists AND id >= start_recieve_id AND id <= end_recieve_id;
        IF donor_free != 0 OR recieve_free != 0 THEN 
            raise busy_error;
        END IF;
        -- make sure that neither person is planning on being on vacation at the swap time 
        -- we can check this by making sure that the length of the timeperiod between the start and end period in the calendar is the length it should be
        SELECT COUNT(*) INTO vacaDays
        FROM Calendar 
        WHERE id >= start_donor_id AND id <= end_donor_id AND sid = :new.sid AND eid = :new.recieve_eid; 
        IF vacaDays != (end_donor_id - start_donor_id + 1) THEN 
            raise vacation; 
        END IF; 
        SELECT COUNT(*) INTO vacaDays
        FROM Calendar 
        WHERE id >= start_recieve_id AND id <= end_recieve_id AND sid = :new.sid AND eid = :new.donor_eid; 
        IF vacaDays != (end_recieve_id - start_recieve_id + 1) THEN 
            raise vacation; 
        END IF; 
        -- just these last two loops are untested START HERE IN MORGEN
        -- make sure that this rebooking does not cause the donor to become overbooked 
        FOR week_number IN :new.recieve_timeslot_begin_week..:new.recieve_timeslot_end_week LOOP
            SELECT COUNT(*) INTO hoursWorked
            FROM Calendar o 
            WHERE o.eid = :new.donor_eid AND o.sid = :new.sid AND o.timeslot_week = week_number 
            AND o.invoice_id IS NOT NULL AND o.invoice_id != donor_exists;
            SELECT COUNT(*) INTO hoursToWork
            FROM Calendar o 
            WHERE o.eid = :new.donor_eid AND o.sid = :new.sid AND o.timeslot_week = week_number 
            AND id >= start_recieve_id AND id <= end_recieve_id; 
            IF hoursWorked + hoursToWork > 50 THEN 
                RAISE too_many_hours;
            END IF;
        END LOOP;
        -- make sure that this rebooking does not cause the reciever to become overbooked 
        FOR week_number IN :new.donor_timeslot_begin_week..:new.donor_timeslot_end_week LOOP
            SELECT COUNT(*) INTO hoursWorked
            FROM Calendar o 
            WHERE o.eid = :new.recieve_eid AND o.sid = :new.sid AND o.timeslot_week = week_number 
            AND o.invoice_id IS NOT NULL AND o.invoice_id != recieve_exists;
            SELECT COUNT(*) INTO hoursToWork
            FROM Calendar o 
            WHERE o.eid = :new.recieve_eid AND o.sid = :new.sid AND o.timeslot_week = week_number 
            AND id >= start_donor_id AND id <= end_donor_id; 
            IF hoursWorked + hoursToWork > 50 THEN 
                RAISE too_many_hours;
            END IF;
        END LOOP;
    END;
/

CREATE TRIGGER update_swap
    AFTER UPDATE ON Mechanic_Swap_Request
    FOR EACH ROW 
    DECLARE 
        invoiceDonor NUMBER; 
        invoiceRecieve NUMBER; 
        start_donor_id NUMBER; 
        end_donor_id NUMBER; 
        start_recieve_id NUMBER; 
        end_recieve_id NUMBER; 
    BEGIN
        IF :new.status = 1 THEN -- condition accepted swap places and close (if 0/2 no action needed)
            -- gets the ids of the invoice to use 
            SELECT id INTO invoiceDonor
            FROM Invoice 
            WHERE sid = :new.sid AND eid = :new.donor_eid AND start_timeslot_week = :new.donor_timeslot_begin_week 
            AND end_timeslot_week = :new.donor_timeslot_end_week AND start_timeslot_day = :new.donor_timeslot_begin_day 
            AND end_timeslot_day = :new.donor_timeslot_end_day AND start_timeslot = :new.donor_timeslot_begin 
            AND end_timeslot = :new.donor_timeslot_end;
            SELECT id INTO invoiceRecieve
            FROM Invoice 
            WHERE sid = :new.sid AND eid = :new.recieve_eid AND start_timeslot_week = :new.recieve_timeslot_begin_week 
            AND end_timeslot_week = :new.recieve_timeslot_end_week AND start_timeslot_day = :new.recieve_timeslot_begin_day 
            AND end_timeslot_day = :new.recieve_timeslot_end_day AND start_timeslot = :new.recieve_timeslot_begin 
            AND end_timeslot = :new.recieve_timeslot_end;
            -- gets the calendar ids to replace with 
            SELECT UNIQUE(id) INTO start_donor_id
            FROM Calendar
            WHERE timeslot_week = :new.donor_timeslot_begin_week AND timeslot_day = :new.donor_timeslot_begin_day 
            AND timeslot = :new.donor_timeslot_begin AND eid = :new.donor_eid AND sid = :new.sid;
            SELECT UNIQUE(id) INTO end_donor_id
            FROM Calendar
            WHERE timeslot_week = :new.donor_timeslot_end_week AND timeslot_day = :new.donor_timeslot_end_day 
            AND timeslot = :new.donor_timeslot_end AND eid = :new.donor_eid AND sid = :new.sid;
            SELECT UNIQUE(id) INTO start_recieve_id
            FROM Calendar
            WHERE timeslot_week = :new.recieve_timeslot_begin_week AND timeslot_day = :new.recieve_timeslot_begin_day 
            AND timeslot = :new.recieve_timeslot_begin AND eid = :new.recieve_eid AND sid = :new.sid;
            SELECT UNIQUE(id) INTO end_recieve_id
            FROM Calendar
            WHERE timeslot_week = :new.recieve_timeslot_end_week AND timeslot_day = :new.recieve_timeslot_end_day 
            AND timeslot = :new.recieve_timeslot_end AND eid = :new.recieve_eid AND sid = :new.sid;
            -- update the calendar for the particular swap 
            UPDATE Calendar 
            SET invoice_id = CASE WHEN invoice_id IS NULL THEN invoiceDonor ELSE NULL END
            WHERE sid = :new.sid AND eid IN (:new.donor_eid, :new.recieve_eid) AND id >= start_donor_id AND id <= end_donor_id;
            UPDATE Calendar 
            SET invoice_id = CASE WHEN invoice_id IS NULL THEN invoiceRecieve ELSE NULL END
            WHERE sid = :new.sid AND eid IN (:new.donor_eid, :new.recieve_eid) AND id >= start_recieve_id AND id <= end_recieve_id;
            -- update the invoice for the particular eids 
            UPDATE Invoice
            SET eid = :new.donor_eid 
            WHERE sid = :new.sid AND eid = :new.recieve_eid AND start_timeslot_week = :new.recieve_timeslot_begin_week 
            AND end_timeslot_week = :new.recieve_timeslot_end_week
            AND start_timeslot_day = :new.recieve_timeslot_begin_day AND end_timeslot_day = :new.recieve_timeslot_end_day 
            AND start_timeslot = :new.recieve_timeslot_begin AND end_timeslot = :new.recieve_timeslot_end; 
            UPDATE Invoice
            SET eid = :new.recieve_eid 
            WHERE sid = :new.sid AND eid = :new.donor_eid AND start_timeslot_week = :new.donor_timeslot_begin_week AND end_timeslot_week = :new.donor_timeslot_end_week
            AND start_timeslot_day = :new.donor_timeslot_begin_day AND end_timeslot_day = :new.donor_timeslot_end_day 
            AND start_timeslot = :new.donor_timeslot_begin AND end_timeslot = :new.donor_timeslot_end; 
        END IF; 
    END;
/

CREATE TRIGGER vehicle_makes_customer_active
    AFTER INSERT ON Vehicle
    FOR EACH ROW 
    BEGIN
        UPDATE Customer 
        SET status = status + 1
        WHERE cid = :new.cid AND sid = :new.sid;
    END; 
/

CREATE TRIGGER vehicle_makes_customer_inactive
    AFTER DELETE ON Vehicle
    FOR EACH ROW 
    BEGIN
        UPDATE Customer 
        SET status = status - 1
        WHERE cid = :old.cid AND sid = :old.sid;
    END; 
/