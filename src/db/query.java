package db;
// Import sql
import java.sql.*;

/**
 * queries class
 */
public class query {
    /**
     * Check credentials
     * 
     * @param username
     * @param password
     * @return table name with matching username and password, otherwise NULL
     */
    public static String checkCredentials(String username, String password) {
        // Possible tables: MANAGER, RECEPTIONIST, MECHANIC, CUSTOMER
        // Query manager table
        try {
            // Query the manager table
            ResultSet result = JDBC.executeQuery("SELECT * FROM MANAGER WHERE USERNAME = '" + username + "' AND PASSWORD = '" + password + "'");
            // If the query returns a result
            if (result.next()) {
                // Return the table name
                return "MANAGER";
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // Query receptionist table
        try {
            // Query the receptionist table
            ResultSet result = JDBC.executeQuery("SELECT * FROM RECEPTIONIST WHERE USERNAME = '" + username + "' AND PASSWORD = '" + password + "'");
            // If the query returns a result
            if (result.next()) {
                // Return the table name
                return "RECEPTIONIST";
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // Query mechanic table
        try {
            // Query the mechanic table
            ResultSet result = JDBC.executeQuery("SELECT * FROM MECHANIC WHERE USERNAME = '" + username + "' AND PASSWORD = '" + password + "'");
            // If the query returns a result
            if (result.next()) {
                // Return the table name
                return "MECHANIC";
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // Query customer table
        try {
            // Query the customer table
            ResultSet result = JDBC.executeQuery("SELECT * FROM CUSTOMER WHERE USERNAME = '" + username + "' AND PASSWORD = '" + password + "'");
            // If the query returns a result
            if (result.next()) {
                // Return the table name
                return "CUSTOMER";
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // If no matching username and password is found
        return null;
    }

    /**
     * Find username in any table.
     * 
     * @param username the username to search for
     * @return true if the username is found, otherwise false
     */
    public static boolean findUsername(String username) {
        // Possible tables: MANAGER, RECEPTIONIST, MECHANIC, CUSTOMER
        try {
            // Query all the tables at once
            ResultSet result = JDBC.executeQuery("SELECT * FROM MANAGER, RECEPTIONIST, MECHANIC, CUSTOMER WHERE USERNAME = '" + username + "'");
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
        // If no matching username is found
        return false;
    }

    /**
     * Find existing store id
     * 
     * @param storeID the store id to search for
     */
    public static boolean findStoreID(String storeID) {
        try {
            // Query the store table
            ResultSet result = JDBC.executeQuery("SELECT * FROM SERVICE_CENTER WHERE SID = " + storeID);
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
        // If no matching store id is found
        return false;
    }

    /**
     * Find existing service id
     * 
     * @param serviceID the service id to search for
     */
    public static boolean findServiceNumber(String serviceID) {
        try {
            // Query the service table
            ResultSet result = JDBC.executeQuery("SELECT * FROM SERVICEs WHERE NUMBER = " + serviceID);
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
        // If no matching service id is found
        return false;
    }
}