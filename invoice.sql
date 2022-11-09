--- first, get the duration of the services selected

SELECT SUM(dd.dur) 
FROM duration_details dd
WHERE dd.manf = 'Honda' AND ((dd.serviceNumber = 101 AND dd.serviceName = 'Belt Replacement') OR (dd.serviceNumber = 110 AND dd.serviceName = 'Wheel Alignment'));

        SELECT SUM(d.dur) INTO length_services  
        FROM Invoice_HasService i 
        LEFT JOIN Duration_Details d 
        ON i.serviceName = d.serviceName AND i.serviceNumber = d.serviceNumber 
        WHERE d.manf = (SELECT manf FROM Vehicle WHERE vin = :new.vin) AND i.id = :new.id;
        
--- first, find a list of available timeslots for the customer's sid 

SELECT c.timeslot_week, c.timeslot_day, c.timeslot, c.eid, c.id
FROM Calendar c
WHERE c.sid = 30003 AND  -- this is the customers service center id
        EXISTS (SELECT * FROM Calendar c2 WHERE c2.sid = 30003 AND c2.eid = c.eid AND c2.id = c.id + 1)
        AND dd.dur + (SELECT COUNT(c3.eid) FROM Calendar c3 WHERE c3.sid = 30003 AND c3.eid = c.eid AND c3.timeslot_week = c1.timeslot_week) <= 50 -- dd.dur is from above, this checks to make sure mechanics who are about to go over time if they picked this up are not displayed. 
ORDER BY c.timeslot_week, c.timeslot_day, c.timeslot, c.eid; -- if more than 1 hour was scheduled, we would have to jump ahead and do 2 EXISTS statements with c3.id = c.id + 2, etc

--- choose one of the timeslots
--- take the needed information and generate the invoice 

    --- get the next service ID and add 1
    SELECT MAX(id)
    FROM Invoice; 
    
    --- make this the total price
    SELECT SUM(price)
    FROM Cost_Details
    WHERE manf = 'Honda' AND sid = 30003 AND ((serviceNumber = 101 AND serviceName = 'Belt Replacement') OR (serviceNumber = 110 AND serviceName = 'Wheel Alignment')); 


INSERT ALL 
    INTO Invoice(id, sid, eid, timeslot_id_start, timeslot_id_end, vin, total_amount)  VALUES (1, 30003, 347812569, 4, 4 + 2 - 1, '39YVS415', 65)
    INTO Invoice_HasService ( id, name, number ) VALUES ( 1, 'Belt Replacement', 101)
    INTO Invoice_HasService ( id, name, number) VALUES ( 1, 'WHeel Alignment', 110 )
SELECT * FROM dual;


----- UPDATED QUERIES 

-- to pay for an invoice 
UPDATE Invoice SET amount_paid = 200 WHERE id = 1; -- status will automatically be updated 