-- Header
/* 
Project 1 
Populating SQL Data Tables 
https://livesql.oracle.com/apex/livesql/s/nzokxqt57ehqsog1z3kfnv7kv
*/

/* 
Initializing the system with information UNIVERSAL to all stores
- includes individual services 
- service categories 
- service bundles (schedules)
- service duration
*/

INSERT ALL
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Belt Replacement', 101, 'Engine Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Engine Repair', 102, 'Engine Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Exhaust Repair', 103, 'Exhaust Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Muffler Repair', 104, 'Exhaust Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Alternator Repair', 105, 'Electrical Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Power Lock Repair', 106, 'Electrical Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Axle Repair', 107, 'Transmission Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Brake Repair', 108, 'Transmission Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Tire Balancing', 109, 'Tire Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Wheel Alignment', 110, 'Tire Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Compressor Repair', 111, 'Heating and A/C Services')
  INTO Services(serviceName, serviceNumber, repair_category) VALUES('Evaporator Repair', 112, 'Heating and A/C Services')
SELECT *
  FROM dual;

INSERT ALL
  INTO schedule(serviceName, serviceNumber) VALUES('A', 113)
  INTO schedule(serviceName, serviceNumber) VALUES('B', 114)
  INTO schedule(serviceName, serviceNumber) VALUES('C', 115)
SELECT *
  FROM dual;

INSERT ALL
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Oil Changes', 113, 'A')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Filter Replacements', 113, 'A')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Oil Changes', 114, 'B')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Filter Replacements', 114, 'B')
  INTO Maintenance(serviceName, serviceNumber, schedule, repairType) VALUES('Brake Repair', 114, 'B', 'repair')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Check Engine Light Diagnostics', 114, 'B')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Oil Changes', 115, 'C')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Filter Replacements', 115, 'C')
  INTO Maintenance(serviceName, serviceNumber, schedule, repairType) VALUES('Brake Repair', 115, 'C', 'repair')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Check Engine Light Diagnostics', 115, 'C')
  INTO Maintenance(serviceName, serviceNumber, schedule) VALUES('Suspension Repair', 115, 'C')
  INTO Maintenance(serviceName, serviceNumber, schedule, repairType) VALUES('Evaporator Repair', 115, 'C', 'repair')
SELECT *
  FROM dual;
 
INSERT ALL 
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Belt Replacement', 101, 'Honda', 1)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Engine Repair', 102, 'Honda', 5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Exhaust Repair', 103, 'Honda', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Muffler Repair', 104, 'Honda', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Alternator Repair', 105, 'Honda', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Power Lock Repair', 106, 'Honda', 5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Axle Repair', 107, 'Honda', 7)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Brake Repair', 108, 'Honda', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Tire Balancing', 109, 'Honda', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Wheel Alignment', 110, 'Honda', 1)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Compressor Repair', 111, 'Honda', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Evaporator Repair', 112, 'Honda', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('A', 113, 'Honda', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('B', 114, 'Honda', 6)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('C', 115, 'Honda', 9)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Belt Replacement', 101, 'Nissan', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Engine Repair', 102, 'Nissan', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Exhaust Repair', 103, 'Nissan',5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Muffler Repair', 104, 'Nissan', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Alternator Repair', 105, 'Nissan', 5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Power Lock Repair', 106, 'Nissan', 6)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Axle Repair', 107, 'Nissan', 8)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Brake Repair', 108, 'Nissan', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Tire Balancing', 109, 'Nissan', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Wheel Alignment', 110, 'Nissan', 1)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Compressor Repair', 111, 'Nissan', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Evaporator Repair', 112, 'Nissan', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('A', 113, 'Nissan', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('B', 114, 'Nissan', 7)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('C', 115, 'Nissan', 9)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Belt Replacement', 101, 'Toyota', 1)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Engine Repair', 102, 'Toyota', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Exhaust Repair', 103, 'Toyota',4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Muffler Repair', 104, 'Toyota', 1)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Alternator Repair', 105, 'Toyota', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Power Lock Repair', 106, 'Toyota', 4)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Axle Repair', 107, 'Toyota', 5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Brake Repair', 108, 'Toyota', 5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Tire Balancing', 109, 'Toyota', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Wheel Alignment', 110, 'Toyota', 3)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Compressor Repair', 111, 'Toyota', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('Evaporator Repair', 112, 'Toyota', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('A', 113, 'Toyota', 2)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('B', 114, 'Toyota', 5)
    INTO duration_details(serviceName, serviceNumber, manf, dur) VALUES('C', 115, 'Toyota', 8)
SELECT *
  FROM dual;

