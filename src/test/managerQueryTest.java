package test;

// Import JUnit tests
import org.junit.Test;

import static org.junit.Assert.*;
import org.junit.Before;

// Import SQL stuff
import java.sql.*;

import db.JDBC;
import db.managerQuery;
import ui.UI;

/**
 * Test the managerQuery class using the JUnit framework.
 */
public class managerQueryTest {
    // Database String
    static final private String jdbcURL = "jdbc:oracle:thin:@ora.csc.ncsu.edu:1521:orcl01";
    // Database username (NCSU Unity ID)
    static final private String jdbcUser = "asrivas7";
    // Database password
    static final private String jdbcPassword = "abcd1234";
    // Manager username
    static final private String manager = "jdoe";
    // Manager password
    static final private String password = "doe";    

    /**
     * Before running this test, reset the database
     */
    @Before
    public void resetDatabase() {
        // Load the remote database
        JDBC.loadDatabase(jdbcURL, jdbcUser, jdbcPassword);
        // Reset the database
        JDBC.populateTablesFull();
        // Sign in as manager
        assertTrue(UI.signIn(manager, password));
        // Enable test mode
        JDBC.enableTestMode();
    }

    /**
     * Test the addEmployee method.
     */
    @Test
    public void testAddEmployee() {
        // Test adding a receptionist
        String[] employee = {
            "John",             // First name
            "Smith",            // Last name
            "123 Main St",      // Address
            "jsmith@ncsu.edu",  // Email
            "9195153000",       // Phone
            "receptionist",     // Role
            "2020-01-01",       // Start date
            "100000"            // Compensation
        };
        // Call addEmployee with receptionist info
        String result = managerQuery.addEmployee(employee);
        // Check that the result is an integer
        assertTrue(result.matches("[0-9]+"));
        // Check that the employee was added to the database
        ResultSet results = JDBC.executeQuery("SELECT * FROM Employee WHERE eid = " + result);
        try {
            assertTrue(results.next());
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error checking that employee was added to database");
        }
        // Check that the employee was added to the correct table
        results = JDBC.executeQuery("SELECT * FROM Receptionist WHERE eid = " + result);
        try {
            assertTrue(results.next());
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error checking that employee was added to correct table");
        }

        // Test readding the same receptionist
        result = managerQuery.addEmployee(employee);
        // Check that the result is an error
        assertTrue(result.startsWith("ERROR:"));

        // Change the role to a mechanic
        employee[5] = "mechanic";
        // Change the compensation to a valid amount for the store
        employee[7] = "35";
        // Call addEmployee with mechanic info
        result = managerQuery.addEmployee(employee);
        // Check that the result is an integer
        // Print result
        System.out.println(result);
        assertTrue(result.matches("[0-9]+"));
        // Check that the employee was added to the database
        results = JDBC.executeQuery("SELECT * FROM Employee WHERE eid = " + result);
        try {
            assertTrue(results.next());
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error checking that employee was added to database");
        }
        // Check that the employee was added to the correct table
        results = JDBC.executeQuery("SELECT * FROM Mechanic WHERE eid = " + result);
        try {
            assertTrue(results.next());
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error checking that employee was added to correct table");
        }

        // Test readding the same mechanic
        result = managerQuery.addEmployee(employee);
        // Check that the result is valid (no fields in mechanic are keys)
        assertTrue(result.matches("[0-9]+"));

        // Change the role to a manager
        employee[5] = "manager";
        // Call addEmployee with manager info
        result = managerQuery.addEmployee(employee);
        // Make sure the result is an error
        assertTrue(result.startsWith("ERROR:"));

        // Change the role to a customer
        employee[5] = "customer";
        // Call addEmployee with customer info
        result = managerQuery.addEmployee(employee);
        // Make sure the result is an error
        assertTrue(result.startsWith("ERROR:"));

        // Change the role to an invalid role
        employee[5] = "invalid";
        // Call addEmployee with invalid info
        result = managerQuery.addEmployee(employee);
        // Make sure the result is an error
        assertTrue(result.startsWith("ERROR:"));
    }

    /**
     * Test the setSchedulePrice method
     */
    @Test
    public void testSetSchedulePrice() {
        // Get the cost of schedule A and Honda
        ResultSet results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 120
            assertEquals(results.getInt("price"), 120);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of schedule A and Honda to 100
        assertTrue(managerQuery.setSchedulePrice("A", "100", "Honda"));
        // Get the cost of schedule A and Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 100
            assertEquals(results.getInt("price"), 100);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Get the cost of schedule A and Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 190
            assertEquals(results.getInt("price"), 190);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of schedule A and Nissan to 200
        assertTrue(managerQuery.setSchedulePrice("A", "200", "Nissan"));
        // Get the cost of schedule A and Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 200
            assertEquals(results.getInt("price"), 200);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Get the cost of schedule A and Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 200
            assertEquals(results.getInt("price"), 200);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of schedule A and Toyota to 300
        assertTrue(managerQuery.setSchedulePrice("A", "300", "Toyota"));
        // Get the cost of schedule A and Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(results.getInt("price"), 300);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Set the cost of schedule A for all manufacturers to 400
        assertTrue(managerQuery.setSchedulePrice("A", "400", null));
        // Get the cost of schedule A and Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 400
            assertEquals(results.getInt("price"), 400);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule A and Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 400
            assertEquals(results.getInt("price"), 400);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule A and Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'A' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 400
            assertEquals(results.getInt("price"), 400);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Make sure the price for all schedule B and C cars did not change
        // Get the cost of schedule B and Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'B' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 195
            assertEquals(results.getInt("price"), 195);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule B and Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'B' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 210
            assertEquals(results.getInt("price"), 210);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule B and Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'B' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 215
            assertEquals(results.getInt("price"), 215);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule C and Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'C' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(results.getInt("price"), 300);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule C and Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'C' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 310
            assertEquals(results.getInt("price"), 310);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Get the cost of schedule C and Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'C' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 305
            assertEquals(results.getInt("price"), 305);
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
    }

