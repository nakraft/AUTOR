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
            "123 Main St",  // address
            "Will",         // first_name
            "Smith",          // last_name
            "wsmith",         // username
            "smith",     // password
            "10000",        // salary
            "420",            // eid
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
            assertEquals("123 Main St", rs.getString("address"));
            assertEquals(420, rs.getInt("manager_id"));
            assertEquals(10, rs.getInt("mechanic_minimum_rate"));
            assertEquals(20, rs.getInt("mechanic_maximum_rate"));
            assertEquals(15, rs.getInt("mechanic_hourly_rate"));
            assertFalse(rs.next());
            // Get the employee
            rs = JDBC.executeQuery(
                "SELECT * FROM Employee WHERE eid = 420"
            );
            // Check the employee
            assertTrue(rs.next());
            assertEquals(420, rs.getInt("eid"));
            assertEquals("Will", rs.getString("first_name"));
            assertEquals("Smith", rs.getString("last_name"));
            assertEquals("wsmith", rs.getString("username"));
            assertEquals("smith", rs.getString("password"));
            assertFalse(rs.next());
            // Get the manager
            rs = JDBC.executeQuery(
                "SELECT * FROM Manager WHERE eid = 420"
            );
            // Check the Manager
            assertTrue(rs.next());
            assertEquals(420, rs.getInt("eid"));
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
        // It should fail
        assertFalse(adminQuery.addStore(responses));
    }

}
