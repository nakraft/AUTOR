package db;

import ui.UI;

/**
 * Queries for mechanics
 */
public class mechanicQuery {
    /**
     * view schedule for mechanic
     */
    public static boolean ViewSchedule(){
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                "SELECT time_slot_week, time_slot_day, timeSlot"
                + " FROM Calendar"
                + " WHERE eid = " + UI.getCurrentEID()
                + " AND sid = " + UI.getCurrentSID()
            ))
            {
                throw new java.sql.SQLException("Error viewing schedule");
            }
        } catch (java.sql.SQLException e) {
            return false;
        }
        // If there aren't any errors
        return true;
    }
     /*
     * Returns the query to view all work schedules for a given mechanic during
     * their requested time off
     */
    public static boolean RequestedTimeOff(String[] responses) {
        try {
            // Insert into the store table
            if(parseAndValidateTimeSlots(responses) == false){
                return false;
            }
            if(!JDBC.executeUpdate(
                "SELECT time_slot_week, time_slot_day, timeSlot"
                + " FROM Calendar"
                + " WHERE sid = " + UI.getCurrentSID()
                + " AND week = " + responses[0]
                + " AND day = " + responses[1]
                + " AND timeSlot >= " + responses[2]
                + " AND timeSlot <= " + responses[3]
            ))
           {
                throw new java.sql.SQLException("Error requesting timeoff");
            }
        } catch (java.sql.SQLException e) {
            return false;
        }
        // If there aren't any errors
        return true;
    }
    /**
     * Handles functionality for request swap menu of mechanics
     */
    public static boolean RequestedSwap(String[] responses) {
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                ""
            ))
           {
                throw new java.sql.SQLException("Error requesting timeoff");
            }
        } catch (java.sql.SQLException e) {
            return false;
        }
        // If there aren't any errors
        return true;
    }
     /**
     * Handles functionality for accept and reject swap of mechanics
     */
    public static boolean AcceptRejectSwap() {
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                ""
            ))
           {
                throw new java.sql.SQLException("Error requesting timeoff");
            }
        } catch (java.sql.SQLException e) {
            return false;
        }
        // If there aren't any errors
        return true;
    }
     /**
     * Handles functionality for manage swap request of mechanics
     */
    public static boolean ManageSwapRequests(String[] responses) {
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                ""
            ))
           {
                throw new java.sql.SQLException("Error requesting timeoff");
            }
        } catch (java.sql.SQLException e) {
            return false;
        }
        // If there aren't any errors
        return true;
    }

    private static boolean parseAndValidateTimeSlots(String[] inputs) {
        int[] timeSlotParameters = new int[4];
        try {
            timeSlotParameters[0] = Integer.parseInt(inputs[0]);
            timeSlotParameters[1] = Integer.parseInt(inputs[1]);
            timeSlotParameters[2] = Integer.parseInt(inputs[2]);
            timeSlotParameters[3] = Integer.parseInt(inputs[3]);
        } catch (NumberFormatException e) {
            System.out.println(
                    "Please make sure you provide all four input time");
            return false;
        }

        return !(timeSlotParameters[0] < 1 || timeSlotParameters[0] > 4 /* valid week */
                || timeSlotParameters[1] < 1 || timeSlotParameters[1] > 7 /* valid day */
                || timeSlotParameters[2] < 1 || timeSlotParameters[2] > 9 /* valid slot tart */
                || timeSlotParameters[3] < 1 || timeSlotParameters[3] > 9 /* valid slot end */
        );
    }
}
