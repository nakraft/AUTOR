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

INSERT INTO SERVICE_CENTER(sid, telephone, address, mechanic_minimum_rate, mechanic_maximum_rate, saturday, manager_id, receptionist_id)

INSERT INTO EMPLOYEE(eid, phone, name, username, password, address, email, sid, role)

INSERT INTO MECHANIC(eid, sid, salary)

INSERT INTO CONTRACT_EMP(eid, sid, salary);

INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,1);
INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,2);
INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,3);
INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,4);
INSERT INTO RECEPTIONIST(eid, sid) VALUES(111111116,5);

INSERT INTO MANAGER(eid, sid, salary) VALUES(111111111,1, 90000);
INSERT INTO MANAGER(eid, sid, salary) VALUES(111111112,2, 90000);
INSERT INTO MANAGER(eid, sid, salary) VALUES(111111113,3, 90000);
INSERT INTO MANAGER(eid, sid, salary) VALUES(111111114,4, 90000);
INSERT INTO MANAGER(eid, sid, salary) VALUES(111111115,5, 90000);

INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Tom', 'Hank', 'inactive', 'good');
INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Denzel', 'Washington', 'inactive', 'good');
INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Will', 'Smith', 'active', 'bad');
INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Brad', 'Pitt', 'active', 'good');
INSERT INTO CUSTOMER(cid, sid,first_name, last_name, status, standing) VALUES(1,1,'Angelina', 'Jolie', 'inactive', 'good');


INSERT INTO VEHICLE(vin, manf, year, mileage, schedule, cid, sid)

INSERT INTO WORK_EVENT(name, event_number)

INSERT ALL
  INTO SERVICES(name, service_number, repair_category) VALUES('Belt Replacement', 101, 'Engine Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Engine Repair', 102, 'Engine Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Exhaust Repair', 103, 'Exhaust Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Exhaust Repair', 104, 'Exhaust Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Alternator Repair', 105, 'Electrical Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Power Lock Repair', 106, 'Electrical Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Axle Repair', 107, 'Transmission Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Brake Repair', 108, 'Transmission Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Tire Balancing', 109, 'Tire Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Wheel Alignment', 110, 'Tire Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Compressor Repair', 111, 'Heating and A/C Services')
  INTO SERVICES(name, service_number, repair_category) VALUES('Evaporator Repair', 112, 'Heating and A/C Services')
SELECT *
  FROM dual;

INSERT ALL
  INTO MAINTENANCE(name, m_number) VALUES('Oil Changes', 113)
  INTO MAINTENANCE(name, m_number) VALUES('Filter Replacements', 113)
  INTO MAINTENANCE(name, m_number) VALUES('Oil Changes', 114)
  INTO MAINTENANCE(name, m_number) VALUES('Filter Replacements', 114)
  INTO MAINTENANCE(name, m_number) VALUES('Brake Repair', 114)
  INTO MAINTENANCE(name, m_number) VALUES('Check Engine Light Diagnostics', 114)
  INTO MAINTENANCE(name, m_number) VALUES('Oil Changes', 115)
  INTO MAINTENANCE(name, m_number) VALUES('Filter Replacements', 115)
  INTO MAINTENANCE(name, m_number) VALUES('Brake Repair', 115)
  INTO MAINTENANCE(name, m_number) VALUES('Check Engine Light Diagnostics', 115)
  INTO MAINTENANCE(name, m_number) VALUES('Suspension Repair', 115)
  INTO MAINTENANCE(name, m_number) VALUES('Evaporator Repair', 115)
SELECT *
  FROM dual;

INSERT ALL
  INTO SCHEDULE(name, s_number) VALUES('A', 113)
  INTO SCHEDULE(name, s_number) VALUES('B', 114)
  INTO SCHEDULE(name, s_number) VALUES('C', 115)
SELECT *
  FROM dual;

INSERT INTO COST_DETAILS(manf, price, sid, id_number, name)

INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Belt Replacement', 101, 'Honda', 1)
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Engine Repair', 102, 'Honda', 5)
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Exhaust Repair', 103, 'Honda', 4)
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Muffler Repair', 104, 'Honda', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Alternator Repair', 105, 'Honda', 4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Power Lock Repair', 106, 'Honda', 5);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Axle Repair', 107, 'Honda', 7);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Brake Repair', 108, 'Honda', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Tire Balancing', 109, 'Honda', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Wheel Alignment', 110, 'Honda', 1);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Compressor Repair', 111, 'Honda', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Evaporator Repair', 112, 'Honda', 4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('A', 113, 'Honda', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('B', 114, 'Honda', 6);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('C', 115, 'Honda', 9);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Belt Replacement', 101, 'Nissan', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Engine Repair', 102, 'Nissan', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Exhaust Repair', 103, 'Nissan',5);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Muffler Repair', 104, 'Nissan', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Alternator Repair', 105, 'Nissan', 5);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Power Lock Repair', 106, 'Nissan', 6);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Axle Repair', 107, 'Nissan', 8);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Brake Repair', 108, 'Nissan', 4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Tire Balancing', 109, 'Nissan', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Wheel Alignment', 110, 'Nissan', 1);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Compressor Repair', 111, 'Nissan', 4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Evaporator Repair', 112, 'Nissan', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('A', 113, 'Nissan', 4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('B', 114, 'Nissan', 7);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('C', 115, 'Nissan', 9);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Belt Replacement', 101, 'Toyota', 1);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Engine Repair', 102, 'Toyota', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Exhaust Repair', 103, 'Toyota',4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Muffler Repair', 104, 'Toyota', 1);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Alternator Repair', 105, 'Toyota', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Power Lock Repair', 106, 'Toyota', 4);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Axle Repair', 107, 'Toyota', 5);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Brake Repair', 108, 'Toyota', 5);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Tire Balancing', 109, 'Toyota', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Wheel Alignment', 110, 'Toyota', 3);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Compressor Repair', 111, 'Toyota', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('Evaporator Repair', 112, 'Toyota', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('A', 113, 'Toyota', 2);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('B', 114, 'Toyota', 5);
INSERT INTO DURATION_DETAILS(name, id_number, manf, duration) VALUES('C', 115, 'Toyota', 8);

INSERT INTO INVOICE(id, total_amount, amount_paid, sid, start_date, timeslot, vin, eid)

INSERT INTO TIME_SLOT(date_time, time_slot, timeoff, id, sid, eid)

INSERT INTO MAINTENANCE_SCHEDULE(mname, mnumber, sname, snumber)

INSERT INTO MECHANIC_TIMESLOT(slot_date, timeslot, eid, sid)

INSERT INTO INVOICE_HASSERVICE(id, i_number, name)

INSERT INTO INVOICE_HASSCHEDULE(id)


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
 "mechanic_maximum_rate", 
 "hourly_rate")
FROM '/data/service_center.csv'
CSV HEADER

COPY MANAGER(
 "eid",
 "name",
 "telephone", 
 "address", 
 "email", 
 "salary", 
 "username",
 "password")
FROM '/data/manager.csv'
CSV HEADER