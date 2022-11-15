package test;

// Import JUnit tests
import org.junit.Test;

import static org.junit.Assert.*;
import org.junit.Before;

// Import SQL stuff
import java.sql.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import db.JDBC;
import db.managerQuery;
import db.receptionistQuery;
import ui.UI;

/**
 * Test the receptionistQuery class using the JUnit framework.
 */
public class receptionistQueryTest {
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
        JDBC.resetDatabaseFull();
        // Sign in as manager
        assertTrue(UI.signIn(manager, password));
        // Add a receptionist
        managerQuery.addEmployee( new String[] {
            "John",             // First name
            "Smith",            // Last name
            "123 Main St",      // Address
            "jsmith@ncsu.edu",  // Email
            "9195153000",       // Phone
            "receptionist",     // Role
            "2020-01-01",       // Start date
            "100000"            // Compensation
        });
        // Sign in as the receptionist
        assertTrue(UI.signIn("jsmith", "smith"));
        // Enable test mode
        JDBC.enableTestMode();
    }

    /**
     * Test the addCustomer method
     */
    @Test
    public void testAddCustomer() {
        String[] customer = {
            "John",             // First name
            "Smith",            // Last name
            "123 Main St",      // Address
            "jsmith@ncsu.edu",  // Email
            "9194439688",       // Phone
            "jsmith69",         // Username
            "9DJ4SK5P",         // VIN
            "Honda",            // Manf
            "52063",            // Mileage
            "2019"              // Year
        };

        // Add the customer (should be successful)
        assertTrue(receptionistQuery.addCustomer(customer));
        // Query the car's VIN to make sure it has been added
        assertTrue(JDBC.execute("SELECT vin FROM vehicle WHERE vin = '9DJ4SK5P'"));

        // Change the vin on the customer to be empty
        customer[6] = "";
        // Add the customer (should be unsuccessful)
        assertFalse(receptionistQuery.addCustomer(customer));
        // Query the car's VIN to make sure it has not been added
    }

    /**
     * Test getCustomersWthPendingInvoices method
     */
    @Test
    public void testGetCustomersWithPendingInvoices() {
        // Fetch all pending invoices
        ResultSet result = JDBC.executeQuery("SELECT * FROM invoice WHERE status = 0");
        // Check to make sure pending invoices exist and match the expected values
        try {
            assertTrue(result.next());
            assertEquals(1, result.getInt("id"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals(123405678, result.getInt("eid"));
            assertEquals(10501, result.getInt("cid"));
            assertEquals(1, result.getInt("start_timeslot_week"));
            assertEquals(2, result.getInt("start_timeslot_day"));
            assertEquals(1, result.getInt("start_timeslot"));
            assertEquals(1, result.getInt("end_timeslot_week"));
            assertEquals(2, result.getInt("end_timeslot_day"));
            assertEquals(1, result.getInt("end_timeslot"));
            assertEquals("P39VN198", result.getString("vin"));
            assertTrue(result.next());
            assertEquals(2, result.getInt("id"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals(123450678, result.getInt("eid"));
            assertEquals(10010, result.getInt("cid"));
            assertEquals(1, result.getInt("start_timeslot_week"));
            assertEquals(2, result.getInt("start_timeslot_day"));
            assertEquals(1, result.getInt("start_timeslot"));
            assertEquals(1, result.getInt("end_timeslot_week"));
            assertEquals(2, result.getInt("end_timeslot_day"));
            assertEquals(1, result.getInt("end_timeslot"));
            assertEquals("39YVS415", result.getString("vin"));
            assertFalse(result.next());
        } catch (SQLException e) {
            fail("SQLException: " + e.getMessage());
        }
        
        // Fetch all customers at store 30003
        result = JDBC.executeQuery("SELECT * FROM customer WHERE sid = 30003");
        // Check to make sure customers exist and match the expected values
        try {
            assertTrue(result.next());
            assertEquals(10002, result.getInt("cid"));
            assertEquals("Tony", result.getString("first_name"));
            assertEquals("Stark", result.getString("last_name"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals("tstark", result.getString("username"));
            assertEquals("stark", result.getString("password"));
            assertTrue(result.next());
            assertEquals(10003, result.getInt("cid"));
            assertEquals("Natasha", result.getString("first_name"));
            assertEquals("Romanoff", result.getString("last_name"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals("nromanoff", result.getString("username"));
            assertEquals("romanoff", result.getString("password"));
            assertTrue(result.next());
            assertEquals(10011, result.getInt("cid"));
            assertEquals("Harvey", result.getString("first_name"));
            assertEquals("Bullock", result.getString("last_name"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals("hbullock", result.getString("username"));
            assertEquals("bullock", result.getString("password"));
            assertTrue(result.next());
            assertEquals(10062, result.getInt("cid"));
            assertEquals("Sam", result.getString("first_name"));
            assertEquals("Wilson", result.getString("last_name"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals("swilson", result.getString("username"));
            assertEquals("wilson", result.getString("password"));
            assertTrue(result.next());
            assertEquals(10501, result.getInt("cid"));
            assertEquals("Wanda", result.getString("first_name"));
            assertEquals("Maximoff", result.getString("last_name"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals("wmaximoff", result.getString("username"));
            assertEquals("maximoff", result.getString("password"));
            assertTrue(result.next());
            assertEquals(10010, result.getInt("cid"));
            assertEquals("Virginia", result.getString("first_name"));
            assertEquals("Potts", result.getString("last_name"));
            assertEquals(30003, result.getInt("sid"));
            assertEquals("vpotts", result.getString("username"));
            assertEquals("potts", result.getString("password"));
            assertFalse(result.next());
        } catch (SQLException e) {
            fail("SQLException: " + e.getMessage());
        }

        // Fetch all customers with pending invoices
        // This should be empty because we're signed in at store 3001
        // There are no pending invoices at store 3001
        String[] pendingCustomers = receptionistQuery.getCustomersWithPendingInvoices();
        assertEquals(0, pendingCustomers.length);

        // Sign in as the manager at store 30003
        assertTrue(UI.signIn("csmith", "smith"));
        // Then create the receptionist for store 30003
        managerQuery.addEmployee( new String[] {
            "Barack",           // First name
            "Obama",            // Last name
            "123 Main St",      // Address
            "bobama@ncsu.edu",  // Email
            "9195153000",       // Phone
            "receptionist",     // Role
            "2020-01-01",       // Start date
            "200000"            // Compensation
        });
        // Sign in as the receptionist
        assertTrue(UI.signIn("bobama", "obama"));

        // Get the current date real fast
        LocalDate dateObj = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String date = dateObj.format(formatter);

        // Fetch all customers with pending invoices
        // This should return 2 customers
        pendingCustomers = receptionistQuery.getCustomersWithPendingInvoices();
        assertEquals(2, pendingCustomers.length);
        assertEquals("10501", pendingCustomers[0].split(",")[0]); // cid
        assertEquals("Wanda", pendingCustomers[0].split(",")[1]); // first_name
        assertEquals("Maximoff", pendingCustomers[0].split(",")[2]); // last_name
        assertEquals("1", pendingCustomers[0].split(",")[3]); // Invoice.id
        assertEquals(date, pendingCustomers[0].split(",")[4].substring(0, 10)); // date_generated
        assertEquals("210", pendingCustomers[0].split(",")[5]); // total_amount
        assertEquals("10010", pendingCustomers[1].split(",")[0]); // cid
        assertEquals("Virginia", pendingCustomers[1].split(",")[1]); // first_name
        assertEquals("Potts", pendingCustomers[1].split(",")[2]); // last_name
        assertEquals("2", pendingCustomers[1].split(",")[3]); // Invoice.id
        assertEquals(date, pendingCustomers[1].split(",")[4].substring(0, 10)); // date_generated
        assertEquals("175", pendingCustomers[1].split(",")[5]); // total_amount
    }
}
