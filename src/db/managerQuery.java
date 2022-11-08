package db;

import java.sql.*;
import ui.UI;

/**
 * Queries for managers
 */
public class managerQuery {

    /**
     * Add employee to the database
     * 
     * @param String[] of employee information (first name, last name, email, phone, role, start date, compensation)
     * @return Integer of new employee's EID
     */
    public static Integer addEmployee(String[] employee) {
        // If role is not a receptionist or mechanic
        if (!employee[4].equals("receptionist") && !employee[4].equals("mechanic")) {
            // Return false
            return null;
        }
        // Execute query (username is first initial + last name, password is last name)
        String username = employee[0].substring(0, 1) + employee[1];
        String password = employee[1];
        // Create an Oracle variable used to keep track of the new employee's EID
        JDBC.executeQuery("DECLARE prmkkey NUMBER");
        JDBC.executeQuery("INSERT INTO Employee (first_name, last_name, email, phone, role, start_date, username, password, sid) VALUES ('" + employee[0] + "', '" + employee[1] + "', '" + employee[2] + "', '" + employee[3] + "', '" + employee[4] + "', '" + employee[5] + "', '" + username + "', '" + password + "', " + UI.getCurrentSID() + ") RETURNING eid INTO prmkey)");
        // Get the new employee's EID
        ResultSet result = JDBC.executeQuery("SELECT prmkey FROM dual");
        // Get the EID of the new employee
        int eid = 0;
        try {
            if (result.next()) {
                eid = result.getInt("prmkey");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
        // If the EID is null
        if (eid == 0) {
            // Return null
            return null;
        }
        // If the role is a mechanic
        if (employee[4].toLowerCase().equals(
            "mechanic")) {
            // Execute query
            JDBC.executeQuery("INSERT INTO Mechanic (eid, sid, rate) VALUES (" + eid + ", " + UI.getCurrentSID() + ", " + employee[6] + ") RETURNING eid INTO prmkey)");
            try {
                if (result.next()) {
                    eid = result.getInt("prmkey");
                }
            } catch (SQLException e) {
                System.out.println("Error: " + e.getMessage());
                return null;
            }
        }
        // Else if the role is a receptionist
        else if (employee[4].toLowerCase().equals("receptionist")) {
            // Execute query
            JDBC.executeQuery("INSERT INTO Receptionist (eid, sid, salary) VALUES (" + eid + ", " + UI.getCurrentSID() + ", " + employee[6] + ") RETURNING eid INTO prmkey)");
            try {
                if (result.next()) {
                    eid = result.getInt("prmkey");
                }
            } catch (SQLException e) {
                System.out.println("Error: " + e.getMessage());
                return null;
            }
        }
        // Return the EID
        return eid;
    }   
}
