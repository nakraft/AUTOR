package db;
// Import SQL libraries
import java.sql.*;

/**
 * JDBC class for interacting with the database
 */
public class JDBC {
    // JDBC Driver name
    static final private String jdbcDriver = "oracle.jdbc.OracleDriver";
    // Database connection
    static private Connection connection = null;
    // Database statement
    static private Statement statement = null;
    // Database result set
    static private ResultSet resultSet = null;

    /**
     * Database setup method
     */
    public static void loadDatabase(String url, String user, String password) {
        // Load the JDBC driver
        try {
            Class.forName(jdbcDriver);
        // If the driver can't be loaded
        } catch (ClassNotFoundException e) {
            // Print an error message
            System.out.println("JDBC driver not found");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // Connect to the database
        try {
            connection = DriverManager.getConnection(url, user, password);
            statement = connection.createStatement();
        // If the connection can't be made
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error connecting to database");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
    }

    /**
     * Close connection to database
     */
    public static void closeDatabase() {
        // Close the database connection
        try {
            connection.close();
        // If the connection can't be closed
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error closing database connection");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
    }

    /**
     * Execute a query
     * 
     * @param query the query to execute
     * @return the result set of the query
     */
    public static ResultSet executeQuery(String query) {
        // Execute the query
        try {
            resultSet = statement.executeQuery(query);
        // If the query can't be executed
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // Return the result set
        return resultSet;
    }

    /**
     * Execute an update
     * 
     * @param update the update to execute
     */
    public static void executeUpdate(String update) {
        // Execute the update
        try {
            statement.executeUpdate(update);
        // If the update can't be executed
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing update");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
    }
}
