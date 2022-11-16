package db;
import java.sql.*;
import java.util.*;
import ui.UI;

/**
 * Queries for mechanics
 */
public class mechanicQuery {


    /**
     * view schedule for mechanic
     */
    public static String[] ViewSchedule(){
        ResultSet rs = null;
        HashMap<String, ArrayList<Integer>> schedule = new HashMap<String, ArrayList<Integer>>();
        String[] result = null;
        try {
            // Insert into the store table
            rs = JDBC.executeQuery(
                "SELECT timeslot_week, timeslot_day, timeSlot "
                + " FROM Calendar"
                + " WHERE eid = " + UI.getCurrentEID()
                + " AND sid = " + UI.getCurrentSID()
                + " AND invoice_id IS NOT NULL"
            );
            while (rs.next()) {
                int week = rs.getInt("timeslot_week");
                int day = rs.getInt("timeslot_day");
                int timeSlot = rs.getInt("timeSlot");
                String weekStr = Integer.toString(week);
                String dayStr = Integer.toString(day);
                String weekDay = weekStr + "_" + dayStr;

                ArrayList<Integer> timeSlots = schedule.get(weekDay);
                if (timeSlots == null) {
                    timeSlots = new ArrayList<>();
                    timeSlots.add(timeSlot);
                    schedule.put(weekDay, timeSlots);
                } else {
                    if (!timeSlots.contains(timeSlot))
                        timeSlots.add(timeSlot);
                }
            }

            int scheduleCount = 1;
            result = new String[schedule.size()];
            SortedSet<String> keys = new TreeSet<>(schedule.keySet());
            for (String key : keys) {
                String weekDay = key;
                ArrayList<Integer> timeSlots = schedule.get(key);
                Integer week = Integer.valueOf(weekDay.split("_")[0]);
                Integer day = Integer.valueOf(weekDay.split("_")[1]);
                Integer minTimeSlot = Collections.min(timeSlots);
                Integer maxTimeSlot = Collections.max(timeSlots);
                String startDate = convertToDate(week, day, minTimeSlot);
                String endDate = convertToEndDate(week, day, maxTimeSlot);
                result[scheduleCount - 1] = scheduleCount + ". " + startDate + " - " + endDate;
                scheduleCount++;
            }
            return result;
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    public static String convertToDate(final int week, final int day, final int timeSlot) {
        final int dd = (week - 1) * 7 + day;
        String time = "";
        switch (timeSlot) {
            case 1:
                time = "8:00";
                break;
            case 2:
                time = "9:00";
                break;
            case 3:
                time = "10:00";
                break;
            case 4:
                time = "11:00";
                break;
            case 5:
                time = "13:00";
                break;
            case 6:
                time = "14:00";
                break;
            case 7:
                time = "15:00";
                break;
            case 8:
                time = "16:00";
                break;
            case 9:
                time = "17:00";
                break;
            case 10:
                time = "18:00";
                break;
            case 11:
                time = "19:00";
                break;
            default:
                break;
        }
        return dd + "th " + time;
    }
    public static String convertToEndDate(final int week, final int day, final int timeSlot) {
        final int dd = (week - 1) * 7 + day;
        String time = "";
        switch (timeSlot) {
            case 1:
                time = "9:00";
                break;
            case 2:
                time = "10:00";
                break;
            case 3:
                time = "11:00";
                break;
            case 4:
                time = "12:00";
                break;
            case 5:
                time = "14:00";
                break;
            case 6:
                time = "15:00";
                break;
            case 7:
                time = "16:00";
                break;
            case 8:
                time = "17:00";
                break;
            case 9:
                time = "18:00";
                break;
            case 10:
                time = "19:00";
                break;
            case 11:
                time = "20:00";
                break;
            default:
                break;
        }
        return dd + "th " + time;
    }
     /*
     * Returns the query to view all work schedules for a given mechanic during
     * their requested time off
     */
    public static String[] RequestedTimeOff(String[] responses) {
        ArrayList<String> list = new ArrayList<String>(); 
        // check to see if the mechanic is scheduled to work during the requested time off
        boolean request = (JDBC.executeUpdate(timeOffRequestsQuery(responses[0], responses[1],
                responses[2])) > 0 );
        if (!request) {
            list.add(
                    "Unable to allow time off since either you are already scheduled for work within that time range or too f\nPlease request another time range instead.");
        }else {
                    list.add(
                            "Request Time Off Approved!!");
            }
        return list.toArray(new String[list.size()]);
    }
    /**
     * Handles functionality for request swap menu of mechanics
     */
    public static String[] RequestedSwap(String[] responses) {
        ArrayList<String> list = new ArrayList<String>(); 
        try {
            // Insert into the store table
            int changed_rows = JDBC.executeUpdate("INSERT INTO Mechanic_Swap_Request (sid, donor_eid, recieve_eid, donor_timeslot_begin_week, donor_timeslot_end_week, donor_timeslot_begin_day, donor_timeslot_end_day, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_begin_week, recieve_timeslot_end_week, recieve_timeslot_begin_day, recieve_timeslot_end_day, recieve_timeslot_begin, recieve_timeslot_end, status) VALUES ("
                + UI.getCurrentSID() + ", "
                + UI.getCurrentEID() + ", "
                + responses[0] + ", "
                + responses[1] + ", "
                + responses[2] + ", "
                + responses[3] + ", "
                + responses[4] + ", "
                + responses[5] + ", "
                + responses[6] + ", "
                + responses[7] + ", "
                + responses[8] + ", "
                + responses[9] + ", "
                + responses[10] + ", "
                + responses[11] + ", "
                + responses[12] + ", "
                + 0 + ")");
            if(changed_rows > 0){
                list.add("Successfully created swap request with employee ID: " + responses[0]);
            }
            else{
                list.add(
                        "Swap request denied.");
            }
        
           {
                throw new java.sql.SQLException("Error requesting timeoff");
            }
        } catch (final SQLException e) {
            // file deepcode ignore DontUsePrintStackTrace: <not needed>
            e.printStackTrace();
        } 
        return list.toArray(new String[list.size()]);
    }
    private static String timeOffRequestsQuery(String responses, String responses2, String responses3) {
        return "INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeslot, sid, eid) VALUES ("
                + responses + ", "
                + responses2 + ", "
                + responses3 + ", "
                + UI.getCurrentSID() + ", "
                + UI.getCurrentEID()+ ")";
    }
     /**
     * Handles functionality for accept and reject swap of mechanics
     */
    public static String[] AcceptRejectSwap(String swapRequestID, int accept) {
        ResultSet rs = null;
        ArrayList<String> list = new ArrayList<String>(); 
        try {
            if(accept == 1){
                rs = JDBC.executeQuery(
                    "SELECT s.id, m.first_name, m.last_name, s.donor_timeslot_begin_week, s.donor_timeslot_end_week, " +
                    "s.donor_timeslot_begin_day, s.donor_timeslot_end_day, s.donor_timeslot_begin, s.donor_timeslot_end, " +
                    "s.recieve_timeslot_begin_week, s.recieve_timeslot_end_week, s.recieve_timeslot_begin_day, s.recieve_timeslot_end_day, " +
                    "s.recieve_timeslot_begin, s.recieve_timeslot_end  " +
                    " FROM Employee m, Mechanic_Swap_Request s " +
                    " WHERE s.id = " + swapRequestID +
                    " AND s.recieve_eid = " + UI.getCurrentEID() +
                    " AND s.donor_eid = m.eid" +
                    " AND status = 0"
                );
                if (rs == null) {
                    list.add("ERROR: Swap Request ID is not Found");
                    return list.toArray(new String[list.size()]);
                }
                String output1 = null;
                String output2 = null;
                String output3 = null;
                String output4 = null;
                String output5 = null;
                String output6 = null;
                String output7 = null;
                String output8 = null;
                String output9 = null;
                String output10 = null;
                String output11 = null;
                String output12 = null;
                String output13 = null;
                String output14 = null;
                while(rs.next()) {
                    output1 = rs.getString("first_name");
                    output2 = rs.getString("last_name");
                    output3 = rs.getString("donor_timeslot_begin_week");
                    output4 = rs.getString("donor_timeslot_end_week");
                    output5 = rs.getString("donor_timeslot_begin_day");
                    output6 = rs.getString("donor_timeslot_end_day");
                    output7 = rs.getString("donor_timeslot_begin");
                    output8 = rs.getString("donor_timeslot_end");
                    output9 = rs.getString("recieve_timeslot_begin_week");
                    output10 = rs.getString("recieve_timeslot_end_week");
                    output11 = rs.getString("recieve_timeslot_begin_day");
                    output12 = rs.getString("recieve_timeslot_end_day");
                    output13 = rs.getString("recieve_timeslot_begin");
                    output14 = rs.getString("recieve_timeslot_end");
                    list.add("INFO: " + output1 + output2 + output3 + output4 + output5 + output6 + output7 + output8 + output9 + output10 + output11 + output12 + output13 + output14 );
                }
                JDBC.executeUpdate(
                    "UPDATE Mechanic_Swap_Request " +
                    " SET status = 1 " +
                    " WHERE id = " + swapRequestID
                );
                    list.add("Accept swap request successfully");
                    return list.toArray(new String[list.size()]);
            }else{
                JDBC.executeUpdate(
                    "UPDATE Mechanic_Swap_Request " +
                    " SET status = 2 " +
                    " WHERE id = " + swapRequestID
                );
                list.add("Reject swap request successfully");
                return list.toArray(new String[list.size()]);
                
            }
        } catch (java.sql.SQLException e) {
            list.add(e.getMessage());
        }
        
        
        return list.toArray(new String[list.size()]);
    }
     /**
     * Handles functionality for manage swap request of mechanics
     */
    public static String[] ManageSwapRequests() {
        ResultSet rs = null;
        ArrayList<String> list = new ArrayList<String>();
        try {
            // manage swap request
            rs = JDBC.executeQuery(
            "SELECT s.id, m.first_name, m.last_name, s.donor_timeslot_begin_week, s.donor_timeslot_end_week, " +
            "s.donor_timeslot_begin_day, s.donor_timeslot_end_day, s.donor_timeslot_begin, s.donor_timeslot_end, " +
            "s.recieve_timeslot_begin_week, s.recieve_timeslot_end_week, s.recieve_timeslot_begin_day, s.recieve_timeslot_end_day, " +
            "s.recieve_timeslot_begin, s.recieve_timeslot_end  " +
            " FROM Employee m, Mechanic_Swap_Request s " +
            " WHERE s.sid = " + UI.getCurrentSID() +
            " AND s.recieve_eid = " + UI.getCurrentEID() +
            " AND s.donor_eid = m.eid " +
            " AND s.status = 0"
            );
            if (rs == null) {
                list.add("ERROR: No Swap Request is Found");
                return list.toArray(new String[list.size()]);
            }
            while(rs.next()) {
                list.add("Swap id = " + rs.getString("id") + " " +
                "first name = " + rs.getString("first_name") + " " +
                "last name = " + rs.getString("last_name") + " " +
                convertToDate(rs.getInt("recieve_timeslot_begin_week"), rs.getInt("recieve_timeslot_begin_day"), rs.getInt("recieve_timeslot_begin")) 
                + " ~ " +
                convertToEndDate(rs.getInt("recieve_timeslot_end_week"), rs.getInt("recieve_timeslot_end_day"),
                rs.getInt("recieve_timeslot_end")) + " -> " +
                convertToDate(rs.getInt("donor_timeslot_begin_week"), rs.getInt("donor_timeslot_begin_day"), rs.getInt("donor_timeslot_begin")) 
                + " ~ " +
                convertToEndDate(rs.getInt("donor_timeslot_end_week"), rs.getInt("donor_timeslot_end_day"),
                rs.getInt("donor_timeslot_end")));
            }
        } catch (java.sql.SQLException e) {
            list.add(e.getMessage());
        }
        return list.toArray(new String[list.size()]);
    }
   
}