    /**
     * Test setOperationalHours method
     */
    @Test
    public void testSetOperationalHours() {
        // Query for operational hours at the current service center
        ResultSet results = JDBC.executeQuery("SELECT saturday FROM Service_Center WHERE sid = " + UI.getCurrentSID());
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure it returned 'o'
            assertEquals(results.getString("saturday"), "o");
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current operational hours"); 
        }
        // Set the operational hours to 'c'
        assertTrue(managerQuery.setOperationalHours("n"));
        // Query for operational hours at the current service center
        results = JDBC.executeQuery("SELECT saturday FROM Service_Center WHERE sid = " + UI.getCurrentSID());
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure it returned 'c'
            assertEquals(results.getString("saturday"), "close");
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current operational hours"); 
        }
        // Set the operational hours to 'o'
        assertTrue(managerQuery.setOperationalHours("y"));
        // Query for operational hours at the current service center
        results = JDBC.executeQuery("SELECT saturday FROM Service_Center WHERE sid = " + UI.getCurrentSID());
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure it returned 'o'
            assertEquals(results.getString("saturday"), "open");
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current operational hours"); 
        }
    }

    /**
     * Test getRepairServices()
     */
    @Test
    public void testGetRepairServices() {
        // Get the repair services
        String[] services = managerQuery.getRepairServices();
        // Make sure the list is not null
        assertNotNull(services);
        // Make sure the list is not empty
        assertEquals(services.length, 12);
        // Make sure the list contains the correct services (alphabetical order)
        assertEquals(services[0], "Alternator Repair");
        assertEquals(services[1], "Axle Repair");
        assertEquals(services[2], "Belt Replacement");
        assertEquals(services[3], "Brake Repair");
        assertEquals(services[4], "Compressor Repair");
        assertEquals(services[5], "Engine Repair");
        assertEquals(services[6], "Evaporator Repair");
        assertEquals(services[7], "Exhaust Repair");
        assertEquals(services[8], "Muffler Repair");
        assertEquals(services[9], "Power Lock Repair");
        assertEquals(services[10], "Tire Balancing");
        assertEquals(services[11], "Wheel Alignment");
    }

    /**
     * Test setRepairServicePrice method
     */
    @Test
    public void testSetRepairServicePrice() {
        // Query for the cost of Alternator Repair on a Honda
        ResultSet results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 400
            assertEquals(400, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of Alternator Repair on a Honda to 200
        assertTrue(managerQuery.setRepairServicePrice("Alternator Repair", "200", "Honda"));
        // Query for the cost of Alternator Repair on a Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 200
            assertEquals(200, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Query for the cost of Alternator Repair on a Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 500
            assertEquals(500, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of Alternator Repair on a Nissan to 250
        assertTrue(managerQuery.setRepairServicePrice("Alternator Repair", "250", "Nissan"));
        // Query for the cost of Alternator Repair on a Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 250
            assertEquals(250, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Query for the cost of Alternator Repair on a Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 450
            assertEquals(450, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of Alternator Repair on a Toyota to 225
        assertTrue(managerQuery.setRepairServicePrice("Alternator Repair", "225", "Toyota"));
        // Query for the cost of Alternator Repair on a Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 225
            assertEquals(225, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Set the cost of Alternator Repair for all manufacturers to 300
        assertTrue(managerQuery.setRepairServicePrice("Alternator Repair", "300", ""));
        // Query for the cost of Alternator Repair on a Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(300, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Query for the cost of Alternator Repair on a Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(300, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Query for the cost of Alternator Repair on a Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Alternator Repair' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(300, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Query for the cost of Axle Repair on a Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 1000
            assertEquals(1000, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of Axle Repair on a Honda to 200
        assertTrue(managerQuery.setRepairServicePrice("Axle Repair", "200", "Honda"));
        // Query for the cost of Axle Repair on a Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 200
            assertEquals(200, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        
        // Query for the cost of Axle Repair on a Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 1200
            assertEquals(1200, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of Axle Repair on a Nissan to 200
        assertTrue(managerQuery.setRepairServicePrice("Axle Repair", "200", "Nissan"));
        // Query for the cost of Axle Repair on a Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 200
            assertEquals(200, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Query for the cost of Axle Repair on a Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 1100
            assertEquals(1100, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Set the cost of Axle Repair on a Toyota to 200
        assertTrue(managerQuery.setRepairServicePrice("Axle Repair", "200", "Toyota"));
        // Query for the cost of Axle Repair on a Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 200
            assertEquals(200, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }

        // Set the cost of Axle Repair for all manufacturers to 300
        assertTrue(managerQuery.setRepairServicePrice("Axle Repair", "300", ""));
        // Query for the cost of Axle Repair on a Honda
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Honda'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(300, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Query for the cost of Axle Repair on a Nissan
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Nissan'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(300, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
        // Query for the cost of Axle Repair on a Toyota
        results = JDBC.executeQuery("SELECT * FROM Cost_Details WHERE sid = " + UI.getCurrentSID() + "AND serviceName = 'Axle Repair' AND manf = 'Toyota'");
        // Make sure the query returned a result
        try {
            assertTrue(results.next());
            // Make sure the cost is 300
            assertEquals(300, results.getInt("price"));
        } catch (SQLException e) {
            e.printStackTrace();
            fail("Error getting current service prices"); 
        }
    }
}
