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

/*
Adding service centers with managers, customers and vehicles
*/

INSERT ALL
  INTO Service_Center(sid,address,telephone,saturday,manager_id,mechanic_minimum_rate,mechanic_maximum_rate,mechanic_hourly_rate) VALUES(30001,'3921 Western Blvd, Raleigh, NC 27606',3392601234,'o',123456789,30,40,35)
  INTO Service_Center(sid,address,telephone,saturday,manager_id,mechanic_minimum_rate,mechanic_maximum_rate,mechanic_hourly_rate) VALUES(30002,'4500 Preslyn Dr Suite 103, Raleigh, NC 27616',8576890280,'o',987654321,25,35,25)
  INTO Service_Center(sid,address,telephone,saturday,manager_id,mechanic_minimum_rate,mechanic_maximum_rate,mechanic_hourly_rate) VALUES(30003,'9515 Chapel Hill Rd, Morrisville, NC 27560',7798182200,'c',987612345,20,25,22)
SELECT *
  FROM dual;

UPDATE Employee SET first_name='John',last_name='Doe',username='jdoe',password='doe',phone=8636368778,address='1378 University Woods, Raleigh, NC 27612',email='jdoe@gmail.com' WHERE eid=123456789;

UPDATE Manager SET salary=44 where eid=123456789;

UPDATE Employee SET first_name='Rachel',last_name='Brooks',username='rbrooks',password='brooks',phone=8972468552,address='2201 Gorman Parkwood, Raleigh, NC 27618',email='rbrooks@ymail.com' WHERE eid=987654321;

UPDATE Manager SET salary=35 where eid=987654321;

UPDATE Employee SET first_name='Caleb',last_name='Smith',username='csmith',password='smith',phone=8547963210,address='1538 Red Bud Lane, Morrisville, NC 27560',email='csmith@yahoo.com' WHERE eid=987612345;

UPDATE Manager SET salary=25 where eid=987612345;

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

INSERT ALL
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('4Y1BL658','Toyota',53000,'B',2007,10001,30001)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('7A1ST264','Honda',117000,'A',1999,10002,30001)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('5TR3K914','Nissan',111000,'C',2015,10053,30002)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('15DC9A87','Toyota',21000,'A',2020,10010,30002)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('18S5R2D8','Nissan',195500,'C',2019,10001,30002)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('9R2UHP54','Honda',67900,'B',2013,10035,30002)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('88TSM888','Honda',10000,'A',2000,10002,30003)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('71HK2D89','Toyota',195550,'B',2004,10003,30003)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('34KLE19D','Toyota',123800,'C',2010,10011,30003)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('29T56WC3','Nissan',51300,'A',2011,10062,30003)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('P39VN198','Nissan',39500,'B',2013,10501,30003)
  INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('39YVS415','Honda',49900,'A',2021,10010,30003)
SELECT *
  FROM dual;

INSERT ALL 
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('James', 'Williams', 'jwilliams', 'williams', 4576312882, '1400 Gorman St, Raleigh, NC 27606-2972', 'jwilliams@gmail.com', 132457689, 30001, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('David', 'Johnson', 'djohnson', 'johnson', 9892321100, '686 Stratford Court, Raleigh, NC 27606', 'djohnson@ymail.com', 314275869, 30001, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Maria', 'Garcia', 'mgarcia', 'garcia', 4573459090, '1521 Graduate Lane, Raleigh, NC 27606', 'mgarcia@yahoo.com', 241368579, 30001, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Ellie', 'Clark', 'eclark', 'clark', 9892180921, '3125 Avent Ferry Road, Raleigh, NC 27605', 'eclark@gmail.com', 423186759, 30002, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Robert', 'Martinez', 'rmartinez', 'martinez', 7652304282, '1232 Tartan Circle, Raleigh, NC 27607', 'rmartinez@ymail.com', 123789456, 30002, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Charles', 'Rodriguez', 'crodriguez', 'rodriguez', 9092234281, '218 Patton Lane, Raleigh, NC 27603', 'crodriguez@yahoo.com', 789123456, 30002, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Jose', 'Hernandez', 'jhernandez', 'hernandez', 7653241714, '4747 Dola Mine Road, Raleigh, NC 27609', 'jhernandez@gmail.com', 125689347, 30002, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Charlie', 'Brown', 'cbrown', 'brown', 9091237568, '1 Rockford Mountain Lane, Morrisville, NC 27560', 'cbrown@ymail.com', 347812569, 30003, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Jeff', 'Gibson', 'jgibson', 'gibson', 3390108899, '900 Development Drive, Morrisville, NC 27560', 'jgibson@yahoo.com', 123456780, 30003, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Isabelle', 'Wilder', 'iwilder', 'wilder', 3394561231, '6601 Koppers Road, Morrisville, NC 27560', 'iwilder@gmail.com', 123456708, 30003, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Peter', 'Titus', 'ptitus', 'Titus', 3396723418, '2860 Slater Road, Morrisville, NC 27560', 'ptitus@ymail.com', 123456078, 30003, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Mark', 'Mendez', 'mmendez', 'mendez', 3395792080, '140 Southport Drive, Morrisville, NC 27560', 'mmendez@yahoo.com', 123450678, 30003, 'mechanic')
  INTO Employee(first_name, last_name, username, password, phone, address, email, eid, sid, role) VALUES ('Lisa', 'Alberti', 'lalberti', 'alberti', 3391126787, '100 Valley Glen Drive, Morrisville, NC 27560', 'lalberti@yahoo.com', 123405678, 30003, 'mechanic')
SELECT *
  FROM dual;

UPDATE Mechanic SET rate=35 where eid=132457689 AND sid = 30001;

UPDATE Mechanic SET rate=35 where eid=314275869 AND sid = 30001;

UPDATE Mechanic SET rate=35 where eid=241368579 AND sid = 30001;

UPDATE Mechanic SET rate=25 where eid=423186759 AND sid = 30002;

UPDATE Mechanic SET rate=25 where eid=123789456 AND sid = 30002;

UPDATE Mechanic SET rate=25 where eid=789123456 AND sid = 30002;

UPDATE Mechanic SET rate=25 where eid=125689347 AND sid = 30002;

UPDATE Mechanic SET rate=22 where eid=347812569 AND sid = 30003;

UPDATE Mechanic SET rate=22 where eid=123456780 AND sid = 30003;

UPDATE Mechanic SET rate=22 where eid=123456708 AND sid = 30003;

UPDATE Mechanic SET rate=22 where eid=123456078 AND sid = 30003;

UPDATE Mechanic SET rate=22 where eid=123450678 AND sid = 30003;

UPDATE Mechanic SET rate=22 where eid=123405678 AND sid = 30003;

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

/*
READING IN FROM SPREADSHEET - MANUALLY ENTERED ABOVE. CHOOSE 1

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

*/