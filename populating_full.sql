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

-- adding in cost details 

INSERT ALL 
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Tire Balancing', 109, 'Honda', 50)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Tire Balancing', 109, 'Nissan', 60)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Tire Balancing', 109, 'Toyota', 70)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Belt Replacement', 101, 'Honda', 140)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Belt Replacement', 101, 'Nissan', 175)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Belt Replacement', 101, 'Toyota', 160)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Muffler Repair', 104, 'Honda', 140)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Muffler Repair', 104, 'Nissan', 175)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Muffler Repair', 104, 'Toyota', 160)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Wheel Alignment', 110, 'Honda', 140)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Wheel Alignment', 110, 'Nissan', 175)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Wheel Alignment', 110, 'Toyota', 160)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Engine Repair', 102, 'Honda', 400)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Engine Repair', 102, 'Nissan', 500)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Engine Repair', 102, 'Toyota', 450)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Alternator Repair', 105, 'Honda', 400)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Alternator Repair', 105, 'Nissan', 500)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Alternator Repair', 105, 'Toyota', 450)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Power Lock Repair', 106, 'Honda', 400)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Power Lock Repair', 106, 'Nissan', 500)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Power Lock Repair', 106, 'Toyota', 450)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Brake Repair', 108, 'Honda', 400)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Brake Repair', 108, 'Nissan', 500)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Brake Repair', 108, 'Toyota', 450)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Evaporator Repair', 112, 'Honda', 400)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Evaporator Repair', 112, 'Nissan', 500)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Evaporator Repair', 112, 'Toyota', 450)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Exhaust Repair', 103, 'Honda', 590)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Exhaust Repair', 103, 'Nissan', 700)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Exhaust Repair', 103, 'Toyota', 680)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Compressor Repair', 111, 'Honda', 590)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Compressor Repair', 111, 'Nissan', 700)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Compressor Repair', 111, 'Toyota', 680)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Axle Repair', 107, 'Honda', 1000)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Axle Repair', 107, 'Nissan', 1200)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'Axle Repair', 107, 'Toyota', 1100)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'A', 113, 'Honda', 120)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'A', 113, 'Nissan', 190)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'A', 113, 'Toyota', 200)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'B', 114, 'Honda', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'B', 114, 'Nissan', 210)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'B', 114, 'Toyota', 215)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'C', 115, 'Honda', 300)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'C', 115, 'Nissan', 310)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30001, 'C', 115, 'Toyota', 305)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Tire Balancing', 109, 'Honda', 70)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Tire Balancing', 109, 'Nissan', 90)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Tire Balancing', 109, 'Toyota', 80)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Belt Replacement', 101, 'Honda', 160)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Belt Replacement', 101, 'Nissan', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Belt Replacement', 101, 'Toyota', 180)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Muffler Repair', 104, 'Honda', 160)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Muffler Repair', 104, 'Nissan', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Muffler Repair', 104, 'Toyota', 180)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Wheel Alignment', 110, 'Honda', 160)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Wheel Alignment', 110, 'Nissan', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Wheel Alignment', 110, 'Toyota', 180)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Engine Repair', 102, 'Honda', 420)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Engine Repair', 102, 'Nissan', 520)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Engine Repair', 102, 'Toyota', 470)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Alternator Repair', 105, 'Honda', 420)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Alternator Repair', 105, 'Nissan', 520)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Alternator Repair', 105, 'Toyota', 470)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Power Lock Repair', 106, 'Honda', 420)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Power Lock Repair', 106, 'Nissan', 520)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Power Lock Repair', 106, 'Toyota', 470)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Brake Repair', 108, 'Honda', 420)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Brake Repair', 108, 'Nissan', 520)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Brake Repair', 108, 'Toyota', 470)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Evaporator Repair', 112, 'Honda', 420)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Evaporator Repair', 112, 'Nissan', 520)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Evaporator Repair', 112, 'Toyota', 470)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Exhaust Repair', 103, 'Honda', 610)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Exhaust Repair', 103, 'Nissan', 720)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Exhaust Repair', 103, 'Toyota', 700)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Compressor Repair', 111, 'Honda', 610)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Compressor Repair', 111, 'Nissan', 720)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Compressor Repair', 111, 'Toyota', 700)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Axle Repair', 107, 'Honda', 1020)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Axle Repair', 107, 'Nissan', 1220)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'Axle Repair', 107, 'Toyota', 1120)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'A', 113, 'Honda', 125)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'A', 113, 'Nissan', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'A', 113, 'Toyota', 205)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'B', 114, 'Honda', 200)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'B', 114, 'Nissan', 215)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'B', 114, 'Toyota', 220)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'C', 115, 'Honda', 305)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'C', 115, 'Nissan', 315)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30002, 'C', 115, 'Toyota', 310)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Tire Balancing', 109, 'Honda', 85)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Tire Balancing', 109, 'Nissan', 105)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Tire Balancing', 109, 'Toyota', 95)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Belt Replacement', 101, 'Honda', 175)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Belt Replacement', 101, 'Nissan', 210)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Belt Replacement', 101, 'Toyota', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Muffler Repair', 104, 'Honda', 175)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Muffler Repair', 104, 'Nissan', 210)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Muffler Repair', 104, 'Toyota', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Wheel Alignment', 110, 'Honda', 175)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Wheel Alignment', 110, 'Nissan', 210)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Wheel Alignment', 110, 'Toyota', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Engine Repair', 102, 'Honda', 435)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Engine Repair', 102, 'Nissan', 535)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Engine Repair', 102, 'Toyota', 485)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Alternator Repair', 105, 'Honda', 435)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Alternator Repair', 105, 'Nissan', 535)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Alternator Repair', 105, 'Toyota', 485)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Power Lock Repair', 106, 'Honda', 435)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Power Lock Repair', 106, 'Nissan', 535)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Power Lock Repair', 106, 'Toyota', 485)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Brake Repair', 108, 'Honda', 435)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Brake Repair', 108, 'Nissan', 535)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Brake Repair', 108, 'Toyota', 485)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Evaporator Repair', 112, 'Honda', 435)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Evaporator Repair', 112, 'Nissan', 535)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Evaporator Repair', 112, 'Toyota', 485)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Exhaust Repair', 103, 'Honda', 625)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Exhaust Repair', 103, 'Nissan', 735)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Exhaust Repair', 103, 'Toyota', 715)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Compressor Repair', 111, 'Honda', 625)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Compressor Repair', 111, 'Nissan', 735)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Compressor Repair', 111, 'Toyota', 715)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Axle Repair', 107, 'Honda', 1035)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Axle Repair', 107, 'Nissan', 1235)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'Axle Repair', 107, 'Toyota', 1135)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'A', 113, 'Honda', 140)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'A', 113, 'Nissan', 180)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'A', 113, 'Toyota', 195)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'B', 114, 'Honda', 210)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'B', 114, 'Nissan', 220)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'B', 114, 'Toyota', 215)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'C', 115, 'Honda', 310)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'C', 115, 'Nissan', 305)
    INTO Cost_Details(sid, serviceName, serviceNumber, manf, price) VALUES(30003, 'C', 115, 'Toyota', 310)
