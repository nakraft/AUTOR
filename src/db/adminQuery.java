package db;

// Import SQL libraries
import java.sql.*;
import java.util.ArrayList;

/**
 * Queries for admins
 */
public class adminQuery {

    /**
     * Add a new store
     */
    public static boolean addStore(String[] responses) {
        try {
            // Insert into the store table
            if (JDBC.executeUpdate(
                "INSERT INTO Service_Center (" +
                    "sid, " +
                    "address, " +
                    "manager_id, " +
                    "mechanic_minimum_rate, " +
                    "mechanic_maximum_rate," +
                    "mechanic_hourly_rate" +
                ") VALUES (" +
                    responses[0] + "," +
                    "'" + responses[1] + "'," +
                    responses[7] + "," +
                    responses[8] + "," +
                    responses[9] + "," +
                    responses[10] +
                ")"
            ) <= 0) {
                return false;
            }
            // If the query inserts a row
            if (JDBC.executeUpdate(
                "UPDATE Employee SET " +
                    "first_name = '" + responses[2] + "', " +
                    "last_name = '" + responses[3] + "', " +
                    "username = '" + responses[4] + "', " +
                    "password = '" + responses[5] + "' " +
                    "WHERE eid = " + responses[7]
            ) <= 0) {
                throw new java.sql.SQLException("Error updating employee");
            }
            // If the query inserts a row, update the manager table with salary
            if (JDBC.executeUpdate(
                "UPDATE Manager SET " +
                    "salary = " + responses[6] + " " +
                    "WHERE eid = " + responses[7]
            ) <= 0) {
                throw new java.sql.SQLException("Error updating manager");
            }
            
        } catch (java.sql.SQLException e) {
            // // Print an error message
            // System.out.println("Error executing query");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
            return false;
        }
        // If there aren't any errors
        return true;
    }

    /**
     * Validate the existence of a service category
     * 
     * @param repairCategory the repair category to search for
     * @returns True if the service category exists, otherwise false
     */
    public static boolean validateRepairCategory(String repairCategory) {
        try {
            // Query the service table
            ResultSet result = JDBC.executeQuery("SELECT * FROM Services WHERE repair_category = '" + repairCategory + "'");
            // If the query returns a result
            if (result.next()) {
                // Return true
                return true;
            }
        } catch (java.sql.SQLException e) {
            // // Print an error message
            // System.out.println("Error executing query");
            // e.printStackTrace();
            // // Quit the program
            // System.exit(1);
            return false;
        }
        // If no matching service category is found
        return false;
    }

    /**
     * Add a new service
     */
    public static boolean addService(String[] responses) {
        try {
            // Get the last service number
            ResultSet result = JDBC.executeQuery("SELECT MAX(serviceNumber) AS next FROM Work_Event");
            result.next();
            String nextId = result.getString("next");
            nextId = String.valueOf(Integer.parseInt(nextId) + 1);
            ArrayList<String> queryList = new ArrayList<String>();
            // Insert into the store table
            queryList.add("INSERT INTO Services (serviceName,serviceNumber,repair_category) VALUES (" +
                    "'" + responses[1] + "'" + ',' + 
                    "'" + nextId + "'" + ',' + 
                    "'" + responses[0] + "'" + ')'
            );
            // Now that it is in services, we need to query service_center for
            // lists of all the service center IDs
            ResultSet sid = JDBC.executeQuery("SELECT DISTINCT sid FROM Service_Center");
            // For each service center, insert into tables
            String[] manf = {"Honda", "Nissan", "Toyota", "Lexus", "Infiniti"};
            while (sid.next()) {
                // Insert into Cost_Details
                for (int manf_index = 0; manf_index < 5; manf_index++) {
                    queryList.add(
                        "INSERT INTO Cost_Details (sid,serviceNumber,serviceName,manf,price) VALUES (" +
                            sid.getString("sid") + ',' +
                            nextId + ',' +
                            "'" + responses[1] + "'" + ',' +
                            "'" + manf[manf_index] + "'," +
                            "''" +
                        ")"
                    );
                }
            }
            // Insert into Duration_Details
            for (int manf_index = 0; manf_index < 5; manf_index++) {
                queryList.add(
                    "INSERT INTO Duration_Details (serviceNumber,serviceName,manf,dur) VALUES (" +
                        nextId + ',' +
                        "'" + responses[1] + "'" + ',' +
                        "'" + manf[manf_index] + "'," +
                        responses[2] +
                    ")"
                );
            }
            // Print out all the queries real fast (debugging stuff)
            for (String query : queryList) {
                System.out.println(query);
            }
            // Execute all the queries
            int[] feedback = JDBC.executeUpdatesAtomic(queryList.toArray(new String[queryList.size()]));
            if (feedback == null) {
                throw new java.sql.SQLException("Error updating cost and duration details");
            }
            // Return true at end
            return true;            
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
    }    
}
