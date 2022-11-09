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
        // Drop each sequence the user has added to the table (that the system doesn't own)
        ResultSet Sequences = executeQuery("select 'drop sequence \"'||sequence_name||'\"' FROM user_sequences WHERE sequence_name LIKE 'AUTO_%'");
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
        // Go through the sequences and close them too
        try {
            // Go through each table
            while (Sequences.next()) {
                // Print the drop table statement
                // System.out.println(tables.getString(1));
                // Drop the table
                executeUpdate(Sequences.getString(1));
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
            Sequences.close();
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error closing result set");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        
        // Load the tables from the SQL files
        query.runSQL("base_logic.sql");
        query.runSQL("populating.sql");
    }

    /**
     * Reset Database (Full Population)
     */
    public static void resetDatabaseFull() {
        // Reset the database
        resetDatabase();
        // Then load in the full population file
        query.runSQL("populating_full.sql");
    }

    /**
     * Execute several queries at once
     * Used to remain atomic :)
     * 
     * @param queries Queries to execute
     * @return Result set of the last query
     */
    public static int[] executeQueries(String[] queries) {
        Statement statement = null;
        // Create a statement
        try {
            statement = connection.createStatement();
        }
        // If the statement can't be created
        catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error creating statement");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        try {
            // Execute all the queries
            for (String query : queries) {
                statement.addBatch(query);
            }
            // Disable auto commit
            connection.setAutoCommit(false);
            // Execute the queries
            int[] result = statement.executeBatch();
            // Commit the changes
            connection.commit();
            // Enable auto commit
            connection.setAutoCommit(true);
            return result;
        }
        // If the queries can't be executed
        catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing queries");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        return null;
    }
    

    /**
     * Execute a query
     * 
     * @param query the query to execute
     * @return the result set of the query
     */
    public static ResultSet executeQuery(String query) {
        // Make sure auto commit is enabled
        try {
            connection.setAutoCommit(true);
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error setting auto commit");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }

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
            System.out.println(query);
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
    public static boolean executeUpdate(String update) {
        // Make sure auto commit is enabled
        try {
            connection.setAutoCommit(true);
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error setting auto commit");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        
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

            return false;
        }

        // Execute the update
        try {
            System.out.println(update);
            statement.executeUpdate(update);
        // If the update can't be executed
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing update");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
            return false;
        }
        // Return true if the update was successful
        return true;
    }

    /**
     * Print results
     */
    public static void printResults(ResultSet resultSet) {
        // Print the results
        try {
            // Get the number of columns
            int columns = resultSet.getMetaData().getColumnCount();
            // Go through each row
            while (resultSet.next()) {
                // Go through each column
                for (int i = 1; i <= columns; i++) {
                    // Print the column
                    System.out.print(resultSet.getString(i) + "\t");
                }
                // Print a new line
                System.out.println();
            }
        // If the results can't be printed
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error printing results");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
    }
}
