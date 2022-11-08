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
            JDBC.executeQuery(
                "INSERT INTO Service_Center (" +
                    "sid, " +
                    "address, " +
                    "manager_id, " +
                    "mechanic_minimum_rate, " +
                    "mechanic_maximum_rate" +
                ") VALUES (" +
                    responses[0] + "," +
                    "'" + responses[1] + "'," +
                    responses[7] + "," +
                    responses[8] + "," +
                    responses[9] +
                ")"
            );
            // If the query inserts a row
            if (!JDBC.executeUpdate(
                "UPDATE Employee SET " +
                    "first_name = '" + responses[2] + "', " +
                    "last_name = '" + responses[3] + "', " +
                    "username = '" + responses[4] + "', " +
                    "password = '" + responses[5] + "' " +
                    "WHERE eid = " + responses[7]
            )) {
                throw new java.sql.SQLException("Error updating duration details");
            }
            // If the query inserts a row
            if (!JDBC.executeUpdate(
                "UPDATE Mechanic SET " +
                    "rate = " + responses[6] +
                    "WHERE eid = " + responses[7]
            )) {
                throw new java.sql.SQLException("Error updating duration details");
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
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
            // Get the last service number
            ResultSet result = JDBC.executeQuery("SELECT MAX(serviceNumber) FROM Work_Event");
            String nextId = result.getString(0);
            // Insert into the store table
            if(!JDBC.executeUpdate(
                "INSERT INTO Services (" +
                '"' + "serviceName" + '"' + ',' +
                '"' + "serviceNumber" + '"' + ',' +
                '"' + "repairCategory) VALUES (" +
                    responses[1] + ',' + 
                    nextId + ',' + 
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
