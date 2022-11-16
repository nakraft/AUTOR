package db;
// Import SQL libraries
import java.sql.*;

import java.util.ArrayList;

import ui.UI;

/**
 * JDBC class for interacting with the database
 */
public class JDBC {
    // JDBC Driver name
    static final private String jdbcDriver = "oracle.jdbc.OracleDriver";
    // Database connection
    static private Connection connection = null;
    // Debug flag
    static private boolean DEBUG = false;
    // Wait for user flag
    static private boolean AUTOMATED_TEST_MODE = false;
    // Last statement
    static private Statement lastStatement = null;

    /**
     * Enable Test Mode
     */
    static public void enableTestMode() {
        AUTOMATED_TEST_MODE = true;
        DEBUG = true;
    }

    /**
     * Database setup method
     */
    public static void loadDatabase(String url, String user, String password) {
        // Load the JDBC driver
        try {
            Class.forName(jdbcDriver);
        // If the driver can't be loaded
        } catch (ClassNotFoundException e) {
            somethingWentWrong(e);
            return;

            // // Print an error message
            // System.out.println("JDBC driver not found");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        // Connect to the database
        try {
            connection = DriverManager.getConnection(url, user, password);
        // If the connection can't be made
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return;

            // // Print an error message
            // System.out.println("Error connecting to database");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
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
            somethingWentWrong(e);
            return;

            // // Print an error message
            // System.out.println("Error closing database connection");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
    }

    /**
     * Drop all tables
     * 
     * @return true if successful, otherwise false
     */
    public static boolean dropAllTables() {
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
            somethingWentWrong(e);
            return false;

            // // Print an error message
            // System.out.println(e.getMessage());
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        // Close the result set
        try {
            tables.close();
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return false;
            
            // // Print an error message
            // System.out.println("Error closing result set");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
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
            somethingWentWrong(e);
            return false;

            // // Print an error message
            // System.out.println(e.getMessage());
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        // Close the result set
        try {
            Sequences.close();
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return false;

            // // Print an error message
            // System.out.println("Error closing result set");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        return true;
    }
    
    /**
     * Drop all tables
     * Then load the tables from the SQL files (set_up.sql, populating.sql)
     * 
     * @return true if successful, otherwise false
     */
    public static boolean setupTables() {
        dropAllTables();
        query.runSQL("setup.sql");
        return true;
    }

    /**
     * Populate tables (Full)
     */
    public static void populateTablesFull() {
        setupTables();
        // Then load in the full population file
        query.runSQL("populating.sql");
    }

    /**
     * Populate tables (Partial)
     */
    public static void populateTablesPartial() {
        setupTables();
        // Then load in the partial population file
        query.runSQL("populating_partial.sql");
    }

    /**
     * Execute several updates at once
     * Used to remain atomic :)
     * 
     * @param queries Queries to execute
     * @return Result set of the last query
     */
    public static int[] executeUpdatesAtomic(String[] queries) {
        Statement statement = null;
        // Create a statement
        try {
            statement = connection.createStatement();
        }
        // If the statement can't be created
        catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return null;

            // // Print an error message
            // System.out.println("Error creating statement");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
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
            lastStatement = statement;
            return result;
        }
        // If the queries can't be executed
        catch (java.sql.SQLException e) {
            try {
                connection.rollback();
                connection.setAutoCommit(true);
            } catch ( SQLException sql ) {
                somethingWentWrong(sql);
            }

            somethingWentWrong(e);
            return null;

            // // Print an error message
            // System.out.println("Error executing queries");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
    }

    /**
     * Execute
     * Returns true if the first object that the query returns is a ResultSet
     * object. Use this method if the query could return one or more ResultSet
     * objects. Retrieve the ResultSet objects returned from the query by
     * repeatedly calling Statement.getResultSet
     * 
     * @param query Query to execute
     * @return Result set of the query
     */
    public static boolean execute(String query) {
        Statement statement = null;
        // Create a statement
        try {
            statement = connection.createStatement();
        }
        // If the statement can't be created
        catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return false;

            // // Print an error message
            // System.out.println("Error creating statement");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        try {
            // Execute the query
            if (DEBUG) {
                System.out.println(query);
            }
            statement.execute(query);
            return true;
        }
        // If the query can't be executed
        catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return false;

            // // Print an error message
            // System.out.println("Error executing query");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
    }

    /**
     * Execute a query
     * Returns one ResultSet object.
     * Use this method if you are using Select SQL statements
     * 
     * @param query the query to execute
     * @return the result set of the query
     */
    public static ResultSet executeQuery(String query) {
        // Make sure auto commit is enabled
        try {
            connection.setAutoCommit(true);
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return null;

            // // Print an error message
            // System.out.println("Error setting auto commit");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }

        // Create new statement
        Statement statement = null;
        try {
            statement = connection.createStatement();
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return null;

            // // Print an error message
            // System.out.println("Error creating statement");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }

        // Execute the query
        ResultSet resultSet = null;
        try {
            if (DEBUG) {
                System.out.println(query);
            }
            resultSet = statement.executeQuery(query);
            lastStatement = statement;
        // If the query can't be executed
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return null;

            // // Print an error message
            // System.out.println("Error executing query");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        // Return the result set
        return resultSet;
    }

    /**
     * Execute an update
     * Returns an integer representing the number of rows affected by the SQL
     * statement. Use this method if you are using INSERT, DELETE, or UPDATE
     * SQL statements
     * 
     * @param update the update to execute
     */
    public static int executeUpdate(String update) {
        // Make sure auto commit is enabled
        try {
            connection.setAutoCommit(true);
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return -1;

            // // Print an error message
            // System.out.println("Error setting auto commit");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        
        // Create new statement
        Statement statement = null;
        try {
            statement = connection.createStatement();
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return -1;

            // // Print an error message
            // System.out.println("Error creating statement");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }

        // Execute the update
        int rows = -1;
        try {
            if (DEBUG) {
                System.out.println(update);
            }
            rows = statement.executeUpdate(update);
        // If the update can't be executed
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return -1;

            // // Print an error message
            // System.out.println("Error executing update");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }
        // Return true if the update was successful
        return rows;
    }

    /**
     * Print results
     */
    public static void printResults(ResultSet resultSet) {
        // Results
        ArrayList<String[]> results = new ArrayList<String[]>();
        int columns = 0;
        // Print the results
        try {
            // Get the number of columns
            columns = resultSet.getMetaData().getColumnCount();
            // Create an ArrayList of String arrays
            // Go through each row
            while (resultSet.next()) {
                // Create a new array
                String[] row = new String[columns];
                // Go through each column
                for (int i = 1; i <= columns; i++) {
                    // Populate each row in the column
                    row[i - 1] = resultSet.getString(i);
                }
                // Add the row to the results
                results.add(row);
            }
        // If the results can't be printed
        } catch (java.sql.SQLException e) {
            somethingWentWrong(e);
            return;

            // // Print an error message
            // System.out.println("Error printing results");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
        }

        // If there are no results
        if (results.size() == 0) {
            return;
        }

        // Create an array of the longest size of each elemnt in each column
        int[] longest = new int[columns];
        // Initiliaze the array
        for (int i = 0; i < columns; i++) {
            if (results.get(0)[i] != null) {
                longest[i] = results.get(0)[i].length();
            } else {
                longest[i] = 0;
            }
        }
        // Go through each row
        for (String[] row : results) {
            // Go through each column
            for (int i = 0; i < row.length; i++) {
                // If row[i] is null, replace it with "null"
                if (row[i] == null) {
                    row[i] = "NULL";
                }
                // If the current element is longer than the longest element
                if (row[i].length() > longest[i]) {
                    // Set the longest element to the current element
                    longest[i] = row[i].length();
                }
            }
        }
        // Add one to each row in longest and a 4 space buffer
        for (int i = 0; i < longest.length; i++) {
            longest[i] = longest[i] + 4;
        }
        // Print the results
        for (String[] row : results) {
            // Go through each column
            for (int i = 0; i < row.length; i++) {
                // Print the element
                System.out.print(row[i]);
                // Print the correct number of tabs
                for (int j = 0; j < longest[i] - row[i].length(); j ++) {
                    System.out.print(" ");
                }
            }
            // Print a new line
            System.out.println();
        }
    }

    /*
     * Private "Something Went Wrong" Method
     * Call instead of System.exit(1)
     */
    private static void somethingWentWrong(Exception e) {
        if (!AUTOMATED_TEST_MODE) {
            // Print an error message
            System.out.println("\nSomething went wrong with your request :(");
            System.out.println("Here are the details:");
            // Standard error message
            System.out.println(e.getMessage());
            // If debugging, print the whole stack trace
            if (DEBUG) {
                e.printStackTrace();
            }
            // Wait for user to press enter
            System.out.println("Press enter to continue...");
            UI.input.nextLine();
        }
        else {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
    

    /**
     * Get last statement
     */
    public static Statement getLastStatement() {
        return lastStatement;
    }
}
