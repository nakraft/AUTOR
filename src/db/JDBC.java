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
     * Drop all tables
     * Then load the tables from the SQL files (set_up.sql, populating.sql)
     */
    public static void resetDatabase() {
        // Drop all tables
        ResultSet tables = executeQuery("select 'drop table \"'||table_name||'\" cascade constraints' from user_tables");
        try {
            // Go through each table
            while (tables.next()) {
                // Print the drop table statement
                // System.out.println(tables.getString(1));
                // Drop the table
                executeUpdate(tables.getString(1));
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println(e.getMessage());
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // Close the result set
        try {
            tables.close();
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error closing result set");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        
        // Load the tables from the SQL files
        // TODO: fix populating.sql so it doesn't crash
        query.runSQL("set_up.sql");
        //query.runSQL("populating.sql");
    }        
    

    /**
     * Execute a query
     * 
     * @param query the query to execute
     * @return the result set of the query
     */
    public static ResultSet executeQuery(String query) {
        // Create new statement
        Statement statement = null;
        try {
            statement = connection.createStatement();
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error creating statement");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }

        // Execute the query
        ResultSet resultSet = null;
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
        // Create new statement
        Statement statement = null;
        try {
            statement = connection.createStatement();
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error creating statement");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }

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
