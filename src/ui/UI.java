package ui;

// Import Scanner
import java.util.Scanner;
// Import DB classes
import db.JDBC;
import db.query;
// Import SQL libraries
import java.sql.*;

/**
 * UI class for handling user input
 */
public class UI {

    // Scanner for user input
    public static Scanner input = new Scanner(System.in);

    // Current User
    public static String current_eid = null;
    public static String current_sid = null;
    
    /**************************************************************************
     * Menus
     *************************************************************************/

    // Home Menu
    private static menu homeMenu = new menu(
        "Welcome to the Auto Repair and Service Management System (AUTOR)", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Login", // loginMenu
            "Exit", // exit
            "Login as Admin" // adminLanding
        } // Options
    );

    // Login Menu
    private static menu loginMenu = new menu(
        "Login", // Header
        null, // Lines
        new String[] {
            "User ID",
            "Password"
        }, // Prompts
        new String[] {
            "Sign-In", // landing menu as appropriate per user type
            "Go Back" // homeMenu
        }
    );

    /**************************************************************************
     * Methods
     *************************************************************************/

    /**
     * Print the welcome menu and get user input
     */
    public static void homeMenu() {
        // Get user input until we exit
        while (true) {
            // Handle user input
            switch (homeMenu.display()) {
                // Login
                case 1:
                    loginMenu();
                    break;
                // Exit
                case 2:
                    // Close everything before exiting
                    input.close();
                    JDBC.closeDatabase();
                    // Clear the screen and print the goodbye message
                    clearScreen();
                    System.out.println("Thank you for using AUTOR. Goodbye!");
                    // Exit
                    System.exit(0);
                    break;
                // Admin options
                case 3:
                    adminUI.adminLanding();
                    break;
            }
        }
    }

    /**
     * Print the login menu and get user input
     * 
     * @throws SQLException
     */
    public static void loginMenu() {
        // Handle user input
        while (true) {
            switch (loginMenu.display()) {
                // Sign in
                case 1:
                    String[] results = query.checkCredentials(loginMenu.getPromptResponse(0), loginMenu.getPromptResponse(1));
                    // If null, the creentials are invalid
                    if (results == null) {
                        loginMenu.setFeedback("Invalid credentials");
                        break;
                    }
                   // Set eid, sid, and user type
                    setCurrentEID(results[0]);
                    setCurrentSID(results[1]);
                    String type = results[2];
                    // Go to the appropriate landing page
                    switch (type) {
                        case "customer":
                            customerUI.customerLanding();
                            break;
                        case "manager":
                            managerUI.managerLanding();
                            break;
                        case "mechanic":
                            mechanicUI.mechanicLanding();
                            break;
                        case "receptionist":
                            receptionistUI.receptionistLanding();
                            break;
                        default:
                            loginMenu.setFeedback("Invalid user type");
                            break;
                    }
                // Return to main menu
                case 2:
                homeMenu();
                    return;
            }
        }
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
            if (i % 5 == 0) {
                clearScreen();
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
     * Modified from source: https://rootstack.com/en/blog/java-clear-screen
     */
    public static void clearScreen() {
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
    }

    /**************************************************************************
     * Getters & Setters
     *************************************************************************/

    /**
     * Get the current employee ID
    */
    public static String getCurrentEID() {
        return current_eid;
    }

    /**
     * Set the current employee ID
     */
    private static void setCurrentEID(String eid) {
        current_eid = eid;
    }

    /**
     * Get the current store ID
    */
    public static String getCurrentSID() {
        return current_sid;
    }

    /**
     * Set the current store ID
     */
    private static void setCurrentSID(String sid) {
        current_sid = sid;
    }    
}
