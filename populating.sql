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

insert into MAINTENANCE(NAME, NUMBER)  
values
('Oil Changes', 113), 
('Filter Replacements', 113), 
('Oil Changes', 114),
('Filter Replacements', 114),
('Brake Repair', 114),
('Check Engine Light Diagnostics', 114),
('Oil Changes', 115),
('Filter Replacements', 115),
('Brake Repair', 115),
('Check Engine Light Diagnostics', 115),
('Suspension Repair', 115),
('Evaporator Repair', 115);

insert into SERVICES(NAME, NUMBER, REPAIR_CAT)  
values
('Belt Replacement', 101, 'Engine Services'),
('Engine Repair', 102, 'Engine Services'),
('Exhaust Repair', 103, 'Exhaust Services'),
('Muffler Repair', 104, 'Exhaust Services'),
('Alternator Repair', 105, 'Electrical Services'),
('Power Lock Repair', 106, 'Electrical Services'),
('Axle Repair', 107, 'Transmission Services'),
('Brake Repair', 108, 'Transmission Services'),
('Tire Balancing', 109, 'Tire Services'),
('Wheel Alignment', 110, 'Tire Services'),
('Compressor Repair', 111, 'Heating and A/C Services'),
('Evaporator Repair', 112, 'Heating and A/C Services');

insert into SCHEDULE(NAME, NUMBER)
values
('A', 113),
('B', 114),
('C', 115);

insert into DURATION_DETAILS(NAME, NUMBER, MANF, DURATION) /* need clarification here */
values
('Belt Replacement', 101, 'Honda', 1),
('Engine Repair', 102, 'Honda', 5),
('Exhaust Repair', 103, 'Honda', 4),
('Muffler Repair', 104, 'Honda', 2),
('Alternator Repair', 105, 'Honda', 4),
('Power Lock Repair', 106, 'Honda', 5),
('Axle Repair', 107, 'Honda', 7),
('Brake Repair', 108, 'Honda', 3),
('Tire Balancing', 109, 'Honda', 2),
('Wheel Alignment', 110, 'Honda', 1),
('Compressor Repair', 111, 'Honda', 3),
('Evaporator Repair', 112, 'Honda', 4),
('A', 113, 'Honda', 3),
('B', 114, 'Honda', 6),
('C', 115, 'Honda', 9),
('Belt Replacement', 101, 'Nissan', 2),
('Engine Repair', 102, 'Nissan', 3),
('Exhaust Repair', 103, 'Nissan',5),
('Muffler Repair', 104, 'Nissan', 3),
('Alternator Repair', 105, 'Nissan', 5),
('Power Lock Repair', 106, 'Nissan', 6),
('Axle Repair', 107, 'Nissan', 8),
('Brake Repair', 108, 'Nissan', 4),
('Tire Balancing', 109, 'Nissan', 3),
('Wheel Alignment', 110, 'Nissan', 1),
('Compressor Repair', 111, 'Nissan', 4),
('Evaporator Repair', 112, 'Nissan', 3),
('A', 113, 'Nissan', 4),
('B', 114, 'Nissan', 7),
('C', 115, 'Nissan', 9),
('Belt Replacement', 101, 'Toyota', 1),
('Engine Repair', 102, 'Toyota', 2),
('Exhaust Repair', 103, 'Toyota',4),
('Muffler Repair', 104, 'Toyota', 1),
('Alternator Repair', 105, 'Toyota', 3),
('Power Lock Repair', 106, 'Toyota', 4),
('Axle Repair', 107, 'Toyota', 5),
('Brake Repair', 108, 'Toyota', 5),
('Tire Balancing', 109, 'Toyota', 2),
('Wheel Alignment', 110, 'Toyota', 3),
('Compressor Repair', 111, 'Toyota', 2),
('Evaporator Repair', 112, 'Toyota', 2),
('A', 113, 'Toyota', 2),
('B', 114, 'Toyota', 5),
('C', 115, 'Toyota', 8);

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