package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.InputMismatchException;
import java.util.Scanner;

import ui.UI;

/**
 * Queries for mechanics
 */
public class mechanicQuery {
    private static final int MIN_WORKING_MECHANICS = 3;
    private static Integer[] timeSlotParameters;
    private static Integer[] initialTimeSlotParameters;
    private static Integer[] desiredTimeSlotParameters;
    private static Integer employeeIDForSwap;
    private static final String INVALID_INPUT_MESSAGE = "\nInvalid input. Please try again.\n";


    /**
     * view schedule for mechanic
     */
    public static boolean ViewSchedule(){
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                "SELECT timeslot_week, timeslot_day, timeSlot"
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
        ResultSet rs = null;
        try {

            // check to see if the mechanic is scheduled to work during the requested time
            // off
            // file deepcode ignore NoStringConcat: <not needed>
            rs = JDBC.executeQuery(viewTimeOffRequestsQuery(timeSlotParameters[0], timeSlotParameters[1],
                    timeSlotParameters[2], timeSlotParameters[3]));
            if (rs.next()) {
                System.out.println(
                        "0\nUnable to allow time off since you are already scheduled for work within that time range.\nPlease request another time range instead.");
            }

            // check to see if there are enough mechanics to cover the time off request
            rs = JDBC.executeQuery(
                    viewWorkingMechanicsQuery(timeSlotParameters[0], timeSlotParameters[1],
                            timeSlotParameters[2], timeSlotParameters[3]));

            while (rs.next()) {
                int count = rs.getInt("numMechanics");
                if (count < MIN_WORKING_MECHANICS) {
                    System.out.println(
                            "0\nUnable to allow time off since there are not enough mechanics to cover the time off request.\nPlease request another time range instead.");
                }
            }
        } catch (final SQLException e) {
            // file deepcode ignore DontUsePrintStackTrace: <not needed>
            e.printStackTrace();
        }
        return true;
    }
    /**
     * Handles functionality for request swap menu of mechanics
     */
    public static boolean RequestedSwap(String[] responses) {
        ResultSet rs = null;
        if(!parseAndValidateTimeSlots(responses)){
            return false;
        }
        try {
            // Insert into the store table
            JDBC.executeUpdate(insertSwapRequestStatement());
            System.out.println("Successfully created swap request with employee ID: "
            + employeeIDForSwap);
            rs = JDBC.executeQuery(
                viewTimeOffRequestsQuery(timeSlotParameters[0], timeSlotParameters[1], timeSlotParameters[2], timeSlotParameters[3])
            );
            if (!rs.next()) {
                System.out.println(
                        "\nTime slot range is invalid. Try again with a valid time slot range.\n");
                return false;
            }
            rs = JDBC.executeQuery(viewWorkingMechanicsQuery(timeSlotParameters[0], timeSlotParameters[1], timeSlotParameters[2], timeSlotParameters[3]));

            while (rs.next()) {
                int count = rs.getInt("numMechanics");
                if (count < MIN_WORKING_MECHANICS) {
                    System.out.println(
                            "0\nUnable to allow time off since there are not enough mechanics to cover the time off request.\nPlease request another time range instead.");
                }
        }
           {
                throw new java.sql.SQLException("Error requesting timeoff");
            }
        } catch (final SQLException e) {
            // file deepcode ignore DontUsePrintStackTrace: <not needed>
            e.printStackTrace();
        } 
        return true;
    }
    private static String viewTimeOffRequestsQuery(Integer week, Integer day, Integer timeSlotStart,
            Integer timeSlotEnd) {
        return "SELECT week, day, timeSlot"
                + " FROM Calendar"
                + " WHERE id = " + UI.getCurrentEID()
                + " WHERE sid = " + UI.getCurrentSID()
                + " AND timeslot_week = " + week
                + " AND timeslot_day = " + day
                + " AND timeSlot >= " + timeSlotStart
                + " AND timeSlot <= " + timeSlotEnd;
    }

    private static String viewWorkingMechanicsQuery(Integer week, Integer day, Integer timeSlotStart,
    Integer timeSlotEnd) {
    return "SELECT COUNT(*) AS numofMechanics"
            + " FROM Calendar"
            + " WHERE id = " + UI.getCurrentEID()
            + " WHERE sid = " + UI.getCurrentSID()
            + " AND timeslot_week = " + week
            + " AND timeslot_day = " + day
            + " AND timeSlot >= " + timeSlotStart
            + " AND timeSlot <= " + timeSlotEnd;
    }
     /**
     * Handles functionality for accept and reject swap of mechanics
     */
    public static boolean AcceptRejectSwap() {
        try {
            // accept and reject swap
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
            // manage swap request
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
    private static String insertSwapRequestStatement() {
        return "INSERT INTO SwapRequests (requestId, centerId, mechanicId, mechanicIdForSwap, initialWeek, initialDay, initialStartTimeSlot, initialEndTimeSlot, desiredWeek, desiredDay, desiredStartTimeSlot, desiredEndTimeSlot, status) VALUES ("
                + "auto_increment_swap_request_id.nextval, "
                + UI.getCurrentSID() + ", "
                + UI.getCurrentEID() + ", "
                + employeeIDForSwap + ", "
                + initialTimeSlotParameters[0] + ", "
                + initialTimeSlotParameters[1] + ", "
                + initialTimeSlotParameters[2] + ", "
                + initialTimeSlotParameters[3] + ", "
                + desiredTimeSlotParameters[0] + ", "
                + desiredTimeSlotParameters[1] + ", "
                + desiredTimeSlotParameters[2] + ", "
                + desiredTimeSlotParameters[3] + ", "
                + 0 + ")";
    }
    public enum SwapRequestState {
        PENDING, ACCEPTED, REJECTED;
    }

    private static boolean parseAndValidateTimeSlots(String[] inputs) {
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
