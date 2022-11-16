package test;

// Import JUnit tests
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Before;

// Import SQL stuff
import java.sql.*;

import db.JDBC;
import db.adminQuery;

public class adminQueryTest {
        // Database String
        static final private String jdbcURL = "jdbc:oracle:thin:@ora.csc.ncsu.edu:1521:orcl01";
        // Database username (NCSU Unity ID)
        static final private String jdbcUser = "asrivas7";
        // Database password
        static final private String jdbcPassword = "abcd1234";
 
    /**
     * Before running this test, reset the database
     */
    @Before
    public void resetDatabase() {
        // Load the remote database
        JDBC.loadDatabase(jdbcURL, jdbcUser, jdbcPassword);
        // Reset the database
        JDBC.resetDatabaseFull();
        // Enable test mode
        JDBC.enableTestMode();
    }

    /*
     * Test the addStore method
     */
    @Test
    public void testAddStore() {
        // Create a new store
        String[] responses = {
            "69",            // sid
            "1234 Unique St",  // address
            "Will",         // first_name
            "Smith",          // last_name
            "wsmith",         // username
            "smith",     // password
            "10000",        // salary
            "100000420",            // eid
            "10",           // mechanic_minimum_rate
            "20",           // mechanic_maximum_rate
            "15",           // mechanic_hourly_rate
        };

        // Make sure responses is 11 long (sanity check)
        assertEquals(11, responses.length);

        // Add the store
        assertTrue(adminQuery.addStore(responses));

        // Check the store table
        try {
            // Get the store
            ResultSet rs = JDBC.executeQuery(
                "SELECT * FROM Service_Center WHERE sid = 69"
            );
            // Check the store
            assertTrue(rs.next());
            assertEquals(69, rs.getInt("sid"));
            assertEquals("1234 Unique St", rs.getString("address"));
            assertEquals(100000420, rs.getInt("manager_id"));
            assertEquals(10, rs.getInt("mechanic_minimum_rate"));
            assertEquals(20, rs.getInt("mechanic_maximum_rate"));
            assertEquals(15, rs.getInt("mechanic_hourly_rate"));
            assertFalse(rs.next());
            // Get the employee
            rs = JDBC.executeQuery(
                "SELECT * FROM Employee WHERE eid = 100000420"
            );
            // Check the employee
            assertTrue(rs.next());
            assertEquals(100000420, rs.getInt("eid"));
            assertEquals("Will", rs.getString("first_name"));
            assertEquals("Smith", rs.getString("last_name"));
            assertEquals("wsmith", rs.getString("username"));
            assertEquals("smith", rs.getString("password"));
            assertFalse(rs.next());
            // Get the manager
            rs = JDBC.executeQuery(
                "SELECT * FROM Manager WHERE eid = 100000420"
            );
            // Check the Manager
            assertTrue(rs.next());
            assertEquals(100000420, rs.getInt("eid"));
            assertEquals(10000, rs.getInt("salary"));
            assertFalse(rs.next());
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }

        // Try to add the store again
        // It should fail (duplicate ID and address)
        assertFalse(adminQuery.addStore(responses));

        // Change the store ID and try again
        // It should fail (duplicate address)
        responses[0] = "420";
        assertFalse(adminQuery.addStore(responses));

        // Change the address and person and try again
        // It should pass
        responses[1] = "234 Main Blvd"; // address
        responses[2] = "Barack";        // first name
        responses[3] = "Obama";         // last name
        responses[4] = "bobama";        // username
        responses[5] = "obama";         // password   
        responses[7] = "100000069";     // eid
        assertTrue(adminQuery.addStore(responses));

        // Now check to make sure everything was added correctly
        try {
            // Get the store
            ResultSet rs = JDBC.executeQuery(
                "SELECT * FROM Service_Center WHERE sid = 420"
            );
            // Check the store
            assertTrue(rs.next());
            assertEquals(420, rs.getInt("sid"));
            assertEquals("234 Main Blvd", rs.getString("address"));
            assertEquals(100000069, rs.getInt("manager_id"));
            assertEquals(10, rs.getInt("mechanic_minimum_rate"));
            assertEquals(20, rs.getInt("mechanic_maximum_rate"));
            assertEquals(15, rs.getInt("mechanic_hourly_rate"));
            assertFalse(rs.next());
            // Get the employee
            rs = JDBC.executeQuery(
                "SELECT * FROM Employee WHERE eid = 100000069"
            );
            // Check the employee
            assertTrue(rs.next());
            assertEquals(100000069, rs.getInt("eid"));
            assertEquals("Barack", rs.getString("first_name"));
            assertEquals("Obama", rs.getString("last_name"));
            assertEquals("bobama", rs.getString("username"));
            assertEquals("obama", rs.getString("password"));
            assertFalse(rs.next());
            // Get the manager
            rs = JDBC.executeQuery(
                "SELECT * FROM Manager WHERE eid = 100000069"
            );
            // Check the Manager
            assertTrue(rs.next());
            assertEquals(100000069, rs.getInt("eid"));
            assertEquals(10000, rs.getInt("salary"));
            assertFalse(rs.next());
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }        
    }

