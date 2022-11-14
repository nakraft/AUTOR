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
    static final private String jdbcUser = "wagrocho";
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
        JDBC.resetDatabase();
    }

    /**
     * Test the addEmployee method.
     */
    @Test
    public void testAddEmployee() {
        // Manager username
        String username = "jdoe";
        // Manager password
        String password = "doe";
        // Sign in as manager
        assertTrue(UI.signIn(username, password));

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
}