INSERT ALL
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10001,'Peter','Parker',30001,'pparker','parker')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10002,'Diana','Prince',30001,'dprince','prince')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10053,'Billy','Batson',30002,'bbatson','batson')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10010,'Bruce','Wayne',30002,'bwayne','wayne')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10001,'Steve','Rogers',30002,'srogers','rogers')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10035,'Happy','Hogan',30002,'hhogan','hogan')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10002,'Tony','Stark',30003,'tstark','stark')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10003,'Natasha','Romanoff',30003,'nromanoff','romanoff')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10011,'Harvey','Bullock',30003,'hbullock','bullock')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10062,'Sam','Wilson',30003,'swilson','wilson')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10501,'Wanda','Maximoff',30003,'wmaximoff','maximoff')
  INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10010,'Virginia','Potts',30003,'vpotts','potts')
SELECT *
  FROM dual;

-- INSERT INTO EMPLOYEE(eid, phone, name, username, password, address, email, sid, role)

-- INSERT INTO MECHANIC(eid, sid, salary)

-- INSERT INTO CONTRACT_EMP(eid, sid, salary);

-- INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,1);
-- INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,2);
-- INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,3);
-- INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,4);
-- INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,5);

-- INSERT INTO MANAGER(eid, sid, salary) VALUES(111111111,1, 90000);
-- INSERT INTO MANAGER(eid, sid, salary) VALUES(111111112,2, 90000);
-- INSERT INTO MANAGER(eid, sid, salary) VALUES(111111113,3, 90000);
-- INSERT INTO MANAGER(eid, sid, salary) VALUES(111111114,4, 90000);
-- INSERT INTO MANAGER(eid, sid, salary) VALUES(111111115,5, 90000);

-- INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Tom', 'Hank', 'inactive', 'good');
-- INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Denzel', 'Washington', 'inactive', 'good');
-- INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Will', 'Smith', 'active', 'bad');
-- INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Brad', 'Pitt', 'active', 'good');
-- INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Angelina', 'Jolie', 'inactive', 'good');

-- INSERT INTO VEHICLE(vin, manf, year, mileage, schedule, cid, sid)

-- INSERT INTO INVOICE(id, total_amount, amount_paid, sid, start_date, timeslot, vin, eid)

-- INSERT INTO TIME_SLOT(date_time, time_slot, timeoff, id, sid, eid)

-- INSERT INTO MAINTENANCE_SCHEDULE(mname, mnumber, sname, snumber)

-- INSERT INTO MECHANIC_TIMESLOT(slot_date, timeslot, eid, sid)

-- INSERT INTO INVOICE_HASSERVICE(id, i_number, name)

-- INSERT INTO INVOICE_HASSCHEDULE(id)


/*
Load general information about existing stores from csv 
- storeid, address, store manager information, stores minimum/maximum hourly wage 
*/

COPY SERVICE_CENTER(
 "sid",
 "address", 
 "telephone",
 "saturday", 
 "manager_id", 
 "receptionist_id", 
 "mechanic_minimum_rate", 
 "mechanic_maximum_rate")
FROM '/data/service_center.csv'
CSV HEADER

CREATE TABLE Employee_Temp (
	eid NUMBER GENERATED BY DEFAULT AS IDENTITY(START with 1 INCREMENT by 1),
	phone NUMBER(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	username VARCHAR(50),
	password VARCHAR(50),
	address VARCHAR(100),
	email VARCHAR(50),
	salary INTEGER, 
	sid NUMBER(10) NOT NULL,
	role VARCHAR(20) NOT NULL, 
	PRIMARY KEY (eid, sid)
); 

COPY Employee_Temp(
 "eid",
 "sid", 
 "first_name",
 "last_name",
 "phone", 
 "address", 
 "email", 
 "salary", 
 "username",
 "password", 
 "role")
FROM '/data/manager.csv'
CSV HEADER

UPDATE Employee
SET 
    (Employee.first_name, Employee.last_name, Employee.phone, Employee.address, Employee.username, Employee.password, Employee.email) = (
        SELECT temp.first_name, temp.last_name, temp.phone, temp.address, temp.username, temp.password, temp.email
        FROM Employee_Temp temp
        WHERE Employee.eid = temp.eid AND Employee.sid = temp.sid)
WHERE Employee.first_name IS NULL AND Employee.last_name IS NULL;

UPDATE MANAGER
SET 
    Manager.salary = (
        SELECT temp.salary
        FROM Employee_Temp temp
        WHERE Manager.eid = temp.eid AND Manager.sid = temp.sid);