package db;
import java.sql.ResultSet;
import ui.UI;

/**
 * Queries for receptionists
 */
public class receptionistQuery {

    /**
     * Add Customer to the database
     * 
     * @param String[] Customer information (first_name,last_name,address,email,phone,username,vin,manf,mileage,year)
     * @return boolean true if successful, false if not
     */
    public static boolean addCustomer(String[] responses) {        
        try {

            // Get the max customer ID number
            ResultSet result = JDBC.executeQuery("SELECT MAX(cid) AS cid FROM Customer");
            result.next();
            String customerID = result.getString("cid");
            customerID = String.valueOf(Integer.parseInt(customerID) + 1);

            // Add Customer
            // Insert into the Customer table
            if(!JDBC.executeUpdate(
                "INSERT INTO Customer (first_name,last_name,address,email,phone,username,password,cid,sid) VALUES (" +
                    "'" + responses[0] + "'" + ',' + 
                    "'" + responses[1] + "'" + ',' + 
                    "'" + responses[2] + "'" + ',' + 
                    "'" + responses[3] + "'" + ',' + 
                    "'" + responses[4] + "'" + ',' + 
                    "'" + responses[5] + "'" + ',' + 
                    "'" + responses[1] + "'" + ',' + 
                    "'" + customerID + "'" + ',' +
                    "'" + UI.getCurrentSID() + "'" + ')'
            )) {
                throw new java.sql.SQLException("Error updating services");
            }

            // Add Customer's vehicle
            if (!JDBC.executeUpdate(
                    "INSERT INTO Vehicle (vin,manf,mileage,year,cid,sid) VALUES (" +
                    "'" + responses[6] + "'" + ',' + 
                    "'" + responses[7] + "'" + ',' + 
                    "'" + responses[8] + "'" + ',' + 
                    "'" + responses[9] + "'" + ',' + 
                    "'" + customerID + "'" + ',' + 
                    "'" + UI.getCurrentSID() + "'" + ')'
                )) {
                    throw new java.sql.SQLException("Error updating duration details");
                }
        } catch (java.sql.SQLException e) {
            /*
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
            */
            return false;
        }
        // If there aren't any errors
        return true;
    }  
}