SELECT *
  FROM dual;

-- customer base

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

-- employee base 

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

-- generating service requests 

INSERT ALL 
  INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 1, 'Wheel Alignment', 110)
  INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 2, 'Belt Replacement', 101)
  INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 3, 'Tire Balancing', 109)
  INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 4, 'Alternator Repair', 105)
  INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 5, 'Compressor Repair', 111)
  -- INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 6, 'B', 114)
  INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( 7, 'A', 113)
SELECT * 
  FROM dual;

INSERT ALL 
  INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (1, 30003, 123405678, 10501, 1, 2, 1, 1, 2, 1, 'P39VN198')
  INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (2, 30003, 123450678, 10010, 1, 2, 1, 1, 2, 1, '39YVS415')
  INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (3, 30003, 123456780, 10062, 1, 1, 1, 1, 1, 2, '29T56WC3', 1)
  INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (4, 30002, 423186759, 10035, 2, 4, 2, 2, 4, 5, '9R2UHP54', 1)
  INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (5, 30002, 125689347, 10053, 2, 1, 3, 2, 1, 5, '5TR3K914', 1)
  -- -- INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (6, 30002, 789123456, 10010, 2, 6, 2, 2, 6, 7, '15DC9A87', 1) THIS IS AN INVALID SERVICE 
  INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin, status)  VALUES (7, 30002, 125689347, 10001, 3, 5, 5, 3, 5, 7, '18S5R2D8', 1)
SELECT * 
  FROM dual;

/* 
Utilized in testing for mechanic swap, uncomment and pick up at the *** RUN AFTER POPULATING FULL *** Maker in the mechanic swap file
*/
-- INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10021,'Peter','Parker',30002,'pparker1','parker');

-- INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10022,'Diana','Prince',30002,'dprince1','prince');

-- INSERT INTO Customer(cid,first_name,last_name,sid,username,password) VALUES(10023,'Billy','Batson',30002,'bbatson1','batson');

-- INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('AAAAAAAA','Toyota',53000,'C',2007,10021,30002);

-- INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('CCCCCCCC','Nissan',111000,'C',2015,10022, 30002);

-- INSERT INTO Vehicle(vin,manf,mileage,schedule,year,cid,sid) VALUES('EEEEEEEE','Honda',117000,'C',1999,10023,30002);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'C', 115);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'Power Lock Repair', 106);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (10, 'Muffler Repair', 104);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (10, 30002, 125689347, 10021, 3, 1, 1, 3, 2, 5, 'AAAAAAAA');

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'C', 115);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'Power Lock Repair', 106);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (11, 'Muffler Repair', 104);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (11, 30002, 125689347, 10022, 3, 2, 6, 3, 3, 10, 'CCCCCCCC');

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'C', 115);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'Belt Replacement', 101);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (12, 'Muffler Repair', 104);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (12, 30002, 125689347, 10023, 3, 3, 11, 3, 4, 11, 'EEEEEEEE');

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'C', 115); 

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'Power Lock Repair', 106);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (13, 'Muffler Repair', 104);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (13, 30002, 125689347, 10021, 4, 1, 3, 4, 2, 7, 'AAAAAAAA');

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'C', 115);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'Power Lock Repair', 106);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (14, 'Muffler Repair', 104);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (14, 30002, 125689347, 10022, 4, 2, 8, 4, 4, 1, 'CCCCCCCC');

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'C', 115);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'Power Lock Repair', 106);

-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (15, 'Muffler Repair', 104);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (15, 30002, 125689347, 10023, 4, 4, 2, 4, 5, 6, 'EEEEEEEE');
       
-- INSERT INTO Invoice_HasService( id, serviceName, serviceNumber) VALUES (17, 'Power Lock Repair', 106);

-- INSERT INTO Invoice(id, sid, eid, cid, start_timeslot_week, start_timeslot_day, start_timeslot, end_timeslot_week, end_timeslot_day, end_timeslot, vin)  VALUES (17, 30002, 423186759, 10023, 3, 5, 11, 4, 1, 1, 'EEEEEEEE');