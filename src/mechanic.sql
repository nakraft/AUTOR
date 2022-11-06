*/Mechanic Privileges */


*/1. View Schedule: View Schedule: This will show the list of time slots that mechanic is booked for the service */

SELECT week, day, timeSlot from Schedule where id = mechanicId

*/2. Request TimeOff: This procedure allows a mechanic to request some time off. 
It takes as parameter the time slots they want to be off (indicated by week, day, time slot start and end slot ids). 
It returns with a status of 1, if approved and 0 if not approved. 
It is automatically approved if the mechanic is not already assigned a job during that period and if it will not cause the number of working mechanics to go below the threshold.*/


*/3. Request Swap: one mechanic can request another to swap periods in their schedules.*/

*/4. Accept reject swap menu of mechanics which include the name of the requesting mechanic and timeslot range being requested for swap.