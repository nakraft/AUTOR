package ui;
// Import Scanner
import java.util.Scanner;

import autor.ScanHelper;
import db.JDBC;
import db.query;

// Import SQL libraries
import java.sql.*;

/**
 * UI class for handling user input
 */
public class UI {

    static Scanner input = new Scanner(System.in);

    static private String header = null;
    static private String feedback = null;
    
    /**************************************************************************
     * Main Menu and 1st Level Submenus
     *************************************************************************/

    /**
     * Print the welcome menu and get user input
     */
    public static void welcomeMenu() {
        // Reset the screen
        header = "Welcome to the Auto Repair and Service Management System (AUTOR)";
        resetScreen();
        feedback = null;
        // Print welcome message
        String userInput;
        printMenuOptions(new String[] {"Login", "Sign up", "Exit", "Admin options"});
        // Get user input until we exit
        while ((userInput = input.next()) != "3") {
            // Handle user input
            switch (userInput) {
                // Login
                case "1":
                    loginMenu();
                    break;
                // Sign up
                case "2":
                    signUp();
                    break;
                // Exit
                case "3":                  
                    input.close();
                    header = "Goodbye!";
                    feedback = null;
                    resetScreen();
                    System.out.println("Thank you for using AUTOR. Goodbye!");
                    JDBC.closeDatabase();
                    System.exit(0);
                    break;
                // Admin options
                case "4":
                    adminOptions();
                    break;
                // Invalid input
                default:
                    feedback = "Invalid input. Please try again.";
                    break;
            }
            resetScreen();
            feedback = null;
            printMenuOptions(new String[] {"Login", "Sign up", "Exit", "Admin options"});
        }
    }

    /**
     * Print the login menu and get user input
     * 
     * @throws SQLException
     */
    public static void loginMenu() {
        // Reset the screen
        header = "Login to Existing Account";
        feedback = null;
        // Handle user input
        while (true) {
            resetScreen();
            // Ask the user to input their username and password
            String[] responses = printPrompts(new String[] { "Username", "Password" });
            System.out.println();
            // Prompt the user if they would like to sign in or return to the main menu
            printMenuOptions(new String[] {"Sign in as " + responses[0], "Return to main menu"});
            switch (input.next()) {
                // Sign in
                case "1":
                    switch( query.checkCredentials( responses[0], responses[1] ) ) {
                        case "manager":
                            managerMenu( responses[0] );
                            break;
                        case "receptionist":
                            receptionistMenu( responses[0] );
                            break;
                        case "mechanic":
                            mechanicMenu( responses[0] );
                            break;
                        case "customer":
                            customerMenu( responses[0] );
                            break;
                        default:
                            System.out.println("Invalid credentials. Please try again.");
                            break;
                    }
                // Return to main menu
                case "2":
                    welcomeMenu();
                    return;
                default:
                    // Invalid input
                    System.out.println("Invalid input. Please try again.");
                    break;
            }
        }
    }
    
    /**
     * Print the sign up menu and get user input
     */
    public static void signUp() {
        // Reset the screen
        header = "Sign Up for an Account";
        feedback = null;
        resetScreen();
        // Ask the user to input their username and password
        String[] responses = printPrompts(new String[] { "Username", "Password" });
        System.out.println();
        // Prompt the user if they would like to sign up or return to the main menu
        printMenuOptions(new String[] {"Sign up as " + responses[0], "Return to main menu"});
        while (true) {
            // Handle user input
            switch (input.next()) {
                // Sign up
                case "1":
                    // Check if the username is already taken
                    if (query.findUsername(responses[0])) {
                        System.out.println("Username already taken. Please try again.");
                        signUp();
                    } else {
                        // Create the account
                        // Return to the main menu
                        welcomeMenu();
                    }
                    // If the user exists, prompt the user to try again
                    // If the user does not exist, create the user
                    break;
                // Return to main menu
                case "2":
                    welcomeMenu();
                    break;
                default:
                    // Invalid input
                    feedback = "Invalid input. Please try again.";
                    resetScreen();
                    feedback = null;
                    printMenuOptions(new String[] {"Sign up as " + responses[0], "Return to main menu"});
                    break;
            }
        }
    }

    /**
     * Administrative options
     */
    public static void adminOptions() {
        // Reset the screen
        header = "Administrative Options";
        feedback = null;
        resetScreen();
        // Print menu options with blank line after
        printMenuOptions(new String[] {"Add new store", "Add new service", "Reset Database", "Return to main menu"});
        // Handle user input
        while (true) {
            switch (input.next()) {
                // Add new store
                case "1":
                    addNewStore();
                    break;
                // Add new service
                case "2":
                    addNewService();
                    break;
                // Reset database
                case "3":
                    JDBC.resetDatabase();
                    feedback = "Database reset.";
                    welcomeMenu();
                    break;
                // Return to main menu
                case "4":
                    welcomeMenu();
                    return;
                default:
                    // Invalid input
                    feedback = "Invalid input. Please try again.";
                    resetScreen();
                    feedback = null;
                    // Print menu options with blank line after
                    printMenuOptions(new String[] {"Add new store", "Add new service", "Return to main menu"});        
                    break;
            }
        }
    }

