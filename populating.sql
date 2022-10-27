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
values('Oil Changes', 113);
values('Filter Replacements', 113);
values('Oil Changes', 114);
values('Filter Replacements', 114);
values('Brake Repair', 114);
values('Check Engine Light Diagnostics', 114);
values('Oil Changes', 115);
values('Filter Replacements', 115);
values('Brake Repair', 115);
values('Check Engine Light Diagnostics', 115);
values('Suspension Repair', 115);
values('Evaporator Repair', 115);

insert into SERVICES(NAME, NUMBER, REPAIR_CAT)  
values('Belt Replacement', 101, 'Engine Services');
values('Engine Repair', 102, 'Engine Services');
values('Exhaust Repair', 103, 'Exhaust Services');
values('Muffler Repair', 104, 'Exhaust Services');
values('Alternator Repair', 105, 'Electrical Services');
values('Power Lock Repair', 106, 'Electrical Services');
values('Axle Repair', 107, 'Transmission Services');
values('Brake Repair', 108, 'Transmission Services');
values('Tire Balancing', 109, 'Tire Services');
values('Wheel Alignment', 110, 'Tire Services');
values('Compressor Repair', 111, 'Heating and A/C Services');
values('Evaporator Repair', 112, 'Heating and A/C Services');

insert into SCHEDULE(NAME, NUMBER)
values('A', 113)
values('B', 114)
values('C', 115)

insert into DURATION_DETAILS(NAME, NUMBER, MANF, DURATION) /* need clarification here */

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
 "salary")
FROM '/data/manager.csv'
CSV HEADER

