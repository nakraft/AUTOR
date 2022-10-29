CREATE TABLE Service_Center (
	sid NUMBER(10),
	telephone NUMBER(10),
address VARCHAR(100),
mechanic_minimum_rate REAL,
mechanic_maximum_rate REAL,
saturday VARCHAR(5) DEFAULT 'false',
manager_id NUMBER(10),
receptionist_id NUMBER(10),
	PRIMARY KEY (sid)
-- FOREIGN KEY (manager_id) REFERENCES Manager.eid
-- 	ON DELETE SET NULL,
-- FOREIGN KEY (receptionist_id) REFERENCES Receptionist.eid
-- ON DELETE SET NULL
);

CREATE TABLE Employee (
	eid NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) UNIQUE,
	phone NUMBER(10),
	name VARCHAR(50),
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
	eid NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) UNIQUE,
	sid NUMBER(10) NOT NULL,
	salary VARCHAR(50),
	PRIMARY KEY (eid, sid),
FOREIGN KEY (eid) REFERENCES Employee(eid)
ON DELETE CASCADE, 
FOREIGN KEY (sid) REFERENCES Service_Center(sid)
ON DELETE CASCADE
);

CREATE TABLE Contract_Emp (
	eid NUMBER(9) NOT NULL,
	sid NUMBER(10) NOT NULL,
salary REAL,
	PRIMARY KEY (eid, sid),
FOREIGN KEY (eid) REFERENCES Employee(eid)
ON DELETE CASCADE, 
FOREIGN KEY (sid) REFERENCES Service_Center(sid)
ON DELETE CASCADE
);

CREATE TABLE Receptionist (
	eid NUMBER(9) NOT NULL,
	sid NUMBER(10) NOT NULL,
	PRIMARY KEY (eid, sid),
FOREIGN KEY (eid) REFERENCES Employee(eid)
ON DELETE CASCADE, 
FOREIGN KEY (sid) REFERENCES Service_Center(sid)
ON DELETE CASCADE
); 
CREATE TABLE Manager (
	eid NUMBER(9) NOT NULL,
sid NUMBER(10) NOT NULL UNIQUE,
salary REAL,
	PRIMARY KEY (eid, sid),
FOREIGN KEY (eid) REFERENCES Employee(eid)
ON DELETE CASCADE, 
FOREIGN KEY (sid) REFERENCES Service_Center(sid)
ON DELETE CASCADE
);


CREATE TABLE Customer (
	cid NUMBER(10) UNIQUE,
sid NUMBER(10) NOT NULL,
first_name VARCHAR(50),
last_name VARCHAR(50),
status VARCHAR(5) DEFAULT 'false',
standing VARCHAR(5) DEFAULT 'false',
	PRIMARY KEY (cid, sid),
FOREIGN KEY (sid) REFERENCES Service_Center
);

CREATE TABLE Vehicle (
	vin NUMBER(10),
manf VARCHAR(50),
year TIMESTAMP,
mileage REAL,
schedule VARCHAR(1),
cid NUMBER(10) NOT NULL,
sid NUMBER(10) NOT NULL,
	PRIMARY KEY (vin),
FOREIGN KEY (cid) REFERENCES Customer(cid)
	ON DELETE CASCADE, 
FOREIGN KEY(sid) REFERENCES Service_Center(sid)
	ON DELETE CASCADE
);

CREATE TABLE Work_Event (
	name VARCHAR(50),
    event_number NUMBER(10),
	PRIMARY KEY (name, event_number)
);

CREATE TABLE Services (
	name VARCHAR(50),
service_number NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
repair_category VARCHAR(50),
	PRIMARY KEY (name, service_number),
FOREIGN KEY (name, service_number) REFERENCES Work_Event
	ON DELETE CASCADE
);

