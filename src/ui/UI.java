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

    // Current Store for the user
    public static int currentStore = 0;
    // Current User
    public static String currentUser = null;
    
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
                    switch( query.checkCredentials(loginMenu.getPromptResponse(0), loginMenu.getPromptResponse(1)) ) {
                        case "manager":
                            currentUser = loginMenu.getPromptResponse(0);
                            managerUI.managerLanding();
                            break;
                        case "receptionist":
                            currentUser = loginMenu.getPromptResponse(0);
                            receptionistUI.receptionistLanding();
                            break;
                        case "mechanic":
                            currentUser = loginMenu.getPromptResponse(0);
                            mechanicUI.mechanicLanding();
                            break;
                        case "customer":
                            currentUser = loginMenu.getPromptResponse(0);
                            customerUI.customerLanding();
                            break;
                        default:
                            // Invalid credentials
                            System.out.println("Invalid credentials. Please try again.");
                            // Wait for user to press enter
                            input.nextLine();
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
}
