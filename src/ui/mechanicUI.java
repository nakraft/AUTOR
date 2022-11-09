package ui;

// Import DB classes
import db.JDBC;
import db.mechanicQuery;
import db.query;

/**
 * MechanicUI class, UI for mechanic
 */
public class mechanicUI {
    
    /**************************************************************************
     * Menus
     *************************************************************************/

    // Mechanic: Landing
    private static menu mechanicLanding = new menu(
        "Mechanic: Landing", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "View Schedule", // mechanicViewSchedule
            "Request Time Off", // mechanicRequestTimeOff
            "Request Swap", // mechanicRequestSwap
            "Accept/Reject Swap", // mechanicAcceptRejectSwap
            "Logout" // homeMenu
        } // Options
    );

    // Mechanic: View Schedule
    private static menu mechanicViewSchedule = new menu(
        "Mechanic: View Schedule", // Header
        null, // Lines (set in method)
        null, // Prompts
        new String[] {
            "Go Back" // mechanicLanding
        } // Options
    );

    // Mechanic: Request Time Off
    private static menu mechanicRequestTimeOff = new menu(
        "Mechanic: Request Time Off", // Header
        null, // Lines
        new String[] {
            "Enter the Week ID",
            "Enter the Day ID",
            "Enter the Start Time ID",
            "Enter the End Time ID"
        }, // Prompts
        new String[] {
            "Send Request", // Display status of request, stay on page
            "Go Back" // mechanicLanding
        } // Options
    );

    // Mechanic: Request Swap
    private static menu mechanicRequestSwap = new menu(
        "Mechanic: Request Swap", // Header
        null, // Lines
        new String[] {
            "Enter the Mechanic EID of the mechanic you want to swap with",
            "Enter the Week ID to swap",
            "Enter the Day ID to swap",
            "Enter the Start Time ID",
            "Enter the End Time ID",
            "Enter the Week ID to swap",
            "Enter the Day ID to swap",
            "Enter the Start Time ID",
            "Enter the End Time ID"
        }, // Prompts
        new String[] {
            "Send Request", // Display status of request, stay on page
            "Go Back" // mechanicLanding
        } // Options
    );

    // Mechanic: Accept/Reject Swap
    private static menu mechanicAcceptRejectSwap = new menu(
        "Mechanic: Accept/Reject Swap", // Header
        null, // Lines (set in method)
        null, // Prompts
        new String[] {
            "Manage Swap Requests", // mechanicManageSwapRequests
            "Go Back" // mechanicLanding
        } // Options
    );

    // Mechanic: Manage Swap Requests
    private static menu mechanicManageSwapRequests = new menu(
        "Mechanic: Manage Swap Requests", // Header
        null, // Lines
        new String[] {
            "Enter the Swap Request ID"
        }, // Prompts
        new String[] {
            "Accept Swap Request", // show output, mechanicAcceptRejectSwap
            "Reject Swap Request", // show output, mechanicAcceptRejectSwap
            "Go Back" // mechanicAcceptRejectSwap
        } // Options
    );

    /**************************************************************************
     * Methods
     *************************************************************************/

    /**
     * Mechanic: Landing
     */
    public static void mechanicLanding() {
        while (true) {
            // Display menu
            switch (mechanicLanding.display()) {
                case 1: // View Schedule
                    mechanicViewSchedule();
                    break;
                case 2: // Request Time Off
                    mechanicRequestTimeOff();
                    break;
                case 3: // Request Swap
                    mechanicRequestSwap();
                    break;
                case 4: // Accept/Reject Swap
                    mechanicAcceptRejectSwap();
                    break;
                case 5: // Logout
                    UI.homeMenu();
                    break;
            }
        }
    }

    /**
     * Mechanic: View Schedule
     */
    public static void mechanicViewSchedule() {
        // TODO: Query database for schedule
        // TODO: Set lines
        while (true) {
            String[] output = mechanicQuery.ViewSchedule();
            if(output == null){
                System.out.println("No schedule found");
            }
            mechanicViewSchedule.setLines(output);
            // Display menu
          
            switch (mechanicViewSchedule.display()) {
                case 1: // Go Back
                    mechanicLanding();
                    break;
            }
        }
    }

    /**
     * Mechanic: Request Time Off
     */
    public static void mechanicRequestTimeOff() {
        while (true) {
            // Display menu
          
            switch (mechanicRequestTimeOff.display()) {
                case 1: // Send Request
                    // TODO: Send request to database
                    // TODO: Display status of request
                    String[] output = mechanicQuery.RequestedTimeOff(mechanicRequestTimeOff.getPromptResponses());
                    String[] lines = new String[1];        
                    if(output == null){
                        mechanicRequestTimeOff.setLines(lines);
                    }else{
                        mechanicRequestTimeOff.setLines(output);
                    }
                   
                    break;
                case 2: // Go Back
                    mechanicLanding();
                    return;
            }
        }
    }

    /**
     * Mechanic: Request Swap
     */
    public static void mechanicRequestSwap() {
        while (true) {
            // Display menu
            switch (mechanicRequestSwap.display()) {
                case 1: // Send Request
                String[] output = mechanicQuery.RequestedSwap(mechanicRequestSwap.getPromptResponses());  
                mechanicRequestTimeOff.setLines(output);
                    break;
                case 2: // Go Back
                    mechanicLanding();
                    return;
            }
        }
    }

    /**
     * Mechanic: Accept/Reject Swap
     */
    public static void mechanicAcceptRejectSwap() {
        while (true) {
            // TODO: Query database for swap requests
            // TODO: Set lines
            // Display menu
            String[] output = mechanicQuery.ManageSwapRequests();
            mechanicRequestTimeOff.setLines(output);
            switch (mechanicManageSwapRequests.display()) {
                case 1: // Manage Swap Requests
                    break;
                case 2: // Go Back
                    mechanicLanding();
                    return;
            }
        }
    }

    /**
     * Mechanic: Manage Swap Requests
     */
    public static void mechanicManageSwapRequests() {
        while (true) {
            // Display menu
            switch (mechanicManageSwapRequests.display()) {
                case 1: // Accept Swap Request
                    // TODO: Accept swap request
                    // TODO: Display status of request
                    String[] output = mechanicQuery.ManageSwapRequests();
                    mechanicRequestTimeOff.setLines(output);
                    break;
                case 2: // Reject Swap Request
                    // TODO: Reject swap request
                    // TODO: Display status of request
                    break;
                case 3: // Go Back
                    mechanicAcceptRejectSwap();
                    return;
            }
        }
    }
}
