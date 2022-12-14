package ui;

// Import DB classes
import db.receptionistQuery;

/**
 * ReceptionistUI class, UI for receptionist
 */
public class receptionistUI {
    
    /**************************************************************************
     * Menus
     *************************************************************************/

    // Receptionist: Landing
    private static menu receptionistLanding = new menu(
        "Receptionist: Landing", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Add New Customer Profile", // receptionistAddNewCustomerProfile
            "Find Customers with Pending Invoices", // receptionistFindCustomersWithPendingInvoices
            "Logout" // homeMenu
        } // Options
    );

    // Receptionist: Add New Customer Profile
    private static menu receptionistAddNewCustomerProfile = new menu(
        "Receptionist: Add New Customer Profile", // Header
        null, // Lines
        new String[] {
            "Enter the customer's first name",
            "Enter the customer's last name",
            "Enter the customer's address",
            "Enter the customer's email address",
            "Enter the customer's phone number",
            "Enter the customer's username",
            "Enter the customer's car's VIN number",
            "Enter the customer's car's manufacturer",
            "Enter the customer's car's current mileage",
            "Enter the customer's car's year"
        }, // Prompts
        new String[] {
            "Add Customer",
            "Go Back" // receptionistLanding
        } // Options
    );

    // Receptionist: Find Customers with Pending Invoices
    private static menu receptionistFindCustomersWithPendingInvoices = new menu(
        "Receptionist: Find Customers with Pending Invoices", // Header
        null, // Lines (Set in method)
        null, // Prompts
        new String[] {
            "Go Back" // receptionistLanding
        } // Options
    );

    /**************************************************************************
     * Methods
     *************************************************************************/

    /**
     * Receptionist: Landing
     */
    public static void receptionistLanding() {
        while (true) {
            switch (receptionistLanding.display()) {
                case 1: // Add New Customer Profile
                    receptionistAddNewCustomerProfile();
                    break;
                case 2: // Find Customers with Pending Invoices
                    receptionistFindCustomersWithPendingInvoices();
                    break;
                case 3: // Logout
                    UI.homeMenu();
                    return;
            }
        }
    }

    /**
     * Receptionist: Add New Customer Profile
     */
    public static void receptionistAddNewCustomerProfile() {
        while (true) {
            switch (receptionistAddNewCustomerProfile.display()) {
                case 1: // Add Customer
                    if(!receptionistQuery.addCustomer(receptionistAddNewCustomerProfile.getPromptResponses())) {
                        receptionistLanding.setFeedback("Failed to add customer profile");
                    }
                    else {
                        receptionistLanding.setFeedback("Successfully added customer profile");
                    }
                    receptionistLanding();
                    return;
                case 2: // Go Back
                    // Return to the receptionist landing page
                    receptionistLanding();
                    return;
            }
        }
    }

    /**
     * Receptionist: Find Customers with Pending Invoices
     */
    public static void receptionistFindCustomersWithPendingInvoices() {
        while (true) {
            String[] customers = receptionistQuery.getCustomersWithPendingInvoices();
            String[][] details = new String[customers.length][4];
            for (int i = 0; i < customers.length; i++) {
                details[i] = customers[i].split(",");
            }
            String[] lines;
            if (customers.length == 0) {
                lines = new String[] {"No customers with pending invoices"};
            } else {
                lines = new String[customers.length * 4];
                for (int i = 0; i < customers.length; i++) {
                    // First Last (cid)
                    lines[i * 4] = details[i][1] + " " + details[i][2] + " (" + details[i][0] + ")";
                    // Address: address
                    lines[i * 4 + 1] = "\tInvoice ID: " + details[i][3];
                    // Email: email
                    lines[i * 4 + 2] = "\tDate Generated: " + details[i][4];
                    // Phone: phone
                    lines[i * 4 + 3] = "\tTotal Amount: " + details[i][5];
                    // Add a newline to the end of total if not the last customer
                    if (i != customers.length - 1) {
                        lines[i * 4 + 3] += "\n";
                    }
                }
            }
            receptionistFindCustomersWithPendingInvoices.setLines(lines);
            switch (receptionistFindCustomersWithPendingInvoices.display()) {
                case 1: // Go Back
                    receptionistLanding();
                    return;
            }
        }
    }
}
