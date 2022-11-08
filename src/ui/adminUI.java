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
            "Reset Database (Standard)", // JDBC.resetDatabase()
            "Reset Database (Full Population)", // JDBC.resetDatabaseFull()
            "Run SQL Commands" // adminRunSQLCommands
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
            "Enter the maximum mechanic wage" // 9
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
            "Enter service duration",
            "Enter manufacturer"
        }, // Prompts
        new String[] {
            "Add Service", // remain, addService
            "Go Back" // adminLanding
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
                case 5: // Reset Database
                    JDBC.resetDatabase();
                    adminLanding.setFeedback("Database reset and populated with standard data");
                    break;
                case 6: // Reset Database Full
                    JDBC.resetDatabaseFull();
                    adminLanding.setFeedback("Database reset and popuplated with full data");
                    break;
                case 7: // Run SQL Commands
                    adminRunSQLCommands();
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
                        System.out.println("Store added successfully");
                    }
                    else {
                        System.out.println("Adding a new store failed");
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
                // Return to the admin landing page
                adminLanding();
            }
            else {
                // If the command is an update
                if (command.toLowerCase().startsWith("update")) {
                    // If the update was successful
                    if (JDBC.executeUpdate(command)) {
                        System.out.println("Update successful");
                    }
                    else {
                        System.out.println("Update failed");
                    }
                }
                // Otherwise the command is a query
                else {
                    ResultSet results = JDBC.executeQuery(command);
                    // Print the results
                    if (results != null) {
                        JDBC.printResults(results);
                    }
                    else {
                        System.out.println("Query failed");
                    }
                }
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
