package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.InputMismatchException;
import java.util.Map;
import java.util.Scanner;

import ui.UI;

/**
 * Queries for mechanics
 */
public class mechanicQuery {
    private static final int MIN_WORKING_MECHANICS = 3;
    private static final char[] INVALID_INPUT_ERROR_MESSAGE = null;
    private static Integer[] timeSlotParameters;
    private static Integer[] initialTimeSlotParameters;
    private static Integer[] desiredTimeSlotParameters;
    private static Integer employeeIDForSwap;


    /**
     * view schedule for mechanic
     */
    public static String[][] ViewSchedule(){
        ResultSet rs = null;
        HashMap<String, ArrayList<Integer>> schedule = new HashMap<String, ArrayList<Integer>>();
        String[][] result = null;
        try {
            // Insert into the store table
            rs = JDBC.executeQuery(
                "SELECT timeslot_week, timeslot_day, timeSlot"
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
            result = new String[schedule.size()][1];
            for (Map.Entry<String, ArrayList<Integer>> scheduleEntry : schedule.entrySet()) {
                String weekDay = scheduleEntry.getKey();
                ArrayList<Integer> timeSlots = scheduleEntry.getValue();
                Integer week = Integer.valueOf(weekDay.split("_")[0]);
                Integer day = Integer.valueOf(weekDay.split("_")[1]);
                Integer minTimeSlot = Collections.min(timeSlots);
                Integer maxTimeSlot = Collections.max(timeSlots);
                String startDate = convertToDate(week, day, minTimeSlot);
                String endDate = convertToDate(week, day, maxTimeSlot);
                result[scheduleCount - 1][0] = scheduleCount + ". " + startDate + " - " + endDate;
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
            }else {
                // check to see if there are enough mechanics to cover the time off request
                ResultSet rs2 = JDBC.executeQuery(
                        viewWorkingMechanicsQuery(timeSlotParameters[0], timeSlotParameters[1],
                        timeSlotParameters[2], timeSlotParameters[3]));
                
                while (rs2.next()) {
                    int count = 0;
                    try {
                        count = rs.getInt("numMechanics");
                    }catch(Exception e) {
                        e.printStackTrace();
                    }
                    if (count < MIN_WORKING_MECHANICS) {
                        System.out.println(
                                "0\nUnable to allow time off since there are not enough mechanics to cover the time off request.\nPlease request another time range instead.");
                    }
                }}
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
    public static boolean parseAndValidateInputs() {
        Scanner scanner = new Scanner(System.in);

        boolean validInitialTimeSlots = parseAndValidateInitialTimeSlots(scanner);
        if (!validInitialTimeSlots) {
            return false;
        }

        return parseAndValidateDesiredTimeSlots(scanner); // all inputs are valid
    }
    private static boolean parseAndValidateInitialTimeSlots(Scanner scanner) {
        try {
            System.out.println("Timeslot range to swap:");

            System.out.print("Timeslot week (1-4): ");
            initialTimeSlotParameters[0] = scanner.nextInt();
            if (initialTimeSlotParameters[0] < 1 || initialTimeSlotParameters[0] > 4) {
                System.out.println("\nInvalid week number. Please enter a number between 1 and 4.\n");
                scanner.close();
                return false;
            }

            System.out.print("Timeslot day (1-7): ");
            initialTimeSlotParameters[1] = scanner.nextInt();
            if (initialTimeSlotParameters[1] < 1 || initialTimeSlotParameters[1] > 7) {
                System.out.println("\nInvalid day number. Please enter a number between 1 and 7.\n");
                scanner.close();
                return false;
            }

            System.out.print("Timeslot start (1-9): ");
            initialTimeSlotParameters[2] = scanner.nextInt();
            if (initialTimeSlotParameters[2] < 1 || initialTimeSlotParameters[2] > 9) {
                System.out.println("\nInvalid start time slot. Please enter a number between 1 and 9.\n");
                scanner.close();
                return false;
            }

            System.out.print("Timeslot end (1-9): ");
            initialTimeSlotParameters[3] = scanner.nextInt();
            if (initialTimeSlotParameters[3] < 1 || initialTimeSlotParameters[3] > 9) {
                System.out.println("\nInvalid end time slot. Please enter a number between 1 and 9.\n");
                scanner.close();
                return false;
            }
        } catch (InputMismatchException e) {
            System.out.println(INVALID_INPUT_ERROR_MESSAGE);
            scanner.close();
            return false;
        }

        // validate the start time slot is less than the end time slot
        if (!validateTimeSlotRange(initialTimeSlotParameters[2], initialTimeSlotParameters[3])) {
            return false;
        }

        // validate the mechanic is working within the given time slot range
        return validateRequestingMechanicWorkingWithinTimeSlotRange(initialTimeSlotParameters[0],
                initialTimeSlotParameters[1],
                initialTimeSlotParameters[2], initialTimeSlotParameters[3]); // all inputs are valid
    }
    private static boolean validateTimeSlotRange(int start, int end) {
        if (start > end) {
            System.out.println(
                    "\nInvalid time slot range. Please enter a start time slot that is less than or equal to the end time slot.\n");
            return false;
        }

        return true;
    }
    private static boolean validateRequestingMechanicWorkingWithinTimeSlotRange(Integer week, Integer day,
            Integer startTimeSlot, Integer endTimeSlot) {
            ResultSet rs = null;
        try {
            // Query the database for the mechanic's time slots
            // deepcode ignore NoStringConcat: <not needed>
            rs = JDBC.executeQuery(validRequestingMechanicWorkingQuery(week, day, startTimeSlot, endTimeSlot));

            // If the result set is empty, the mechanic is not working within the given time
            // slot range
            if (!rs.next()) {
                System.out.println(
                        "\nYou are not working within the specified initial time slot range. Try again with a time slot range in which you are working.\n");
                return false;
            }
        } catch (final SQLException e) {
            // file deepcode ignore DontUsePrintStackTrace: <not needed>
            e.printStackTrace();
        } 
        return true;
    }
    private static String validRequestingMechanicWorkingQuery(Integer week, Integer day, Integer timeSlotStart,
    Integer timeSlotEnd) {
    return "SELECT COUNT(*) AS numOfMechanics"
            + " FROM Calendar"
            + " WHERE eid = " + UI.getCurrentEID()
            + " WHERE sid = " + UI.getCurrentSID()
            + " AND timeslot_week = " + week
            + " AND timeslot_day = " + day
            + " AND timeSlot >= " + timeSlotStart
            + " AND timeSlot <= " + timeSlotEnd;
    }
    private static boolean parseAndValidateDesiredTimeSlots(Scanner scanner) {
        try {
            System.out.println("\nDesired timeslot range to swap with:");

            System.out.print("Timeslot week (1-4): ");
            desiredTimeSlotParameters[0] = scanner.nextInt();
            if (desiredTimeSlotParameters[0] < 1 || desiredTimeSlotParameters[0] > 4) {
                System.out.println("\nInvalid week number. Please enter a number between 1 and 4.\n");
                scanner.close();
                return false;
            }

            System.out.print("Timeslot day (1-7): ");
            desiredTimeSlotParameters[1] = scanner.nextInt();
            if (desiredTimeSlotParameters[1] < 1 || desiredTimeSlotParameters[1] > 7) {
                System.out.println("\nInvalid day number. Please enter a number between 1 and 7.\n");
                scanner.close();
                return false;
            }

            System.out.print("Timeslot start (1-9): ");
            desiredTimeSlotParameters[2] = scanner.nextInt();
            if (desiredTimeSlotParameters[2] < 1 || desiredTimeSlotParameters[2] > 9) {
                System.out.println("\nInvalid start time slot. Please enter a number between 1 and 9.\n");
                scanner.close();
                return false;
            }

            System.out.print("Timeslot end (1-9): ");
            desiredTimeSlotParameters[3] = scanner.nextInt();
            if (desiredTimeSlotParameters[3] < 1 || desiredTimeSlotParameters[3] > 9) {
                System.out.println("\nInvalid end time slot. Please enter a number between 1 and 9.\n");
                scanner.close();
                return false;
            }
        } catch (InputMismatchException e) {
            System.out.println(INVALID_INPUT_ERROR_MESSAGE);
            scanner.close();
            return false;
        }

        // validate the start time slot is less than the end time slot
        if (!validateTimeSlotRange(desiredTimeSlotParameters[2], desiredTimeSlotParameters[3])) {
            return false;
        }
        return true;
    }
}
