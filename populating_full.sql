--- updating all of service center / manager details 

UPDATE Service_Center 
SET address = '3921 Western Blvd, Raleigh, NC 27606', telephone = 3392601234, saturday = 'o', mechanic_hourly_rate = 35
WHERE sid = 30001;

UPDATE Service_Center 
SET address = '4500 Preslyn Dr Suite 103, Raleigh, NC 27616', telephone = 8576890280, saturday = 'o', mechanic_hourly_rate = 25
WHERE sid = 30002;

UPDATE Service_Center 
SET address = '9515 Chapel Hill Rd, Morrisville, NC 27560', telephone = 7798182200, saturday = 'c', mechanic_hourly_rate = 22
WHERE sid = 30003;

UPDATE Employee 
SET phone = 8636368778, address = '1378 University Woods, Raleigh, NC 27612', email = 'jdoe@gmail.com'
WHERE eid=123456789;

UPDATE Employee 
SET phone = 8972468552, address = '2201 Gorman Parkwood, Raleigh, NC 27618', email = 'rbrooks@ymail.com'
WHERE eid=987654321;

UPDATE Employee
SET phone = 8547963210, address = '1538 Red Bud Lane, Morrisville, NC 27560', email = 'csmith@yahoo.com'
WHERE eid=987612345;

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