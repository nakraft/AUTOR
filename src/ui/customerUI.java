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

    private static menu customerServiceHistory = new menu(
        "Customer:  Service History", // Header
        null, // Lines
        null, // Prompts
        new String[] {
            "Go Back" // customerViewScheduleService
        }   // Options
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
                    System.exit(0);
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
                    if(customerQuery.addVehicle(customerAddCar.getPromptResponses())) {
                        customerLanding.setFeedback("Vehicle added Successfully");
                        customerLanding();
                    }
                    else {
                        customerLanding.setFeedback("Vehicle already exists");
                        customerLanding();
                    }
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
                    if(customerQuery.deleteVehicle(customerDeleteCar.getPromptResponses()[0])) {
                        customerLanding.setFeedback("Vehicle Deleted Successfully");
                        customerLanding();
                    }
                    else {
                        customerLanding.setFeedback("Vehicle does not exists");
                        customerLanding();
                    }
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
                    cart.clear();
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
        test:while (true) {
            // Display menu
            switch( customerViewServiceHistory.display() ) {
                case 1: // View Service History
                    customerServiceHistory(customerViewServiceHistory.getPromptResponses()[0]);
                    break test;
                case 2: // Go Back
                    customerViewScheduleService();
                    break;
            }
        }
    }

    public static void customerServiceHistory(String Vin) {

        String[][] serviceHistory = customerQuery.getServiceHistory(Vin);
        String[] lines;
        if (serviceHistory != null) {
        lines = new String[serviceHistory.length+1];}
        else {
            lines = new String[1];
            lines[0] = "No Service History Present";
        }   
        if (serviceHistory != null) {
        lines[0] = "Service ID        Vehicle\tTotal Amount\tMechanic\t\tStart Day\tEnd Day";
        for (int i = 0; i < serviceHistory.length; i++) {
            lines[i+1] = serviceHistory[i][0] +"\t\t" + serviceHistory[i][1]+'\t' + serviceHistory[i][2]+"\t\t" + serviceHistory[i][3]+"\t\t"+ serviceHistory[i][4]+"\t\t" + serviceHistory[i][5];
        }
    }
        // Set menu lines to the new String array
        customerServiceHistory.setLines(lines);
        // Display Services
        customerServiceHistory.display();
    }


    /**
     * Customer: Schedule Service
     */
    public static void customerScheduleService() {
        while (true) {
            // Display menu
            int case_option = customerScheduleService.display();
            String Vin = customerScheduleService.getPromptResponses()[0];
            boolean vehicle_exists = customerQuery.validateVehicle(Vin);
            if (! vehicle_exists) {
                customerViewScheduleService.setFeedback("Invalid Vehicle for the Customer");
                case_option = 4;
            }
            switch( case_option ) {
                case 1: // Add Scheduled Maintenance
                    displayScheduledMaintenance(customerScheduleService.getPromptResponses()[0]);
                    break;
                case 2: // Add Scheduled Repair
                    customerScheduledRepair();
                    break;
                case 3: // View Cart and Select Schedule Time
                    customerViewCartSelectScheduleTime(customerScheduleService.getPromptResponses()[0]);
                    break;
                case 4: // Go Back
                    customerViewScheduleService();
                    break;
            }
        }
    }

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
                customerScheduleService();
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
                    customerScheduleService();
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
    public static void customerViewCartSelectScheduleTime(String Vin) {
        if (cart.size() == 0) {
            customerScheduleService.setFeedback("Cart is empty");
            customerScheduleService();
            return;
        }
        String[] curcart = new String[cart.size()+3];
        String querystr = "";
        int i=0;
        curcart[i++] = "Cart items";
        for(String ele:cart) {
            curcart[i++] = ele;
            querystr += ("('" + ele.trim() + "','" + serviceMapping.get(ele) + "'),");
        }
        querystr = querystr.substring(0,querystr.length()-1);
        String[] cartDetails =  customerQuery.getCartCostDur(querystr, Vin);
        curcart[i++] = "Total cost - "+cartDetails[0];
        curcart[i++] = "Total duration - "+cartDetails[1];
        customerViewCartSelectScheduleTime.setLines(curcart);
        while (true) {
            // Display menu
            switch( customerViewCartSelectScheduleTime.display() ) {
                case 1: // Proceed with Scheduling
                    customerScheduleServicesInCart(Vin,cartDetails[0],cartDetails[1]);
                    break;
                case 2: // Go Back
                    customerScheduleService();
                    break;
            }
        }
    }

    /**
     * Customer: Schedule Services in Cart 4Y1BL658
     */
    public static void customerScheduleServicesInCart(String Vin, String cost, String duration) {
        // TODO: update menu options with available times
        while (true) {
            // Display menu
            // set options with time slots
            ArrayList<String[]> timeSlots = customerQuery.getTimeSlots(Vin,duration);
            if (timeSlots == null || timeSlots.size() == 0) {
                cart.clear();
                customerLanding.setFeedback("Failed to generate Invoice: Time slot not available for the selected service.");
                customerLanding();
            }
            ArrayList<String> temp = new ArrayList<>();
            for (int i = 0; i < timeSlots.size(); i++) {
                if(customerQuery.mechanic_overwork(timeSlots.get(i), duration)){
                    temp.add("Day - " + timeSlots.get(i)[0] + ", Week - " + timeSlots.get(i)[1] + ", Timeslot - " + timeSlots.get(i)[2] + " Mechanic - " + timeSlots.get(i)[3] + " id - " + timeSlots.get(i)[4]);
                }
            }
            String[] res = new String[temp.size() + 1];
            temp.toArray(res);
            res[temp.size()] = "Go Back";
            customerScheduleServicesInCart.setOptions(res);
            // for(String ele:temp) {
            //     System.out.println(ele);  
            // }
            // String test = UI.input.nextLine();
            // get slot from prompt

            while (true) {
                // Display menu
                customerScheduleServicesInCart.display();
                // if option is the last option, go back
                int response = customerScheduleServicesInCart.getMenuResponse();
                if ( response == res.length) {
                    customerViewCartSelectScheduleTime(Vin);
                }
                // else, checkout cart
                else {
                    Integer result = customerQuery.customerCartCheckout(Vin,timeSlots.get(response-1),cost,duration, cart, serviceMapping);
                    if(result == -1) {
                        customerLanding.setFeedback("Failed to generate Invoice");
                        customerLanding(); 
                    }
                    else if (result == -2) {
                        customerLanding.setFeedback("Failed to generate Invoice: Time slot not available for the selected service.");
                        customerLanding();
                    }
                    else if (result == -3) {
                        customerLanding.setFeedback("Failed to generate Invoice: The selected mechanic will exceed working 50 hours/week limit");
                        customerLanding();
                    }
                    else {
                        cart.clear();
                        customerLanding.setFeedback("Succesfully Generated Invoice with ID "+ result);
                        customerLanding();
                    }
                }
            }

            // TODO: generate new invoice with selected services and time
            // return to customer landing
            // customerLanding();
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
                    String invoice_id = customerViewInvoiceDetails.getPromptResponse(0);
                    String[] invoice = customerQuery.getInvoice(invoice_id);
                    if(invoice == null) {
                        customerViewInvoiceDetails.setFeedback("Failed to get Invoice with ID "+ invoice_id);
                        break;
                    }
                    String[] invoice_details = new String[10];
                    invoice_details[0] = "Invoice ID - "+invoice[0];
                    invoice_details[1] = "Customer ID - "+invoice[1];
                    invoice_details[2] = "VIN - "+invoice[2];
                    invoice_details[3] = "Service Date - "+invoice[3];
                    invoice_details[4] = "Service(s) IDs - "+invoice[4];
                    invoice_details[5] = "Service(s) Type(s) - "+invoice[5];
                    invoice_details[6] = "Invoice Status - "+invoice[6];
                    invoice_details[7] = "Mechanic name - "+invoice[7];
                    invoice_details[8] = "Cost for each service - "+invoice[8];
                    invoice_details[9] = "Total cost - "+invoice[9];
                    customerViewInvoiceDetails.setLines(invoice_details);
                    break;
                case 2: // Go Back
                    customerViewInvoiceDetails.setLines(null);
                    customerInvoices();
                    break;
            }
        }
    }
    
    /**
     * Customer: Pay Invoice
     */
    public static void customerPayInvoice() {
        // invoice status: total amount, amount paid, status
        
        
        while (true) {
            // Display menu
            switch( customerPayInvoice.display() ) {
                case 1: // Pay Invoice
                String invoice_id = customerPayInvoice.getPromptResponses()[0];
                String[] invoiceStatus = customerQuery.getInvoiceStatus(invoice_id);
                if (invoiceStatus == null) {
                    customerPayInvoice.setFeedback("Invalid Invoice ID, Invoice doesn't exist");
                    break;
                }
                System.out.println(invoiceStatus[0]);
                System.out.println(invoiceStatus[2]);
                if (Integer.parseInt(invoiceStatus[2]) == 0) {
                    boolean response = customerQuery.payInvoice(invoice_id);
                    if (response== true) {
                        customerPayInvoice.setFeedback("Invoice Sucessfully paid");
                    }
                    else {
                        customerPayInvoice.setFeedback("Failed to pay Invoice");
                    }

                    
                }
                else {
                    customerPayInvoice.setFeedback("Invoice has already been paid, Choose a different invoice");
                }
                    break;
                case 2: // Go Back
                    customerInvoices();
                    break;
            }
        }
    }
}
