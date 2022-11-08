package db;

import ui.UI;
import java.sql.*;

// Import array list
import java.util.ArrayList;

/**
 * Queries for customers
 */
public class customerQuery {
    
    /**
     * Retrieve customer profile using eid and sid from UI
     * 
     * @return String[] of customer profile
     */
    public static String[] getProfile() {
        // Create a query
        String query = "SELECT * FROM Customer WHERE cid = '" + UI.getCurrentEID() + "' AND sid = '" + UI.getCurrentSID() + "'";
        // Run the query
        try {
            ResultSet result = JDBC.executeQuery(query);
            // If there is a result, return it as an array
            if (result.next()) {
                // Create an array to hold the result
                String[] profile = new String[5];
                // Add the result to the array
                // Customer ID
                profile[0] = result.getString("cid");
                // Full Name
                profile[1] = result.getString("first_name") + " " + result.getString("last_name");
                // Address
                profile[2] = result.getString("address");
                // Email address
                profile[3] = result.getString("email");
                // Phone number
                profile[4] = result.getString("phone");
                // Return the array
                return profile;
            }
            return null;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    /**
     * Retrieve customer vehicles using eid and sid from UI
     */
    public static String[][] getVehicles() {
        // Create a query
        String query = "SELECT * FROM Vehicle WHERE cid = '" + UI.getCurrentEID() + "' AND sid = '" + UI.getCurrentSID() + "'";
        // Run the query
        try {
            ResultSet result = JDBC.executeQuery(query);
            // Create an array list to hold the result
            ArrayList<String[]> vehicles = new ArrayList<String[]>();
            // Return the list of vehicles as a 2d array
            while (result.next()) {
                // Create an array to hold the result
                String[] vehicle = new String[4];
                // VIN
                vehicle[0] = result.getString("vin");
                // Make
                vehicle[1] = result.getString("manf");
                // Model
                vehicle[2] = result.getString("mileage");
                // Year
                vehicle[3] = result.getString("year");
                // Add array to the list
                vehicles.add(vehicle);
            }
            // If there is a result, return it as an array
            if (vehicles.size() > 0) {
                // Convert the array list to an array
                return vehicles.toArray(new String[vehicles.size()][]);
            }
            return null;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    /* 
     * Get eligible maintenance 
    */
    public static String[] getEligibleMaintenance(String Vin) {
        // Get the next schedule name
        String query = "SELECT SCHEDULE AS CURRENT_SCHEUDLE, CASE WHEN SCHEDULE= 'A' THEN 'B' WHEN SCHEDULE= 'B' THEN 'C' ELSE 'A' END AS NEXT_SCHEDULE FROM VEHICLE WHERE VIN='" + Vin + "'";
        String nextSchedule = null;
        String nextScheduleNumber = null;
        try {
            ResultSet result = JDBC.executeQuery(query);
            while (result.next()) {
                nextSchedule = result.getString("NEXT_SCHEDULE");}
            if (nextSchedule == null) {nextSchedule = "A";}
            // get schedlenmber for the schedule 
            String scheduleNumberQuery = "SELECT * FROM Schedule WHERE serviceName = '" + nextSchedule + "'";
            ResultSet res = JDBC.executeQuery(scheduleNumberQuery);
            while (res.next()) {
                nextScheduleNumber = res.getString("serviceNumber");}
            String[] temp = {"",""};
            temp[0] = nextSchedule;
            temp[1] = nextScheduleNumber;
            return temp;
        } catch (SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return null;
    }
    }

    public static String getScheduleCost(String scheduleName, String scheduleNumber, String Vin) {
        String query = "SELECT PRICE from Cost_details WHERE serviceName='" + scheduleName +"' AND serviceNumber='"+ scheduleNumber + "' AND sid='" + UI.getCurrentSID() + "' AND manf=(SELECT TRIM(manf) AS manf from Vehicle where vin='"+Vin+"')";
        try {
            String scheduleCost =null;
            ResultSet res = JDBC.executeQuery(query);
            while (res.next()) {
                scheduleCost = res.getString("PRICE");
                return scheduleCost;}
            return scheduleCost;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;}
    }
    /**
     * Add Car to the database
     * 
     * @param String[] Vehicle information (vin, manf, mileage, year)
     * @return boolean true if successful, false if not
     */
    public static boolean addVehicle(String[] information) {
        // Create a query
        String query = "INSERT INTO vehicle (vin, manf, mileage, year, cid, sid) VALUES ('" + information[0] + "', '" + information[1] + "', '" + information[2] + "', '" + information[3] + "', '" + UI.getCurrentEID() + "', '" + UI.getCurrentSID() + "')";
        // Run the query
        try {
            return JDBC.executeQuery(query).next();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete car from the database
     *
     * @param String VIN of the car to delete
     * @return boolean true if successful, false if not
     */
    public static boolean deleteVehicle(String vin) {
        // Create a query
        String query = "DELETE FROM vehicle WHERE vin = '" + vin + "' AND cid = '" + UI.getCurrentEID() + "' AND sid = '" + UI.getCurrentSID() + "'";
        // Run the query
        return JDBC.executeUpdate(query);
    }

}
