/* 
Admin functionality
- Add New Store
- Add New Service
*/

/*
Input parameters 
- Add New Store - SID, ADDRESS, MIN_RATE, MIN_RATE,
NAME, USERNAME, PASSWORD,
SALARY
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
"name",
"username",
"password",
"eid",
"role",
"sid") VALUES (
    NAME
    USERNAME,
    PASSWORD,
    EID,
    'M',
    SID
);

/* Triggers upon insertion to employee (if role = 'm') */

CREATE TRIGGER ADD_MANAGER
AFTER INSERT ON EMPLOYEES
WHEN role = 'm'
BEGIN
insert into MANAGER (
"eid",
"salary") VALUES (
    EID,
    SALARY
)
update SERVICE_CENTER
set manager_id = EID
where sid = SID
END;


/* Triggers end here */

/*
Input parameters 
- Add New Service - SERVICE_CAT, NAME, DURATION, NUMBER(?), MANF(?)
*/

/* Service  here is service category and schedule number */
insert into SERVICES (
"name",
"number",
"repair_cat") VALUES (
    NAME,
    NUMBER,
    SERVICE_CAT
);

/* Triggers upon insertion to services */

insert into DURATION_DETAILS (
"manf",
"duration",
"name",
"number") VALUES (
    MANF,
    DURATION,
    NAME,
    NUMBER
);
