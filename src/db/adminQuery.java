package db;

// Import SQL libraries
import java.sql.*;

/**
 * Queries for admins
 */
public class adminQuery {

    /**
     * Add a new store
     */
    public static boolean addStore(String[] responses) {
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                "INSERT INTO Service_Center (" +
                '"' + "sid" + '"' + ',' +
                '"' + "address" + '"' + ',' +
                '"' + "mechanic_minimum_rate" + '"' + ',' +
                '"' + "mechanic_maximum_rate) VALUES (" +
                responses[0] + ',' +
                responses[1] + ',' +
                responses[8] + ',' +
                responses[9] + ')'
            )) {
                throw new java.sql.SQLException("Error updating service center");
            }
            // If the query inserts a row
            if (!JDBC.executeUpdate(
                "INSERT INTO Employee (" +
                '"' + "first_name" + '"' + ',' +
                '"' + "last_name" + '"' + ',' +
                '"' + "username" + '"' + ',' +
                '"' + "password" + '"' + ',' +
                '"' + "eid" + '"' + ',' +
                '"' + "role" + '"' + ',' +
                '"' + "sid) VALUES (" +
                responses[2] + ',' + 
                responses[3] + ',' + 
                responses[4] + ',' + 
                responses[5] + ',' + 
                responses[7] + ',' + 
                "M," +
                responses[0] + ')' 
            )) {
                throw new java.sql.SQLException("Error updating duration details");
            }
        } catch (java.sql.SQLException e) {
            /*
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
            */
            return false;
        }
        // If there aren't any errors
        return true;
    }

    /**
     * Validate the existence of a service category
     * 
     * @param repairCategory the repair category to search for
     * @returns True if the service category exists, otherwise false
     */
    public static boolean validateRepairCategory(String repairCategory) {
        try {
            // Query the service table
            ResultSet result = JDBC.executeQuery("SELECT * FROM Services WHERE repair_category = '" + repairCategory + "'");
            // If the query returns a result
            if (result.next()) {
                // Return true
                return true;
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // If no matching service category is found
        return false;
    }

        /**
     * Add a new service
     */
    public static boolean addService(String[] responses) {
        try {
            // Insert into the store table
            if(!JDBC.executeUpdate(
                "INSERT INTO Services (" +
                '"' + "serviceName" + '"' + ',' +
                '"' + "serviceNumber" + '"' + ',' +
                '"' + "repairCategory) VALUES (" +
                    responses[1] + ',' + 
                    responses[4] + ',' + 
                    responses[0] + ')'
            )) {
                throw new java.sql.SQLException("Error updating services");
            }
            if (!JDBC.executeUpdate(
                    "INSERT INTO Duration_Details (" +
                    '"' + "manf" + '"' + ',' +
                    '"' + "dur" + '"' + ',' +
                    '"' + "serviceName" + '"' + ',' +
                    '"' + "serviceNumber) VALUES (" +
                    responses[3] + ',' + 
                    responses[2] + ',' + 
                    responses[1] + ',' + 
                    responses[4] + ')'
                )) {
                    throw new java.sql.SQLException("Error updating duration details");
                }
        } catch (java.sql.SQLException e) {
            /*
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
            */
            return false;
        }
        // If there aren't any errors
        return true;
    }    
}
