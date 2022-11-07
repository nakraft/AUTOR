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
                    currentQuery += line + " ";
                }
            }
            // If the current query is not empty
            if (!currentQuery.isEmpty()) {
                // Add the current query to the list of queries
                queries.add(currentQuery);
            }
            // Execute all the queries
            for (String query : queries) {
                // Print out query (debugging)
                // System.out.println(query);
                // Execute the query
                // Execute it as a query if it's not an update
                if (!query.startsWith("UPDATE")) {
                    JDBC.executeQuery(query);
                }
                // Execute it as an update if it is an update
                else {
                    // If the update fails, throw an exception
                    if (!JDBC.executeUpdate(query))
                        throw new Exception("Update failed");
                }
            }
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
     * @param username
     * @param password
     * @return table name with matching username and password, otherwise NULL
     */
    public static String checkCredentials(String username, String password) {
        // Query the employee table
        try {
            // Query the manager table
            ResultSet result = JDBC.executeQuery("SELECT * FROM Employee WHERE username = '" + username + "' AND password = '" + password + "'");
            // If the query returns a result
            if (result.next()) {
                return result.getString("role");
            }
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        // If no matching username and password is found
        return "";
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
            ResultSet result = JDBC.executeQuery("SELECT * FROM Manager, Receptionist, Mechanic, Customer WHERE username = '" + username + "'"); 
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