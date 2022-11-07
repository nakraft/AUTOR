package ui;

// Import DB classes
import db.JDBC;
import db.query;

/**
 * ManagerUI class, UI for manager
 */
public class managerUI {
    
    /**************************************************************************
     * Menus
     *************************************************************************/

    // Manager: Landing
    private static menu managerLanding = new menu(
        "Manager: Landing", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Setup Store", // managerSetupStore
            "Add New Employee", // managerAddEmployees
            "Logout" // homeMenu
        } // Options
    );

    // Manager: Setup Store
    private static menu managerSetupStore = new menu(
        "Manager: Setup Store", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Add Employees", // managerAddEmployees
            "Setup Operational Hours", // managerSetupOperationalHours
            "Setup service prices", // managerSetupServicePrices
            "Go Back" // managerLanding
        } // Options
    );

    // Manager: Add Employees
    private static menu managerAddEmployees = new menu(
        "Manager: Add Employees", // Header
        null, // Lines
        new String[] {
            // TODO: figure out if name is stored as first/last or full name
            "Enter the employee's first name",
            "Enter the employee's last name",
            "Enter the employee's email address",
            "Enter the employee's phone number",
            "Enter the employee's role",
            "Enter the employee's start date",
            "Enter the employee's compensation"
        }, // Prompts
        new String[] {
            "Add Employee", // display EID for new employee, then return to managerSetupStore
            "Go Back" // managerSetupStore
        } // Options
    );

    // Manager: Setup Operational Hours
    private static menu managerSetupOperationalHours = new menu(
        "Manager: Setup Operational Hours", // Header
        null, // Lines
        new String[] {
            "Operational on Saturdays (Y/N)"
        }, // Prompts
        new String[] {
            "Setup Operational Hours", // set hours, then go to managerSetupStore
            "Go Back" // managerSetupStore
        } // Options
    );

    // Manager: Setup Service Prices
    private static menu managerSetupServicePrices = new menu(
        "Manager: Setup Service Prices", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Setup Maintenance Service Prices", // managerSetupMaintenanceServicePrices
            "Setup Repair Service Prices", // managerSetupRepairServicePrices
            "Go Back" // managerSetupStore
        } // Options
    );

    // Manager: Setup Maintenance Service Prices
    private static menu managerSetupMaintenanceServicePrices = new menu(
        "Manager: Setup Maintenance Service Prices", // Header
        null, // Lines
        new String[] {
            "Schedule A Price",
            "Schedule B Price",
            "Schedule C Price"
        }, // Prompts
        new String[] {
            "Setup Prices", // set prices, then go to managerSetupServicePrices
            "Go Back" // managerSetupServicePrices
        } // Options
    );

    // Manager: Setup Repair Service Prices
    private static menu managerSetupRepairServicePrices = new menu(
        "Manager: Setup Repair Service Prices", // Header
        null, // Lines
        null, // Prompts (every service, set in method)
        new String[] {
            "Setup Prices", // set prices, then go to managerSetupServicePrices
            "Go Back" // managerSetupServicePrices
        } // Options
    );

    /**************************************************************************
     * Methods
     *************************************************************************/

    /**
     * Manager: Landing
     */
    public static void managerLanding() {
        while (true) {
            switch (managerLanding.display()) {
                case 1: // Setup Store
                    managerSetupStore();
                    break;
                case 2: // Add New Employee
                    // TODO: figure out if duplicate add employee flow?
                    managerAddEmployees();
                    break;
                case 3: // Logout
                    UI.homeMenu();
                    return;
            }
        }
    }

    /**
     * Manager: Setup Store
     */
    public static void managerSetupStore() {
        while (true) {
            switch (managerSetupStore.display()) {
                case 1: // Add Employees
                    managerAddEmployees();
                    break;
                case 2: // Setup Operational Hours
                    managerSetupOperationalHours();
                    break;
                case 3: // Setup Service Prices
                    managerSetupServicePrices();
                    break;
                case 4: // Go Back
                    managerLanding();
                    return;
            }
        }
    }

    /**
     * Manager: Add Employees
     */
    public static void managerAddEmployees() {
        while (true) {
            switch (managerAddEmployees.display()) {
                case 1: // Add Employee
                    // TODO: add employee to the database
                    // TODO: print out EID for new employee
                    managerSetupStore();
                    return;
                case 2: // Go Back
                    managerSetupStore();
                    return;
            }
        }
    }

    /**
     * Manager: Setup Operational Hours
     */
    public static void managerSetupOperationalHours() {
        while (true) {
            switch (managerSetupOperationalHours.display()) {
                case 1: // Setup Operational Hours
                    // TODO: set operational hours in database
                    managerSetupStore();
                    return;
                case 2: // Go Back
                    managerSetupStore();
                    return;
            }
        }
    }

    /**
     * Manager: Setup Service Prices
     */
    public static void managerSetupServicePrices() {
        while (true) {
            switch (managerSetupServicePrices.display()) {
                case 1: // Setup Maintenance Service Prices
                    managerSetupMaintenanceServicePrices();
                    break;
                case 2: // Setup Repair Service Prices
                    managerSetupRepairServicePrices();
                    break;
                case 3: // Go Back
                    managerSetupStore();
                    return;
            }
        }
    }

    /**
     * Manager: Setup Maintenance Service Prices
     */
    public static void managerSetupMaintenanceServicePrices() {
        while (true) {
            switch (managerSetupMaintenanceServicePrices.display()) {
                case 1: // Setup Prices
                    // TODO: set schedule A price in database
                    // TODO: set schedule B price in database
                    // TODO: set schedule C price in database
                    managerSetupServicePrices();
                    return;
                case 2: // Go Back
                    managerSetupServicePrices();
                    return;
            }
        }
    }

    /**
     * Manager: Setup Repair Service Prices
     */
    public static void managerSetupRepairServicePrices() {
        // TODO: get list of services from database
        // TODO: set prompts for each service
        while (true) {
            switch (managerSetupRepairServicePrices.display()) {
                case 1: // Setup Prices
                    // TODO: set prices for each service in database
                    managerSetupServicePrices();
                    return;
                case 2: // Go Back
                    managerSetupServicePrices();
                    return;
            }
        }
    }
}
