package ui;

// Import DB classes
import db.customerQuery;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

/**
 * CustomerUI class, UI for customer
 */
public class customerUI {
    
    /**************************************************************************
     * Menus
     *************************************************************************/

    // Customer: Landing
    static HashSet<String> cart = new HashSet<String>();
    static HashMap<String, String> serviceMapping = new HashMap<>();
    private static menu customerLanding = new menu(
        "Customer: Landing", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "View and Update Profile", // customerViewUpdateProfile
            "View and Schedule Service", // customerViewScheduleService
            "Invoices", // customerInvoices
            "Logout" // homeMenu
        } // Options
    );

    // Customer: View and Update Profile
    private static menu customerViewUpdateProfile = new menu(
        "Customer: View and Update Profile", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "View Profile", // customerViewProfile
            "Add Car", // customerAddCar
            "Delete Car", // customerDeleteCar
            "Go Back" // customerLanding
        } // Options
    );

    // Customer: View Profile
    private static menu customerViewProfile = new menu(
        "Customer: View Profile", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Go Back" // customerViewUpdateProfile
        } // Options
    );

    // Customer: Add Car
    private static menu customerAddCar = new menu(
        "Customer: Add Car", // Header
        null, // Lines
        new String[] {
            "Enter the car's VIN",
            "Enter the car manufacturer",
            "Enter the car's mileage",
            "Enter the car's year"
        }, // Prompts
        new String[] {
            "Save Information", // customerLanding
            "Cancel" // customerLanding
        } // Options
    );

    // Customer: Delete Car
    private static menu customerDeleteCar = new menu(
        "Customer: Delete Car", // Header
        null, // Lines (Populated with cars in method)
        new String[] {
            "Enter the car's VIN"
        }, // Prompts
        new String[] {
            "Delete Car", // customerLanding
            "Cancel" // customerLanding
        } // Options
    );

    // Customer: View and Schedule Service
    private static menu customerViewScheduleService = new menu(
        "Customer: View and Schedule Service", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "View Service History", // customerViewServiceHistory
            "Schedule Service", // customerScheduleService
            "Go Back" // customerLanding
        } // Options
    );

    // Customer: View Service History
    private static menu customerViewServiceHistory = new menu(
        "Customer: View Service History", // Header
        null, // Lines
        new String[] {
            "Enter the car's VIN"
        }, // Prompts
        new String[] {
            "Show History", // remain, show service history
            "Go Back" // customerViewScheduleService
        } // Options
    );

    // Customer: Schedule Service  
    private static menu customerScheduleService = new menu(
        "Customer: Schedule Service", // Header
        null, // Lines
        new String[] {
            "Enter the car's VIN",
            "Enter the car's current mileage"
        }, // Prompts
        new String[] {
            "Add Scheduled Maintenance", // customerScheduledMaintenance
            "Add Scheduled Repair", // customerScheduledRepair
            "View Cart and Select Schedule Time", // customerViewCartSelectScheduleTime
            "Go Back" // customerViewScheduleService
        } // Options
    );

    // Customer: Add Scheduled Maintenance
    private static menu customerScheduledMaintenance = new menu(
        "Customer: Add Scheduled Maintenance", // Header
        null, // Lines (Populated with eligible service in method)
        null, // Prompts
        new String[] {
            "Accept - Add to Cart", // customerScheduleService
            "Decline - Go Back" // customerScheduleService
        } // Options
    );

    // Customer: Add Scheduled Repair
    private static menu customerScheduledRepair = new menu(
        "Customer: Add Scheduled Repair", // Header
        null, // Lines (Populated with eligible service in method)
        null, // Prompts
        new String[] {
            "Engine Services", // customerEngineServices
            "Exhaust Services", // customerExhaustServices
            "Electrical Services", // customerElectricalServices
            "Transmission Services", // customerTransmissionServices
            "Tire Services", // customerTireServices
            "Heating and AC Services", // customerHeatingACServices
            "Go Back" // customerScheduleService
        } // Options
    );

    // Customer: Engine Services
    private static menu customerEngineServices = new menu(
        "Customer: Engine Services", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with eligible service in method)
    );

    // Customer: Exhaust Services
    private static menu customerExhaustServices = new menu(
        "Customer: Exhaust Services", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with eligible service in method)
    );

    // Customer: Electrical Services
    private static menu customerElectricalServices = new menu(
        "Customer: Electrical Services", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with eligible service in method)
    );

    // Customer: Transmission Services
    private static menu customerTransmissionServices = new menu(
        "Customer: Transmission Services", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with eligible service in method)
    );

    // Customer: Tire Services
    private static menu customerTireServices = new menu(
        "Customer: Tire Services", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with eligible service in method)
    );

    // Customer: Heating and AC Services
    private static menu customerHeatingACServices = new menu(
        "Customer: Heating and AC Services", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with eligible service in method)
    );

    // Customer: View Cart and Select Schedule Time
    private static menu customerViewCartSelectScheduleTime = new menu(
        "Customer: View Cart and Select Schedule Time", // Header
        null, // Lines (Populated with cart in method)
        null, // Prompts
        new String[] {
            "Proceed with Scheduling", // customerScheduleServicesInCart
            "Go Back" // customerScheduleService
        } // Options
    );

    // Customer: Schedule Services in Cart
    private static menu customerScheduleServicesInCart = new menu(
        "Customer: Schedule Services in Cart", // Header
        null, // Lines
        null, // Prompts
        null // Options (Populated with available times in method)
    );

    // Customer: Invoices
    private static menu customerInvoices = new menu(
        "Customer: Invoices", // Header
        null, // Lines (Populated with invoices in method)
        null, // Prompts
        new String[] {
            "View Invoice Details", // customerViewInvoiceDetails
            "Pay Invoice", // customerPayInvoice
            "Go Back" // customerLanding
        } // Options
    );

    // Customer: View Invoice Details
    private static menu customerViewInvoiceDetails = new menu(
        "Customer: View Invoice Details", // Header
        null, // Lines
        new String[] {
            "Enter the invoice ID"
        }, // Prompts
        new String[] {
            "View Invoice", // remain, show invoice details
            "Go Back" // customerInvoices
        } // Options
    );

    // Customer: Pay Invoice
    private static menu customerPayInvoice = new menu(
        "Customer: Pay Invoice", // Header
        null, // Lines
        new String[] {
            "Enter the invoice ID"
        }, // Prompts
        new String[] {
            "Pay Invoice", // remain, pay invoice
            "Go Back" // customerInvoices
        } // Options
    );

    /**************************************************************************
     * Methods
     *************************************************************************/

    /**
     * Customer Landing
     */
    public static void customerLanding() {
        while (true) {
            // Display menu
            switch( customerLanding.display() ) {
                case 1: // View and Update Profile
                    customerViewUpdateProfile();
                    break;
                case 2: // View and Schedule Service
                    customerViewScheduleService();
                    break;
                case 3: // Invoices
                    customerInvoices();
                    break;
                case 4: // Logout
                    return;
            }
        }
    }

    /**
     * Customer: View and Update Profile
     */
    public static void customerViewUpdateProfile() {
        while (true) {
            // Display menu
            switch( customerViewUpdateProfile.display() ) {
                case 1: // View Profile
                    customerViewProfile();
                    break;
                case 2: // Add Car
                    customerAddCar();
                    break;
                case 3: // Delete Car
                    customerDeleteCar();
                    break;
                case 4: // Go Back
                    customerLanding();
                    break;
            }
        }
    }

    /**
     * Customer: View Profile
     */
    public static void customerViewProfile() {
        // Query database for customer profile
        String[] profile = customerQuery.getProfile();
        // Query database for cars owned by customer
        String[][] cars = customerQuery.getVehicles();
        // Create a new String array with the profile, then all cars
        String[] lines;
        if (cars != null) {
        lines = new String[profile.length + cars.length * cars[0].length];}
        else {
            lines = new String[profile.length];
        }
        // Customer ID:
        lines[0] = "Customer ID: " + profile[0];
        // Full Name:
        lines[1] = "Full Name: " + profile[1];
        // Address:
        lines[2] = "Address: " + profile[2];
        // Email Address:
        lines[3] = "Email Address: " + profile[3];
        // Phone Number:
        lines[4] = "Phone Number: " + profile[4];
        if (cars != null) {
        for (int i = 0; i < cars.length; i++) {
            // Vehicle i VIN:
            lines[profile.length + i * cars[0].length] = "Vehicle " + (i + 1) + " VIN: " + cars[i][0];
            // Vehicle i Manufacturer:
            lines[profile.length + i * cars[0].length + 1] = "Vehicle " + (i + 1) + " Manufacturer: " + cars[i][1];
            // Vehicle i Mileage:
            lines[profile.length + i * cars[0].length + 2] = "Vehicle " + (i + 1) + " Mileage: " + cars[i][2];
            // Vehicle i Year:
            lines[profile.length + i * cars[0].length + 3] = "Vehicle " + (i + 1) + " Year: " + cars[i][3];
        }
    }
        // Set menu lines to the new String array
        customerViewProfile.setLines(lines);
        // Display profile
        customerViewProfile.display();
        // Return to previous menu
        // (Only option to escape display is to enter 1)
        customerViewUpdateProfile();
    }

    /**
     * Customer: Add Car
     */
    public static void customerAddCar() {
        while (true) {
            // Display menu
            switch( customerAddCar.display() ) {
                case 1: // Add Car
                    customerQuery.addVehicle(customerAddCar.getPromptResponses());
                    break;
                case 2: // Go Back
                    customerLanding();
                    break;
            }
        }
    }

    /**
     * Customer: Delete Car
     */
    public static void customerDeleteCar() {
        while (true) {
            // Display menu
            switch( customerDeleteCar.display() ) {
                case 1: // Delete Car
                    customerQuery.deleteVehicle(customerDeleteCar.getPromptResponses()[0]);
                    break;
                case 2: // Go Back
                    customerLanding();
                    break;
            }
        }
    }

    /**
     * Customer: View and Schedule Service
     */
    public static void customerViewScheduleService() {
        while (true) {
            // Display menu
            switch( customerViewScheduleService.display() ) {
                case 1: // View Service History
                    customerViewServiceHistory();
                    break;
                case 2: // Schedule Service
                    customerScheduleService();
                    break;
                case 3: // Go Back
                    customerLanding();
                    break;
            }
        }
    }

    /**
     * Customer: View Service History
     */ 
    public static void customerViewServiceHistory() {
        while (true) {
            // Display menu
            switch( customerViewServiceHistory.display() ) {
                case 1: // View Service History
                    // TODO: Query database for service history
                    // TODO: Output service history
                    
                    break;
                case 2: // Go Back
                    customerViewScheduleService();
                    break;
            }
        }
    }

    /**
     * Customer: Schedule Service
     */
    public static void customerScheduleService() {
        while (true) {
            // Display menu
            switch( customerScheduleService.display() ) {
                case 1: // Add Scheduled Maintenance
                    displayScheduledMaintenance(customerScheduleService.getPromptResponses()[0]);
                    break;
                case 2: // Add Scheduled Repair
                    customerScheduledRepair();
                    break;
                case 3: // View Cart and Select Schedule Time
                    customerViewCartSelectScheduleTime();
                    break;
                case 4: // Go Back
                    customerViewScheduleService();
                    break;
            }
        }
    }

    /**
     * Customer: Add Scheduled Maintenance
     */
    // public static void customerScheduledMaintenance(String Vin) {
    //     while (true) {
    //         // Display menu
    //         switch( customerScheduledMaintenance.display() ) {
    //             case 1: // Accept scheduled maintenance
    //                 displayScheduledMaintenance(Vin);
    //                 // TODO: Add scheduled maintenance to cart
    //                 break;
    //             case 2: // Go Back
    //                 customerScheduleService();
    //                 break;
    //         }
    //     }
    // }

    public static void displayScheduledMaintenance(String Vin) {
        //4Y1BL658
        // Query database for customer profile
        String[] eligibleMaintenance = customerQuery.getEligibleMaintenance(Vin);
        serviceMapping.put(eligibleMaintenance[0], eligibleMaintenance[1]);
        String scheduleCost = customerQuery.getScheduleCost(eligibleMaintenance[0], eligibleMaintenance[1], Vin);
        String[] temp = new String[2];
        temp[0] = "Eligible Schedule : " + eligibleMaintenance[0] + ", Cost : " + scheduleCost + " (Add to Cart)";
        temp[1] = "Go back";
        customerScheduledMaintenance.setOptions(temp);
        while (true) {
            // Display menu
            customerScheduledMaintenance.display();
            // if option is the last option, go back
            int response = customerScheduledMaintenance.getMenuResponse();
            if ( response == customerScheduledMaintenance.getOptions().length) {
                customerViewScheduleService();
            }
            // else, add service to cart
            else {
                cart.add(eligibleMaintenance[0]);
            }
        }
        // display the next eligible maintenance and cost, allow user to add it to cart
        // Query database for cars owned by customer

    }

    /**
     * Customer: Schedule Repair
     */
    public static void customerScheduledRepair() {
        while (true) {
            // Display menu
            switch( customerScheduledRepair.display() ) {
                case 1: // Engine Services
                    customerEngineServices();
                    break;
                case 2: // Exhaust Services
                    customerExhaustServices();
                    break;
                case 3: // Electrical Services
                    customerElectricalServices();
                    break;
                case 4: // Transmission Services
                    customerTransmissionServices();
                    break;
                case 5: // Tire Services
                    customerTireServices();
                    break;
                case 6: // Heating and AC Services
                    customerHeatingACServices();
                    break;
                case 7: // Go Back
                    customerViewScheduleService();
                    break;                
            }
        }
    }

    /**
     * Customer: Engine Services
     */
    public static void customerEngineServices() {
        // TODO: update menu options with eligible services and "Go Back"
          //4Y1BL658
        ArrayList<String[]> engineRepairService = customerQuery.getServicesForCategory("Engine Services");
        String[] serviceNames = new String[engineRepairService.size()+1];
        for (int i = 0; i < engineRepairService.size(); i++) {
            serviceNames[i] = engineRepairService.get(i)[0];
            serviceMapping.put(engineRepairService.get(i)[0], engineRepairService.get(i)[1]);
        }
        serviceNames[engineRepairService.size()] = "Go Back";
        customerEngineServices.setOptions(serviceNames);  
        

        while (true) {
            // Display menu
            customerEngineServices.display();
            // if option is the last option, go back
            int response = customerEngineServices.getMenuResponse();
            if ( response == customerEngineServices.getOptions().length) {
                customerScheduledRepair();
            }
            // else, add service to cart
            else {
                cart.add(engineRepairService.get(response-1)[0]);
                // Iterator<String> it = cart.iterator();
                // while (it.hasNext()) {
                //     // Print HashSet values
                //     System.out.print(it.next() + " ");
                // }
                //String a = UI.input.nextLine();

                
                // TODO: add service to cart
            }
        }
    }

    /**
     * Customer: Exhaust Services
     */
    public static void customerExhaustServices() {
        // TODO: update menu options with eligible services and "Go Back"
        ArrayList<String[]> repairService = customerQuery.getServicesForCategory("Exhaust Services");
        String[] serviceNames = new String[repairService.size()+1];
        for (int i = 0; i < repairService.size(); i++) {
            serviceNames[i] = repairService.get(i)[0];
            serviceMapping.put(repairService.get(i)[0], repairService.get(i)[1]);
        }
        serviceNames[repairService.size()] = "Go Back";
        customerExhaustServices.setOptions(serviceNames);  
        // String a = UI.input.nextLine();

        while (true) {
            // Display menu
            customerExhaustServices.display();
            // if option is the last option, go back
            int response = customerExhaustServices.getMenuResponse();
            if ( response == customerExhaustServices.getOptions().length) {
                customerScheduledRepair();
            }
            // else, add service to cart
            else {
                cart.add(repairService.get(response-1)[0]);
            }
        }
    }

    /**
     * Customer: Electrical Services
     */
    public static void customerElectricalServices() {
        // TODO: update menu options with eligible services and "Go Back"
        ArrayList<String[]> repairService = customerQuery.getServicesForCategory("Electrical Services");
        String[] serviceNames = new String[repairService.size()+1];
        for (int i = 0; i < repairService.size(); i++) {
            serviceNames[i] = repairService.get(i)[0];
            serviceMapping.put(repairService.get(i)[0], repairService.get(i)[1]);
        }
        serviceNames[repairService.size()] = "Go Back";
        customerElectricalServices.setOptions(serviceNames);  
        while (true) {
            // Display menu
            customerElectricalServices.display();
            // if option is the last option, go back
            int response = customerElectricalServices.getMenuResponse();
            if ( response == customerElectricalServices.getOptions().length) {
                customerScheduledRepair();
            }
            // else, add service to cart
            else {
                cart.add(repairService.get(response-1)[0]);
            }
        }
    }

    /**
     * Customer: Transmission Services
     */
    public static void customerTransmissionServices() {
        // TODO: update menu options with eligible services and "Go Back"
        ArrayList<String[]> repairService = customerQuery.getServicesForCategory("Transmission Services");
        String[] serviceNames = new String[repairService.size()+1];
        for (int i = 0; i < repairService.size(); i++) {
            serviceNames[i] = repairService.get(i)[0];
            serviceMapping.put(repairService.get(i)[0], repairService.get(i)[1]);
        }
        serviceNames[repairService.size()] = "Go Back";
        customerTransmissionServices.setOptions(serviceNames);  
        while (true) {
            // Display menu
            customerTransmissionServices.display();
            // if option is the last option, go back
            int response = customerTransmissionServices.getMenuResponse();
            if ( response == customerTransmissionServices.getOptions().length) {
                customerScheduledRepair();
            }
            // else, add service to cart
            else {
                cart.add(repairService.get(response-1)[0]);
            }
        }
    }

    /**
     * Customer: Tire Services
     */
    public static void customerTireServices() {
        // TODO: update menu options with eligible services and "Go Back"
        ArrayList<String[]> repairService = customerQuery.getServicesForCategory("Tire Services");
        String[] serviceNames = new String[repairService.size()+1];
        for (int i = 0; i < repairService.size(); i++) {
            serviceNames[i] = repairService.get(i)[0];
            serviceMapping.put(repairService.get(i)[0], repairService.get(i)[1]);
        }
        serviceNames[repairService.size()] = "Go Back";
        customerTireServices.setOptions(serviceNames);  
        while (true) {
            // Display menu
            customerTireServices.display();
            // if option is the last option, go back
            int response = customerTireServices.getMenuResponse();
            if ( response == customerTireServices.getOptions().length) {
                customerScheduledRepair();
            }
            // else, add service to cart
            else {
                cart.add(repairService.get(response-1)[0]);
            }
        }
    }

    /**
     * Customer: Heating and AC Services
     */
    public static void customerHeatingACServices() {
        // TODO: update menu options with eligible services and "Go Back"
        ArrayList<String[]> repairService = customerQuery.getServicesForCategory("Heating and A/C Services");
        String[] serviceNames = new String[repairService.size()+1];
        for (int i = 0; i < repairService.size(); i++) {
            serviceNames[i] = repairService.get(i)[0];
            serviceMapping.put(repairService.get(i)[0], repairService.get(i)[1]);
        }
        serviceNames[repairService.size()] = "Go Back";
        customerHeatingACServices.setOptions(serviceNames);  
        while (true) {
            // Display menu
            customerHeatingACServices.display();
            // if option is the last option, go back
            int response = customerHeatingACServices.getMenuResponse();
            if ( response == customerHeatingACServices.getOptions().length) {
                customerScheduledRepair();
            }
            // else, add service to cart
            else {
                cart.add(repairService.get(response-1)[0]);
            }
        }
    }

    /**
     * Customer: View Cart and Select Schedule Time
     */
    public static void customerViewCartSelectScheduleTime() {
        while (true) {
            // Display menu
            switch( customerViewCartSelectScheduleTime.display() ) {
                case 1: // Proceed with Scheduling
                    customerScheduleServicesInCart();
                    break;
                case 2: // Go Back
                    customerScheduleService();
                    break;
            }
        }
    }

    /**
     * Customer: Schedule Services in Cart
     */
    public static void customerScheduleServicesInCart() {
        // TODO: update menu options with available times
        while (true) {
            // Display menu

            customerScheduleServicesInCart.display();
            // TODO: generate new invoice with selected services and time
            // return to customer landing
            customerLanding();
        }
    }

    /**
     * Customer: Invoices
     */
    public static void customerInvoices() {
        while (true) {
            // Display menu
            switch( customerInvoices.display() ) {
                case 1: // View Invoice Details
                    customerViewInvoiceDetails();
                    break;
                case 2: // Pay Invoice
                    customerPayInvoice();
                    break;
                case 3: // Go Back
                    customerLanding();
                    break;
            }
        }
    }

    /**
     * Customer: View Invoice Details
     */
    public static void customerViewInvoiceDetails() {
        while (true) {
            // Display menu
            switch( customerViewInvoiceDetails.display() ) {
                case 1: // View Invoice
                    // TODO: query database for invoice details
                    // TODO: output invoice details
                    break;
                case 2: // Go Back
                    customerInvoices();
                    break;
            }
        }
    }
    
    /**
     * Customer: Pay Invoice
     */
    public static void customerPayInvoice() {
        while (true) {
            // Display menu
            switch( customerPayInvoice.display() ) {
                case 1: // Pay Invoice
                    // TODO: update invoice status to paid
                    break;
                case 2: // Go Back
                    customerInvoices();
                    break;
            }
        }
    }
}
