package ui;

// Import DB classes
import db.query;
import db.JDBC;
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
            "Reset Database" // JDBC.resetDatabase()
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
            "Enter the store ID",
            "Enter the store address",
            "Enter the manager's first name",
            "Enter the manager's last name",
            "Enter the manager's username",
            "Enter the manager's password",
            "Enter the manager's salary",
            "Enter the manager's employee ID",
            "Enter the minimum mechanic wage",
            "Enter the maximum mechanic wage"
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
                    adminLanding.setFeedback("Database reset successfully");
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
                            // TODO: add service to database
                            // query.addService(serviceInfo[i][0], serviceInfo[i][1], serviceInfo[i][2]);
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
                            // TODO: add store to database
                           //  query.addStore(storeInfo[i][0], storeInfo[i][1], storeInfo[i][2], storeInfo[i][3], storeInfo[i][4], storeInfo[i][5], storeInfo[i][6], storeInfo[i][7], storeInfo[i][8], storeInfo[i][9]);
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
                    if (query.addStore(adminAddNewStore.getPromptResponses())) {
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
                    if(!query.validateRepairCategory(adminAddNewService.getPromptResponse(0))) {
                        adminAddNewService.setFeedback("Service category doesn't exist. Please try again.");
                        break;
                    }
                    if (query.addService(adminAddNewService.getPromptResponses())) {
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