CREATE TABLE Maintenance (
	name VARCHAR(50),
m_number NUMBER(10),
	PRIMARY KEY (name, m_number),
FOREIGN KEY (name, m_number) REFERENCES Services
	ON DELETE CASCADE, 
	FOREIGN KEY (name, m_number) REFERENCES Work_Event
	ON DELETE CASCADE
);

CREATE TABLE Schedule (
	name VARCHAR(1) CHECK (name IN ('A', 'B', 'C') ),
s_number NUMBER(10),
	PRIMARY KEY (name, s_number),
FOREIGN KEY (name, s_number) REFERENCES Work_Event
	ON DELETE CASCADE
);


CREATE TABLE Cost_Details (
	manf VARCHAR(50),
	price REAL,
	sid NUMBER(10) NOT NULL,
	id_number NUMBER(10),
	name VARCHAR(1),
	PRIMARY KEY (manf,sid,name,id_number),
FOREIGN KEY (sid) REFERENCES Service_Center(sid), 
FOREIGN KEY (name, id_number) REFERENCES Work_Event
);

CREATE TABLE Duration_Details (
	manf VARCHAR(50),
	duration REAL,
	id_number NUMBER(10),
	name VARCHAR(1),
	PRIMARY KEY (manf,name,id_number),
FOREIGN KEY (name, id_number) REFERENCES Work_Event
);


CREATE TABLE Invoice (
	id NUMBER(10),
	total_amount REAL,
	amount_paid REAL,
sid NUMBER(10) NOT NULL,
start_date DATE NOT NULL,
	timeslot NUMBER NOT NULL,
	vin NUMBER(10) NOT NULL,
	eid NUMBER(9) NOT NULL,
	PRIMARY KEY (id),
	-- FOREIGN KEY (sid, start_date, timeslot, eid) REFERENCES Time_Slot,
	FOREIGN KEY (sid) REFERENCES Service_Center(sid),
	FOREIGN KEY (vin) REFERENCES Vehicle(vin), 
FOREIGN KEY (eid) REFERENCES Mechanic(eid), 
FOREIGN KEY (eid) REFERENCES Employee(eid)
);

CREATE TABLE Time_Slot (
	date_time DATE,
	timeslot NUMBER,
timeoff VARCHAR(5) DEFAULT 'false',
	id NUMBER(10) NOT NULL,
	sid  NUMBER(10) NOT NULL,
eid NUMBER(10) NOT NULL,
	PRIMARY KEY (date_time, timeslot, sid, eid),
	FOREIGN KEY (id) REFERENCES Invoice,
FOREIGN KEY (sid) REFERENCES Service_Center
	ON DELETE CASCADE, 
FOREIGN KEY (eid, sid) REFERENCES Mechanic
	ON DELETE CASCADE
);

CREATE TABLE Maintenance_Schedule (
	mname VARCHAR(50),
mnumber NUMBER(10),
sname VARCHAR(50),
snumber NUMBER(10),
	PRIMARY KEY (mname, mnumber, sname, snumber),
FOREIGN KEY (mname, mnumber) REFERENCES Maintenance(name,m_number),
FOREIGN KEY (sname, snumber) REFERENCES Services(name,service_number)
);

CREATE TABLE Mechanic_Timeslot (
slot_date DATE,
timeslot NUMBER,
eid NUMBER(10),
sid NUMBER(10),
PRIMARY KEY (sid, eid, slot_date, timeslot),
FOREIGN KEY (sid, eid, slot_date, timeslot) REFERENCES Time_Slot(sid, eid, date_time, timeslot),
FOREIGN KEY (sid, eid) REFERENCES Mechanic(sid, eid)
);


CREATE TABLE Invoice_HasService (
	id NUMBER(10),
	i_number NUMBER(10),
	name VARCHAR(50),
	PRIMARY KEY (id, i_number, name),
	FOREIGN KEY (id) REFERENCES Invoice,
	FOREIGN KEY (i_number, name) REFERENCES Schedule(s_number, name)
);

CREATE TABLE Invoice_HasSchedule (
	id NUMBER(10),
	PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES Invoice
);