    /**
     * Test the addService method
     */
    @Test
    public void testAddService() {
        // Create a new service
        String[] service = {
            "Engine Services", // Exiting service cateogry
            "Blinker Fluid Refill", // Service name
            "2", // Service duration
        };

        // Make sure service is 3 long (sanity check)
        assertEquals(3, service.length);

        // Add the service
        assertTrue(adminQuery.addService(service));

        // Check the service table
        try {
            // Get the service
            ResultSet rs = JDBC.executeQuery("SELECT * FROM Services WHERE serviceName = 'Blinker Fluid Refill'");
            // Check the service
            assertTrue(rs.next());
            assertEquals(service[0], rs.getString("repair_category"));
            assertEquals(service[1], rs.getString("serviceName"));
            assertFalse(rs.next());
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }
        
        int exceptedResults = 5;
        String[] manfs = new String[exceptedResults];

        // Check the duration_details table
        try {
            ResultSet rs = JDBC.executeQuery("SELECT * FROM Duration_Details WHERE serviceName = 'Blinker Fluid Refill'");
            // Check the service
            assertTrue(rs.next());
            assertEquals(service[1], rs.getString("serviceName"));
            assertEquals(service[2], rs.getString("dur"));
            manfs[0] = rs.getString("manf");
            int index = 1;
            while (rs.next()) {
                manfs[index] = rs.getString("manf");
                index++;
            }
            assertEquals(exceptedResults, index);
            // Check for duplicates in manfs
            for (int i = 0; i < exceptedResults; i++) {
                for (int j = i + 1; j < exceptedResults; j++) {
                    assertFalse(manfs[i].equals(manfs[j]));
                }
            }
            // Reset manfs
            manfs = new String[exceptedResults];
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }

        // Check the Cost Details table to make sure the service was added
        // There will be multiple instances in the table
        try {
            // Get the resultset (we only want serviceName, cost, and manfs)
            ResultSet rs = JDBC.executeQuery("SELECT DISTINCT serviceName, price, manf FROM Cost_Details WHERE serviceName = 'Blinker Fluid Refill'");
            // Check the resultset
            assertTrue(rs.next());
            // Check serviceName
            assertEquals(service[1], rs.getString("serviceName"));
            // Check the cost (should be null)
            assertEquals(null, rs.getString("price"));
            // Record the manufacturer
            manfs[0] = rs.getString("manf");
            int index = 1;
            while (rs.next()) {
                manfs[index] = rs.getString("manf");
                index++;
            }
            assertEquals(exceptedResults, index);
            // Check for duplicates in manfs
            for (int i = 0; i < exceptedResults; i++) {
                for (int j = i + 1; j < exceptedResults; j++) {
                    assertFalse(manfs[i].equals(manfs[j]));
                }
            }
            // Reset manfs
            manfs = new String[exceptedResults];
        } catch (java.sql.SQLException e) {
            // Print an error message
            System.out.println("Error executing query");
            e.printStackTrace();
            // Quit the program
            System.exit(1);
        }

        // Change the service category to something that doesn't exist
        service[0] = "Fun Service";
        // Try adding the service again (this should fail)
        assertFalse(adminQuery.addService(service));

        // Change the service category back
        service[0] = "Engine Services";
        // Change the service duration to something that doesn't exist
        service[2] = "-10";
        // Try adding the service again (this should fail)
        assertFalse(adminQuery.addService(service));

        // Change the service duration to 0
        service[2] = "0";
        // Try adding the service again (this should fail)
        assertFalse(adminQuery.addService(service));
    }
}
