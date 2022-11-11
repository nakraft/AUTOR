package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.InputMismatchException;
import java.util.Map;
import java.util.Scanner;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.*;
import ui.UI;

/**
 * Queries for mechanics
 */
public class mechanicQuery {
    private static final int MIN_WORKING_MECHANICS = 3;
    private static final char[] INVALID_INPUT_ERROR_MESSAGE = null;
    public static  Integer[] timeSlotParameters;
    private static Integer[] initialTimeSlotParameters;
    private static Integer[] desiredTimeSlotParameters;
    private static Integer employeeIDForSwap;


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
                String endDate = convertToDate(week, day, maxTimeSlot);
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
     /*
     * Returns the query to view all work schedules for a given mechanic during
     * their requested time off
     */
    public static String[] RequestedTimeOff(String[] responses) {
        ArrayList<String> list = new ArrayList<String>(); 
        // check to see if the mechanic is scheduled to work during the requested time off
        boolean request = JDBC.executeUpdate(timeOffRequestsQuery(responses[0], responses[1],
                responses[2]));
        if (!request) {
            list.add(
                    "Unable to allow time off since you are already scheduled for work within that time range.\nPlease request another time range instead.");
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
            boolean request = JDBC.executeUpdate("INSERT INTO Mechanic_Swap_Request (sid, donor_eid, recieve_eid, donor_timeslot_day, donor_timeslot_week, donor_timeslot_begin, donor_timeslot_end, recieve_timeslot_day, recieve_timeslot_week, recieve_timeslot_begin, recieve_timeslot_end, status) VALUES ("
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
            + 0 + ")");
            if(request){
                list.add("Successfully created swap request with employee ID: " + responses[2]);
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
        return "INSERT INTO Mechanic_Out(timeslot_week, timeslot_day, timeSlot, sid, eid) VALUES ("
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
                    "SELECT s.id, m.first_name, m.last_name, s.recieve_timeslot_week, s.recieve_timeslot_day, " +
                    "s.recieve_timeslot_begin, s.recieve_timeslot_end, s.donor_timeslot_week, s.donor_timeslot_day, " +
                    "s.donor_timeslot_begin, s.donor_timeslot_end  " +
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
                String mechanicId1 = null;
                String mechanicId2 = null;
                String week1 = null;
                String week2 = null;
                String day1 = null;
                String day2 = null;
                String timeSlot1 = null;
                String timeSlot2 = null;
                while(rs.next()) {
                    mechanicId1 = rs.getString("first_name");
                    mechanicId2 = rs.getString("last_name");
                    week1 = rs.getString("donor_timeslot_week");
                    week2 = rs.getString("recieve_timeslot_week");
                    day1 = rs.getString("donor_timeslot_day");
                    day2 = rs.getString("recieve_timeslot_day");
                    timeSlot1 = rs.getString("donor_timeslot_begin");
                    timeSlot2 = rs.getString("recieve_timeslot_begin");
                    list.add("INFO: " + mechanicId1 + mechanicId2 + week1 + week2 + day1 + day2 + timeSlot1 + timeSlot2 );
                }
                
                if(JDBC.executeUpdate(
                    "UPDATE Calendar " +
                    " SET timeslot_week = " + week2 +
                    ", timeslot_day = " + day2 +
                    ", timeSlot = " + timeSlot2 +
                    " WHERE eid = " + mechanicId1 +
                    " AND timeslot_week = " + week1 +
                    " AND timeslot_day = " + day1 +
                    " AND timeSlot = " + timeSlot1
                ) & JDBC.executeUpdate(
                    "UPDATE Calendar " +
                    " SET timeslot_week = " + week1 +
                    ", timeslot_day = " + day1 +
                    ", timeSlot = " + timeSlot1 +
                    " WHERE eid = " + mechanicId2 +
                    " AND timeslot_week = " + week2 +
                    " AND timeslot_day = " + day2 +
                    " AND timeSlot = " + timeSlot2
                ) & JDBC.executeUpdate(
                    "UPDATE Mechanic_Swap_Request " +
                    " SET status = 1 " +
                    " WHERE id = " + swapRequestID
                )){
                    list.add("Accept swap request successfully");
                }
                else{
                    list.add("Accept swap request denied");
                }
            }else{
                JDBC.executeUpdate(
                    "UPDATE Mechanic_Swap_Request " +
                    " SET status = 2 " +
                    " WHERE id = " + swapRequestID
                );
                list.add("Reject swap request successfully");
                
            } {
                throw new java.sql.SQLException("Error requesting timeoff");
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
            "SELECT s.id, m.first_name, m.last_name, s.recieve_timeslot_week, s.recieve_timeslot_day, s.recieve_timeslot_begin, s.recieve_timeslot_end, s.donor_timeslot_week, s.donor_timeslot_day, s.donor_timeslot_begin, s.donor_timeslot_end" +
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
                list.add(rs.getString("id") +
                    rs.getString("first_name") +
                    rs.getString("last_name") +
                    rs.getString("recieve_timeslot_week") +
                    rs.getString("recieve_timeslot_day") +
                    rs.getString("recieve_timeslot_begin") +
                    rs.getString("recieve_timeslot_end") +
                    rs.getString("donor_timeslot_week") +
                    rs.getString("donor_timeslot_day") +
                    rs.getString("donor_timeslot_begin") +
                    rs.getString("donor_timeslot_end") );
            }
           {
                throw new java.sql.SQLException("Error manage swap request");
            }
        } catch (java.sql.SQLException e) {
            list.add(e.getMessage());
        }
        return list.toArray(new String[list.size()]);
    }
   
}
