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
 
-- Use Honda if you are looking for the values in the sample data
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
Initializing the system with general information about ALL EXISTING Stores
- includes store ids and address
- managers information for each store  (firstname, lastname, username, password, salary, and employeeid) 
- maximum/minimum hourly rates for mechanics

TODO: Debate if this should be spreadsheet or manually entered.
*/
INSERT ALL
  INTO Service_Center(sid,address,manager_id,mechanic_minimum_rate,mechanic_maximum_rate) VALUES(30001,'3921 Western Blvd, Raleigh, NC 27606',123456789,30,40)
  INTO Service_Center(sid,address,manager_id,mechanic_minimum_rate,mechanic_maximum_rate) VALUES(30002,'4500 Preslyn Dr Suite 103, Raleigh, NC 27616',987654321,25,35)
  INTO Service_Center(sid,address,manager_id,mechanic_minimum_rate,mechanic_maximum_rate) VALUES(30003,'9515 Chapel Hill Rd, Morrisville, NC 27560',987612345,20,25)
SELECT *
  FROM dual;

UPDATE Employee SET first_name='John',last_name='Doe',username='jdoe',password='doe' WHERE eid=123456789;

UPDATE Manager SET salary=44 where eid=123456789;

UPDATE Employee SET first_name='Rachel',last_name='Brooks',username='rbrooks',password='brooks' WHERE eid=987654321;

UPDATE Manager SET salary=35 where eid=987654321;

UPDATE Employee SET first_name='Caleb',last_name='Smith',username='csmith',password='smith' WHERE eid=987612345;

UPDATE Manager SET salary=25 where eid=987612345;

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
