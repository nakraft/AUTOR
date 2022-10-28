/*
Admin/Any User
*/

/*
Background details needed 
*/
insert into MANAGER(EID, NAME, TELEPHONE, ADDRESS, EMAIL, SALARY, USERNAME, PASSWORD) 
values 
(999999999, 'Jessica Simpson', 653725176, '857 Greens St, Wilmington, NC 26571', 'jsimpson@ncsu.edu', 67, 'jsimpson', 'simpson'),
(222222298, 'Cary Wright', 653725175, '12938 Apples St, Raleigh, NC 26571', 'cwright@ncsu.edu', 59, 'cwright', 'wright'),
(232411422, 'Harris Teeter', 652315175, '12938 HT St, Raleigh, NC 26512', 'hteeter@ncsu.edu', 62, 'hteeter', 'teeter');

insert into RECEPTIONIST(EID, NAME, TELEPHONE, ADDRESS, EMAIL, SALARY, USERNAME, PASSWORD) 
values 
(999999988, 'Tommy Simpson', 653725176, '857 Greens St, Wilmington, NC 26571', 'tsimpson@ncsu.edu', 56, 'tsimpson', 'simpson'),
(222222299, 'Sammy Wright', 653725175, '12938 Apples St, Raleigh, NC 26571', 'swright@ncsu.edu', 56, 'swright', 'wright'),
(232411232, 'Lowes Sam', 652315198, '1 Lowes St, Raleigh, NC 26706', 'lowes@gmail.com', 39, 'lsam', 'sam');


/* Add New Store - PASSING TESTS */
/*       should pass - given store id */  
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30004, '52 Huntscroft Ln, Greenville, NC 27619', 387892989, 'Y', 999999999, 999999988, 40, 50, 45);

/*       should pass - NOT given store id */  
insert into SERVICE_CENTER(ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
('52 Huntscroft Ln, Greenville, NC 27619', 387892989, 'Y', 222222298, 222222299, 40, 50, 45);

/*       should pass - receptionist field can be empty */  
insert into SERVICE_CENTER(ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
('52 Huntscroft Ln, Greenville, NC 27619', 387897689, 'N', 222222298, 42, 52, 47);

/* Add New Store - SHOULD FAIL TESTS */
/*       should NOT pass - Saturday field is not valid */  
insert into SERVICE_CENTER(ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
('52 Huntscroft Ln, Greenville, NC 27619', 387892989, 'HJ', 232411422, 232411232, 40, 50, 45);

/*        should NOT pass - due to duplicate service center sid*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30001, '52 Huntscroft Ln, Greenville, NC 27619', 345678287, 'Y', 232411422, 232411232, 40, 50, 45);

/*        should NOT pass - due to duplicate manager id*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30005, '52 Huntscroft Ln, Greenville, NC 27619', 345678287, 'Y', 222222298, 232411232, 40, 50, 45);

/*        should NOT pass - due to duplicate receptionist id*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30005, '52 Huntscroft Ln, Greenville, NC 27619', 345678287, 'Y', 232411422, 222222299, 40, 50, 45);

/*        should NOT pass - receptionist_id is a real employee, but not a receptionist*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30005, '52 Huntscroft Ln, Greenville, NC 27619', 345678287, 'Y', 232411422, 232411422, 40, 50, 45);

/*        should NOT pass - manager_id is a real employee, but not a manager*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30005, '52 Huntscroft Ln, Greenville, NC 27619', 345678287, 'Y', 222222299, 232411422, 40, 50, 45);

/*        should NOT pass - manager_id is a not a real employee*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30004, '52 Huntscroft Ln, Greenville, NC 27619', 387892989, 'Y', 763876473, 999999988, 40, 50, 45);

/*        should NOT pass - receptionist_id is a not a real employee*/ 
insert into SERVICE_CENTER(SID, ADDRESS, TELEPHONE, SATURDAY, 
                    MANAGER_ID, receptionist_id, mechanic_minimum_rate, 
                    mechanic_maximum_rate, hourly_rate)
values
(30004, '52 Huntscroft Ln, Greenville, NC 27619', 387892989, 'Y', 222222298, 763876473, 40, 50, 45);

/* MANUALLY CHECK SOME GENERAL INFORMATION ABOUT THE INFORMATION IN THE DATABASE TO MAKE SURE EVERYTHING WAS ADDED CORRECTLY */
/* There should only be 5 people in the manager table, 2 people in the receptionist table, 6 full stores, and 7 total employees */ 

/* Add New Service - PASSING TESTS */
insert into SERVICES(NAME, NUMBER, REPAIR_CAT)  
values
('Headlight Replacement', 116, 'Electrical Services');

insert into SERVICES(NAME, NUMBER, REPAIR_CAT)  
values
('Spare Tire Check', 117, 'Tire Services');

/* Add New Service - FAILING TESTS */
/*        should NOT pass - repair category is not valid*/ 
insert into SERVICES(NAME, NUMBER, REPAIR_CAT)  
values
('Headlight Replacement', 118, 'Nothingness Services');

/*        should NOT pass - non unique key*/ 
insert into SERVICES(NAME, NUMBER, REPAIR_CAT)  
values
('Headlight Replacement', 116, 'Electrical Services');

/*        should NOT pass - must be assigned a service category*/ 
insert into SERVICES(NAME, NUMBER)  
values
('Headlight Replacement', 118);

/*        should NOT pass - maintence schedules cannot be changed*/ 
insert into MAINTENANCE(NAME, NUMBER)  
values
('Randomness Changes', 113);

/* MANUALLY CHECK SOME GENERAL INFORMATION ABOUT THE INFORMATION IN THE DATABASE TO MAKE SURE EVERYTHING WAS ADDED CORRECTLY */
/* There should only be 26 work events, 3 schedules, 12 maintence services, 14 regular services */ 


