package db;

import java.sql.*;
import java.util.ArrayList;

import ui.UI;

/**
 * Queries for managers
 */
public class managerQuery {

    /**
     * Add employee to the database
     * 
     * @param String[] of employee information (first name, last name, email, phone, role, start date, compensation)
     * @return int of new employee's EID
     */
    public static String addEmployee(String[] employee) {
        // If role is not a receptionist or mechanic
        if (!employee[5].equals("receptionist") && !employee[5].equals("mechanic")) {
            // Return false
            return "Error: Invalid role";
        }
        // Get a unique useername
        String username = query.getUniqueUsername(employee[0], employee[1]);
        String password = employee[1].toLowerCase();

        // Insert the employee into the database
        JDBC.executeQuery(
        "INSERT INTO Employee (" + 
                "first_name, last_name, address, email, phone, role, start_date, username, password, sid" +
            ") VALUES (" +
                "'" + employee[0] + "', " +
                "'" + employee[1] + "', " +
                "'" + employee[2] + "', " +
                "'" + employee[3] + "', " +
                "'" + employee[4] + "', " +
                "'" + employee[5] + "', " +
                "'" + employee[6] + "', " +
                "'" + username + "', " +
                "'" + password + "', " +
                "'" + UI.getCurrentSID() + "'" +
            ")");
        // Lookup the new employee's EID
        ResultSet result = JDBC.executeQuery("SELECT eid FROM Employee WHERE username = '" + username + "'");
        int eid = -1;
        // If there is a result
        try {
            // 
            if (result.next()) {
                // Set eid to the result
                eid = result.getInt("eid");
                return String.valueOf(eid);
            }
            if (eid == -1) {
                return "Error: Could not find new employee in table";
            }
        } catch (SQLException e) {
            return "Error: Could not find new employee in table";
        }
        // If the role is a mechanic
        if (employee[4].toLowerCase().equals("mechanic")) {
            // Execute update on eid and sid in Mechanic table
            boolean success = JDBC.executeUpdate("UPDATE Mechanic SET rate=" + employee[7] + " WHERE eid = " + eid + " AND sid = " + UI.getCurrentSID());
            if (!success) {
                // Remove the employee from the database
                JDBC.executeUpdate("DELETE FROM Employee WHERE eid = " + eid);
                return "Error: Could not update mechanic";
            }
        }
        // Else if the role is a receptionist
        else if (employee[4].toLowerCase().equals("receptionist")) {
            // Execute update on eid and sid in Receptionist table
            boolean success = JDBC.executeUpdate("UPDATE Receptionist SET salary=" + employee[7] + " WHERE eid = " + eid + " AND sid = " + UI.getCurrentSID());    
            if (!success) {
                // Remove the employee from the Employee table
                JDBC.executeUpdate("DELETE FROM Employee WHERE eid = " + eid);
                return "Error: Could not update receptionist";
            }
        }
        // Return the EID
        return String.valueOf(eid);
    }

    /**
     * Set schedule price
     * 
     * @param scheduleName name of the schedule
     * @param price price of the schedule
     * @param manufacturer vehcile manufacturer
     * @return boolean of success
     */
    public static boolean setSchedulePrice(String scheduleName, String price, String manufacturer) {
        // If the manufacturer is not specified
        if (manufacturer == null || manufacturer.equals("")) {
            // Update the price for all manufacturers
            return JDBC.executeUpdate("UPDATE Cost_Details SET price = " + price + " WHERE serviceName = '" + scheduleName + "' AND sid = " + UI.getCurrentSID());
        }
        // Else update the price for the specified manufacturer
        return JDBC.executeUpdate("UPDATE Cost_Details SET price = " + price + " WHERE serviceName = '" + scheduleName + "' AND sid = " + UI.getCurrentSID() + " AND manf = '" + manufacturer + "'");
    }

    /**
     * Set operational hours
     * 
     * @param openSaturday "Y\N" if open on Saturday
     * @return boolean of success
     */
    public static boolean setOperationalHours(String openSaturday) {
        // Set openSaturday to lowercase
        openSaturday = openSaturday.toLowerCase();
        // If openSaturday is "y" or "yes"
        if ("y".equals(openSaturday) || "yes".equals(openSaturday)) {
            // Update the operational hours to open on Saturday
            return JDBC.executeUpdate("UPDATE Service_Center SET saturday = 'open' WHERE sid = " + UI.getCurrentSID());
        }
        // Else if openSaturday is "n" or "no"
        else if ("n".equals(openSaturday) || "no".equals(openSaturday)) {
            // Update the operational hours to not open on Saturday
            return JDBC.executeUpdate("UPDATE Service_Center SET saturday = 'close' WHERE sid = " + UI.getCurrentSID());
        }
        // Else return false
        return false;
    } 


    /**
     * Query all repair services
     * 
     * @return String[] of repair servicese
     */
    public static String[] getRepairServices() {
        // Query all repair services
        ResultSet result = JDBC.executeQuery("SELECT DISTINCT serviceName FROM Services WHERE repair_category IS NOT NULL");
        // Create an arraylist of repair services
        ArrayList<String> services = new ArrayList<String>();
        // For each repair service
        try {
            while (result.next()) {
                // Add the repair service to the list
                services.add(result.getString("serviceName"));
            }
        } catch (SQLException e) {
            return new String[0];
        }
        // Return the list of repair services (as an array)
        return services.toArray(new String[services.size()]);
    }

    /**
     * Set the price of a repair service
     */
    public static boolean setRepairServicePrice(String serviceName, String price, String manufacturer) {
        System.out.println("UPDATE Cost_Details SET price = " + price + " WHERE serviceName = '" + serviceName + "' AND sid = " + UI.getCurrentSID());
        // If manufacturer is null or not specified
        if (manufacturer == null || manufacturer.equals("")) {
            // Update the price for all manufacturers
            return JDBC.executeUpdate("UPDATE Cost_Details SET price = " + price + " WHERE serviceName = '" + serviceName + "' AND sid = " + UI.getCurrentSID());
        }
        // Else update the price for the specified manufacturer
        return JDBC.executeUpdate("UPDATE Cost_Details SET price = " + price + " WHERE serviceName = '" + serviceName + "' AND sid = " + UI.getCurrentSID() + " AND manf = '" + manufacturer + "'");
    }
}
