CREATE TABLE Service_Center (
	sid NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
	telephone NUMBER(10),
    address VARCHAR(100),
    mechanic_minimum_rate REAL,
    mechanic_maximum_rate REAL,
    saturday VARCHAR(5) DEFAULT 'false',
    manager_id NUMBER,
    receptionist_id NUMBER(10),
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
	sid NUMBER(10) NOT NULL,
	role VARCHAR(20) NOT NULL, 
	PRIMARY KEY (eid, sid),
    FOREIGN KEY (sid) REFERENCES Service_Center
        ON DELETE CASCADE
); 

CREATE TABLE Mechanic (
	eid NUMBER,
	sid NUMBER(10),
	rate VARCHAR(50),
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
    END;
/

CREATE TABLE Work_Event (
	serviceName VARCHAR(50),
    serviceNumber NUMBER(10),
	PRIMARY KEY (serviceName, serviceNumber)
);

CREATE TABLE Duration_Details (
	manf VARCHAR(50),
	dur INTEGER,
	serviceNumber NUMBER(10),
	serviceName VARCHAR(50),
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