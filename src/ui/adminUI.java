package ui;

// Import DB classes
import java.sql.*; // Import SQL classes
import db.JDBC; // JDBC
import db.adminQuery; // Admin queries

// Import File IO
import java.io.*;
// Import arraylist
import java.util.ArrayList;

/*
 * AdminUI class, UI for admin
 */
public class adminUI {

    /**************************************************************************
     * Menus
     *************************************************************************/

    // Admin: Landing
    private static menu adminLanding = new menu(
        "Admin: Landing", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "System Set Up", // adminSystemSetup
            "Add New Store", // adminAddNewStore
            "Add New Service", // adminAddNewService
            "Logout", // homeMenu
            "More Options" // adminMoreOptions
        } // Options
    );

    // Admin: More Options
    private static menu adminMoreOptions = new menu(
        "Admin: More Options", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Reset Database (Standard)", // JDBC.resetDatabase()
            "Reset Database (Full Population)", // JDBC.resetDatabaseFull()
            "SQL Terminal", // adminRunSQLCommands
            "Pre-Generated SQL Commands", // adminPreGeneratedSQLCommands
            "Go Back" // adminLanding
        } // Options
    );    

    // Admin: System Set Up
    private static menu adminSystemSetUp = new menu(
        "Admin: System Set Up", // Header
        null, // Lines
        new String[] {
            "Enter the filename of the service file",
            "Enter the filename of the store file"
        }, // Prompts
        new String[] {
            "Upload Service Information", // remain, loadServiceInfoFromCSV
            "Upload Store Information", // remain, loadStoreInfoFromCSV
            "Go Back" // adminLanding
        } // Options
    );

    // Admin: Add New Store
    private static menu adminAddNewStore = new menu(
        "Admin: Add New Store", // Header
        null, // Lines
        new String[] {
            "Enter the store ID", // 0
            "Enter the store address", // 1
            "Enter the manager's first name", // 2
            "Enter the manager's last name", // 3
            "Enter the manager's username", // 4
            "Enter the manager's password", // 5
            "Enter the manager's salary", // 6
            "Enter the manager's employee ID", // 7
            "Enter the minimum mechanic wage", // 8
            "Enter the maximum mechanic wage", // 9
            "Enter the mechanic hourly rate" // 10
        }, // Prompts
        new String[] {
            "Add Store", // remain, addStore
            "Go Back" // adminLanding
        } // Options
    );

    // Admin: Add New Service
    private static menu adminAddNewService = new menu(
        "Admin: Add New Service", // Header
        null, // Lines
        new String[] {
            "Enter existing service category",
            "Enter service name",
            "Enter service duration"
        }, // Prompts
        new String[] {
            "Add Service", // remain, addService
            "Go Back" // adminLanding
        } // Options
    );

    // Admin: Pre-Generated SQL Commands
    private static menu adminPreGeneratedSQLCommands = new menu(
        "Admin: Pre-Generated SQL Commands", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Which service center has the most number of customers?", // Stay on page
            "What is the average price of an Evaporator Repair for Hondas across all service centers?", // Stay on page
            "Which customer(s) have unpaid invoices in Service Center 30003", // Stay on page
            "List all services that are listed as both maintenance and repair services globally", // Stay on page
            "What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?", // Stay on page"
            "What is the next eligible maintenance schedule service for the car with VIN 34KLE19D", // Stay on page
            "Go Back" // adminMoreOptions
        } // Options
    );

    /**************************************************************************
     * Methods
     *************************************************************************/
    
    /**
     * Admin landing page
     */
    public static void adminLanding() {
        while (true) {
            // Display menu
            switch (adminLanding.display()) {
                case 1: // System Set Up
                    adminSystemSetUp();
                    break;
                case 2: // Add New Store
                    adminAddNewStore();
                    break;
                case 3: // Add New Service
                    adminAddNewService();
                    break;
                case 4: // Logout
                    UI.homeMenu();
                    break;
                case 5: // More options
                    adminMoreOptions();
                    break;
                    
            }
        } 
    }

    /**
     * Admin more options
     */
    public static void adminMoreOptions() {
        while (true) {
            // Display menu
            switch (adminMoreOptions.display()) {
                case 1: // Reset Database (Standard)
                    JDBC.resetDatabase();
                    adminMoreOptions.setFeedback("Database reset");
                    break;
                case 2: // Reset Database (Full Population)
                    JDBC.resetDatabaseFull();
                    adminMoreOptions.setFeedback("Database reset");
                    break;
                case 3: // SQL Terminal
                    adminRunSQLCommands();
                    break;
                case 4: // Pre-Generated SQL Commands
                    adminPreGeneratedSQLCommands();
                    break;
                case 5: // Go Back
                    adminLanding();
                    break;
            }
        }
    }

    /**
     * System set up
     */
    public static void adminSystemSetUp() {
        while (true) {
            switch (adminSystemSetUp.display()) {
                case 1: // Upload Service Information
                    String[][] serviceInfo = parseCSV(adminSystemSetUp.getPromptResponse(0));
                    if (serviceInfo != null) {
                        for (int i = 0; i < serviceInfo.length; i++) {
                            adminQuery.addService(serviceInfo[i]);
                        }
                    }
                    else {
                        adminSystemSetUp.setFeedback("Unable to parse CSV file");
                    }
                    break;
                case 2: // Upload Store Information
                    String[][] storeInfo = parseCSV(adminSystemSetUp.getPromptResponse(1));
                    if (storeInfo != null) {
                        for (int i = 0; i < storeInfo.length; i++) {
                            adminQuery.addStore(storeInfo[i]);
                        }
                    }
                    else {
                        adminSystemSetUp.setFeedback("Unable to parse CSV file");
                    }
                    break;
                case 3: // Go Back
                    // Return to the admin landing page
                    adminLanding();
                    break;
            }
        }
    }

    /**
     * Add new store
     */
    public static void adminAddNewStore() {
        while (true) {
            switch (adminAddNewStore.display()) {
                case 1: // Add Store
                    if (adminQuery.addStore(adminAddNewStore.getPromptResponses())) {
                        adminAddNewStore.setFeedback("Store added successfully");
                    }
                    else {
                        adminAddNewStore.setFeedback("Store not added");
                    }
                    break;
                case 2: // Go Back
                    // Return to the admin landing page
                    adminLanding();
                    break;
            }
        }
    }

    /**
     * Add new service
     */
    public static void adminAddNewService() {
        while (true) {
            switch (adminAddNewService.display()) {
                case 1: // Add Service
                    // raise error if category doesn't exist
                    if(!adminQuery.validateRepairCategory(adminAddNewService.getPromptResponse(0))) {
                        adminAddNewService.setFeedback("Service category doesn't exist. Please try again.");
                        break;
                    }
                    if (adminQuery.addService(adminAddNewService.getPromptResponses())) {
                        adminAddNewService.setFeedback("Service added successfully");
                    }
                    else {
                        adminAddNewService.setFeedback("Adding a new service failed");
                    }
                    break;
                case 2: // Go Back
                    // Return to the admin landing page
                    adminLanding();
                    break;
            }
        }
    }

    /**
     * Run SQL commands
     */
    public static void adminRunSQLCommands() {
        UI.clearScreen();
        System.out.println("Enter SQL commands, enter 'exit' to exit");
        while (true) {
            System.out.print("SQL> ");
            String command = UI.input.nextLine().trim();
            if (command.equals("exit")) {
                // Return to the more results page
                adminMoreOptions();
            }
            else {
                // If the command is insert, delete, or update
                if (command.trim().toLowerCase().matches("(?i)^(insert|delete|update).*")) {
                    // Execute the command
                    int rows = JDBC.executeUpdate(command);
                    // If the command was successful
                    if ( rows > 0) {
                        System.out.println("Query successful, " + rows + " rows affected");
                    }
                    // If the command failed
                    else {
                        System.out.println("Query failed");
                    }
                }
                // Otherwise the command is a select statement
                else {
                    // Execute the command
                    ResultSet rs = JDBC.executeQuery(command);
                    // If the command was successful
                    if (rs != null) {
                        // Print the results
                        JDBC.printResults(rs);
                    }
                    else {
                        System.out.println("Query failed");
                    }
                }
            }
        }
    }

    /**
     * Pregenerated SQL commands
     * 
*             "Which service center has the most number of customers?", // Stay on page
            "What is the average price of an Evaporator Repair for Hondas across all service centers?", // Stay on page
            "Which customer(s) have unpaid invoices in Service Center 30003", // Stay on page
            "List all services that are listed as both maintenance and repair services globally", // Stay on page
            "What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?", // Stay on page"
            "What is the next eligible maintenance schedule service for the car with VIN 34KLE19D", // Stay on page

     */
    public static void adminPreGeneratedSQLCommands() {
        while (true) {
            switch (adminPreGeneratedSQLCommands.display()) {
                case 1: // Which service center has the most number of customers?
                    String query = "select SID FROM CUSTOMER GROUP BY SID HAVING count(*)=(SELECT MAX(COUNT(*)) FROM CUSTOMER GROUP BY SID)";
                    ResultSet rs = JDBC.executeQuery(query);
                    if (rs != null) {
                        // Clear the screen
                        UI.clearScreen();
                        // Print query
                        System.out.println(query);
                        // Then print the results
                        JDBC.printResults(rs);
                        // Wait for the user to press enter
                        UI.input.nextLine();
                    }
                    else {
                        adminPreGeneratedSQLCommands.setFeedback("Query failed");
                    }
                    break;
                case 2: // What is the average price of an Evaporator Repair for Hondas across all service centers?
                    query = "SELECT ROUND(AVG(price), 2) FROM Cost_Details WHERE Manf='Honda' AND serviceName='Evaporator Repair' AND serviceNumber=(select serviceNumber from Services where serviceName='Evaporator Repair' AND schedule IS NULL)";
                    rs = JDBC.executeQuery(query);
                    if (rs != null) {
                        // Clear the screen
                        UI.clearScreen();
                        // Print query
                        System.out.println(query);
                        // Then print the results
                        JDBC.printResults(rs);
                        // Wait for the user to press enter
                        UI.input.nextLine();
                    }
                    else {
                        adminPreGeneratedSQLCommands.setFeedback("Query failed");
                    }
                    break;
                case 3: // Which customer(s) have unpaid invoices in Service Center 30003
                    query = "SELECT * FROM Customer WHERE sid = 30003 AND standing = 0";
                    rs = JDBC.executeQuery(query);
                    if (rs != null) {
                        // Clear the screen
                        UI.clearScreen();
                        // Print query
                        System.out.println(query);
                        // Then print the results
                        JDBC.printResults(rs);
                        // Wait for the user to press enter
                        UI.input.nextLine();
                    }
                    else {
                        adminPreGeneratedSQLCommands.setFeedback("Query failed");
                    }
                    break;
                case 4: // List all services that are listed as both maintenance and repair services globally
                    query = "SELECT UNIQUE(serviceName) FROM Services WHERE schedule IS NOT NULL and repair_category IS NOT NULL";
                    rs = JDBC.executeQuery(query);
                    if (rs != null) {
                        // Clear the screen
                        UI.clearScreen();
                        // Print query
                        System.out.println(query);
                        // Then print the results
                        JDBC.printResults(rs);
                        // Wait for the user to press enter
                        UI.input.nextLine();
                    }
                    else {
                        adminPreGeneratedSQLCommands.setFeedback("Query failed");
                    }
                    break;
                case 5: // What is the difference between the cost of doing a belt replacement + schedule A on a Toyota at center 30001 vs 30002?
                    query = "SELECT SUM(ABS(c2.PRICE - c1.PRICE)) FROM Cost_Details c1 LEFT OUTER JOIN Cost_Details c2 ON  c1.serviceName = c2.serviceName AND c1.serviceNumber = c2.serviceNumber WHERE c1.manf = c2.manf AND c1.manf='Toyota' AND (c1.serviceName, c1.serviceNumber) IN (('A', 113), ('Belt Replacement', 101)) AND c1.sid='30001' AND c2.sid = '30002'";
                    rs = JDBC.executeQuery(query);
                    if (rs != null) {
                        // Clear the screen
                        UI.clearScreen();
                        // Print query
                        System.out.println(query);
                        // Then print the results
                        JDBC.printResults(rs);
                        // Wait for the user to press enter
                        UI.input.nextLine();
                    }
                    else {
                        adminPreGeneratedSQLCommands.setFeedback("Query failed");
                    }
                    break;
                case 6: // What is the next eligible maintenance schedule service for the car with VIN 34KLE19D
                    // A -> B -> C -> A ...
                    query = "SELECT CASE " +
                            "WHEN SCHEDULE= 'A' THEN 'B' " +
                            "WHEN SCHEDULE= 'B' THEN 'C' " +
                            "ELSE 'A' " +
                            "END AS NEXT_SCHEDULE FROM VEHICLE WHERE VIN='34KLE19D'";
                    rs = JDBC.executeQuery(query);
                    if (rs != null) {
                        // Clear the screen
                        UI.clearScreen();
                        // Print query
                        System.out.println(query);
                        // Then print the results
                        JDBC.printResults(rs);
                        // Wait for the user to press enter
                        UI.input.nextLine();
                    }
                    else {
                        adminPreGeneratedSQLCommands.setFeedback("Query failed");
                    }
                    break;
                case 7: // Return to previous menu
                    return;
            }
        }
    }


    /**************************************************************************
     * Helper Methods
     *************************************************************************/

    /**
     * Parse lines of a CSV file and return an array of strings
     */
    private static String[][] parseCSV(String filename) {
        try {
            // Read file
            File input = new File(filename);
            FileInputStream inputStream = new FileInputStream(input);
            InputStreamReader inputReader = new InputStreamReader(inputStream);
            // Arraylist for storing lines
            ArrayList<String[]> lines = new ArrayList<String[]>();
            // Open file for reading
            BufferedReader br = new BufferedReader(inputReader);
            // Read lines
            String line = br.readLine();
            // if line isn't null, skip the header row and go directly to the first content line
            if (line != null) {
                line = br.readLine();
            }
            // While there are lines to read
            while (line != null) {
                // Split line by comma (but not if comma is in quotes)
                String[] lineArray = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)", -1);
                // Add line to arraylist
                lines.add(lineArray);
                // Read next line
                line = br.readLine();
            }
            // Close the reader
            br.close();
            // Close the input reader
            inputReader.close();
            // Close the input stream
            inputStream.close();
            // Convert arraylist to array
            String[][] linesArray = lines.toArray(new String[lines.size()][]);
            // Return array
            return linesArray;
        }
        catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
}
