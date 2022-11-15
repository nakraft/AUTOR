package test;

// Import JUnit tests
import org.junit.Test;

import static org.junit.Assert.*;
import org.junit.Before;

// Import SQL stuff
import java.sql.*;

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

        //
    }
}