    /**
     * Get user input for adding a new store
     */
    public static void addNewStore() {
        // Reset the screen
        header = "Add a new store";
        feedback = null;
        resetScreen();
        // Ask the user to input to add a new store
        String[] responses = printPrompts(new String[] {"Store ID","Address","Manager's first name","Manager's last name","Manager's username","Manager's password","Manager's salary","Manager's employee ID","Mechanic minimum wage","Mechanic maximum wage"});
        System.out.println();
        if (query.addStore(responses)) {
            System.out.println("Store added successfully");
        }
        else {
            System.out.println("Adding a new store failed");
        }
    }

    /**
     * Get user input for adding a new service
     */
    public static void addNewService() {
        // Reset the screen
        header = "Add a new service";
        feedback = null;
        resetScreen();
        // Ask the user to input to add a new service
        String[] responses = printPrompts(new String[] {"Service category","Service name","Duration","Manufacturer","Service number"});
        
        // raise error if category doesn't exist
        while(!query.findServiceCategory(responses[0])) {
            System.out.println("Service category doesn't exist. Please try again.");
            responses = printPrompts(new String[] {"Service category","Service name","Duration","Manufacturer","Service number"});
        }
        System.out.println();
        if (query.addService(responses)) {
            System.out.println("Service added successfully");
        }
        else {
            System.out.println("Adding a new service failed");
        }
    }

    /**************************************************************************
     * Employee/Customer Menus
     *************************************************************************/

    /**
     * Print the manager menu and get user input
     * 
     * Setup Store
     * Add Employees to Store
     * Select Operational Hours (Toggle Saturday Hours)
     * Set Up Service Prices
     * Add New Employee
     *
     * @param username The username of the manager
     */
    public static void managerMenu(String username) {
    }

    /**
     * Receptionist menu
     * 
     * Add new customer profile
     * Find customers with pending invoices
     */
    public static void receptionistMenu(String username) {
    }

    /**
     * Mechanic menu
     * 
     * View schedule
     * Request Time Off
     * Request Swap Shift
     * Accept/Reject Swap Shift
     * 
     * @param username The username of the mechanic
     */
    public static void mechanicMenu(String username) {
        int selection = 1;
        System.out.println("##################################");
        System.out.println("##### Mechanic: Landing Page #####");
        System.out.println("##################################");
        System.out.println("# 1 View schedule                #");
        System.out.println("# 2 Request time off             #");
        System.out.println("# 3 Request swap                 #");
        System.out.println("# 4 Accept / Reject swap         #");
        System.out.println("##################################");
        do {
            System.out.print("Enter choice (1-5) from the given options displayed above: ");
            selection = ScanHelper.nextInt();
        } while (!(selection >= 1 && selection <= 4));
        switch (selection) {
            case 1:
                new ViewSchedule().run();
                break;
            case 2:
                new RequestTimeOff().run();
                break;
            case 3:
                new RequestSwap().run();
                break;
            case 4:
                new AcceptRejectSwap().run();
                break;
        }
    }

    /**
     * Customer menu
     * 
     * View and Update Profile
     *  View profile
     *  Add car to profile
     *  Delete car from profile
     * View and schedule service
     *  View service history
     *  Schedule service
     * Invoices
     *  View invoice details
     *  Pay invoices
     * 
     * @param username The username of the customer
     */
    public static void customerMenu(String username) {
    }


    /**************************************************************************
     * Helper Functions
     *************************************************************************/

    /**
     * Prompt the user for multiple values
     * 
     * @param prompts array of prompts to print
     */
    public static String[] printPrompts(String[] prompts) {
        String[] responses = new String[prompts.length];
        // Print the prompts
        for (int i = 0; i < prompts.length; i++) {
            // Reprint every 5 times to avoid scrolling
            if ((i % 3 == 0 && feedback == null) || (i % 5 == 0 && feedback != null)) {
                resetScreen();
            }
            // Print the prompt
            System.out.print(prompts[i] + ": ");
            // Get the user's response
            responses[i] = input.next();
        }
        return responses;
      }

    /**
     * Print a menu with numbered options
     * 
     * @param options Array of options to print out
     */
    public static void printMenuOptions(String[] options) {
        // Prompt for user input
        System.out.println("Please select an option:");
        // Print out the separater
        System.out.println("------------------------");
        // Print out the options
        for (int i = 0; i < options.length; i++) {
            System.out.println((i + 1)+ "\t" + options[i]);
        }
        // Print out a blank line at the end
        System.out.println();
    }

    /**
     * Clears the screen (ANSI and Windows compatible)
     * Then adds a title row
     * Modified from source: https://rootstack.com/en/blog/java-clear-screen
     */
    public static void resetScreen() {
        // If the OS is Windows, use the Windows command
        if (System.getProperty("os.name").contains("Windows"))
        {
            try {
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            } catch (Exception e) {
                System.out.println("Error clearing screen");
                e.printStackTrace();
            }
        }
        // Otherwise use the ANSI command
        else
        {
            System.out.print("\033[H\033[2J");
            System.out.flush();
        }

        // Print header
        System.out.println(header);
        // Print header separator
        for (int i = 0; i < header.length(); i++) {
            System.out.print("=");
        }
        System.out.println();
        // Print feedback
        if (feedback != null) {
            System.out.println("\t" + feedback);
        }
    }
}
