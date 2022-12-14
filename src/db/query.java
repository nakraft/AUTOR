package db;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
// Import sql
import java.sql.*;

/**
 * queries class
 */
public class query {
    
    /**
     * Run .SQL file on JDBC
     * 
     * @param filename name of .SQL file
     */
    public static void runSQL(String filename) {
        // Load the .SQL file as a file
        File file = new File(filename);
        // Create a list of queries
        List<String> queries = new ArrayList<String>();
        // Create a scanner to read the file
        try {
            Scanner scanner = new Scanner(file);
            String currentQuery = "";
            // Read the file line by line
            while (scanner.hasNextLine()) {
                // Get the next line
                String line = scanner.nextLine().trim();
                // If the line starts with --, skip it
                if (line.startsWith("--")) {
                    // Skip the line
                    continue;
                }
                // If the line starts with /*, skip lines until one contains */
                if (line.startsWith("/*")) {
                    // Skip lines until one contains */
                    while (!line.contains("*/")) {
                        // If there is no next line, continue
                        if (!scanner.hasNextLine()) {
                            continue;
                        }
                        // Get the next line
                        line = scanner.nextLine().trim();
                    }
                    // Skip the line
                    continue;
                }
                // If line is "", ");", or "/", then add the query to the list
                if ((line.isBlank() || line.equals(");") || line.equals("/"))) {
                    // If current query is empty, continue
                    if (currentQuery.isBlank()) {
                        continue;
                    }
                    // Trim the current query
                    currentQuery = currentQuery.trim();
                    // If line is );, add ) to the query
                    if (line.equals(");")) {
                        currentQuery += ")";
                    }
                    // If currentQuery ends with ;, remove the ;
                    if (!line.equals("/") && currentQuery.endsWith(";")) {
                        currentQuery = currentQuery.substring(0, currentQuery.length() - 1);
                    }
                    // Add the query to the list
                    queries.add(currentQuery);
                    // Reset the current query
                    currentQuery = "";
                    // Skip the line
                    continue;
                }
                // Otherwise, add the line to the current query
                else {
                    // If line has --, remove it and everything after it
                    if (line.contains("--")) {
                        line = line.substring(0, line.indexOf("--")).trim();
                    }
                    currentQuery += line + " ";
                }
            }
            // If we're done reading input, check to see if we have a query that needs added
            if (!currentQuery.isEmpty()) {
                currentQuery = currentQuery.trim();
                // If currentQuery ends with ;, remove the ;
                if (currentQuery.endsWith(";")) {
                    currentQuery = currentQuery.substring(0, currentQuery.length() - 1);
                }
                // Add the current query to the list of queries
                queries.add(currentQuery);
            }
            // Convert the queries list to an array
            String[] queryArray = queries.toArray(new String[0]);
            // Run the queries
            for (String query : queryArray) {
                // Run the query
                JDBC.executeUpdate(query);
            }
            // JDBC.executeQueries(queryArray);
            // Close the scanner
            scanner.close();
        } catch (Exception e) {
            // Print an error message
            System.out.println("Error reading file");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
    }

    /**
     * Check credentials
     * 
     * @param username Username to check
     * @param password Password to check
     * @return eid, sid, and role of user, or null if user does not exist
     */
    public static String[] checkCredentials(String username, String password) {
        // Query the employee table
        try {
            // Query the Employee table for eid, sid, and role
            ResultSet result = JDBC.executeQuery("SELECT eid, sid, role FROM Employee WHERE username = '" + username + "' AND password = '" + password + "'");
            // If the query returns a result
            if (result.next()) {
                String[] credentials = new String[] { result.getString("eid"), result.getString("sid"), result.getString("role") };
                result.close();
                return credentials;
            }
            // Otherwise query the Customer table for cid and sid
            else {
                result = JDBC.executeQuery("SELECT cid, sid FROM Customer WHERE username = '" + username + "' AND password = '" + password + "'");
                // If the query returns a result
                if (result.next()) {
                    String[] credentials = new String[] { result.getString("cid"), result.getString("sid"), "customer" };
                    result.close();
                    return credentials;
                }
                // Otherwise return null
                else {
                    result.close();
                    return null;
                }
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
        try {
            // First check for the username in the Employee table
            ResultSet result = JDBC.executeQuery("SELECT * FROM Employee WHERE username = '" + username + "'"); 
            // If the query returns a result
            if (result.next()) {
                // Return true
                return true;
            }
            // Then check for the username in the Customer table
            result = JDBC.executeQuery("SELECT * FROM Customer WHERE username = '" + username + "'");
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
     * Get unique username
     * 
     * @param first First name of user
     * @param last  Last name of user
     * 
     * @return unique username
     */
    public static String getUniqueUsername(String first, String last) {
        // Create a username
        String username = first.toLowerCase().substring(0, 1) + last.toLowerCase();
        // If the username is already taken, add a number to the end
        int i = 1;
        while (findUsername(username)) {
            username = first.toLowerCase().substring(0, 1) + last.toLowerCase() + i;
            i++;
        }
        // Return the username
        return username;
    }

    /**
     * Find existing store id
     * 
     * @param storeID the store id to search for
     */
    public static boolean findStoreID(String storeID) {
        try {
            // Query the store table
            ResultSet result = JDBC.executeQuery("SELECT * FROM Service_Center WHERE SID = " + storeID);
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
     * Find an existing service id
     * 
     * @param serviceID the service id to search for
     * @returns True if the service ID already exists, otherwise false
     */
    public static boolean checkDuplicateServiceID(String serviceID) {
        try {
            // Query the service table
            ResultSet result = JDBC.executeQuery("SELECT * FROM Services WHERE serviceId = '" + serviceID + "'");
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