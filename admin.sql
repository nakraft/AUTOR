/* 
Admin functionality
- Add New Store
- Add New Service
*/

/*
Input parameters 
- Add New Store - SID, ADDRESS, MIN_RATE, MIN_RATE,
FIRSTNAME, LASTNAME, USERNAME, PASSWORD,
SALARY
- Add New Service - SERVICE_CAT, NAME, DURATION
*/


insert into SERVICE_CENTRE (
"sid",
"address", 
"mechanic_minimum_rate", 
"mechanic_maximum_rate") VALUES (
    SID,
    ADDRESS,
    MIN_RATE,
    MAX_RATE
);

insert into EMPLOYEE (
"first_name",
"last_name",
"username",
"password",
"eid",
"role",
"sid") VALUES (
    FIRSTNAME,
    LASTNAME,
    USERNAME,
    PASSWORD,
    EID,
    'M',
    SID
);

/* Triggers upon insertion to employee (if role = 'm') */

insert into MECHANIC (
"eid",
"salary") VALUES (
    EID,
    SALARY
);

update SERVICE_CENTER
set manager_id = EID
where sid = SID;

/* Triggers end here */
