package test;

// Import JUnit tests
import org.junit.Test;

import static org.junit.Assert.*;
import org.junit.Before;

// Import SQL stuff
import java.sql.*;

import db.JDBC;

public class jdbcTest {
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
        JDBC.populateTablesFull();
        // Enable test mode
        JDBC.enableTestMode();
    }

    /**
     * Test the executeUpdatesAtomic method
     */
    @Test
    public void testExecuteUpdatesAtomic() {
        // Create a new array (size 2) of queries
        String[] queries = new String[2];
        // Add the first query (this one works)
        queries[0] = "INSERT INTO schedule(serviceName, serviceNumber) VALUES('A', 200)";
        // Run the first query to make sure it runs
        assertEquals(1, JDBC.executeUpdate(queries[0]));
        // Add the second query (this one fails)
        queries[1] = "INSERT INTO schedule(serviceName, serviceNumber) VALUES('D', 100)";
        // Run the second query to make sure it fails
        assertTrue(JDBC.executeUpdate(queries[1]) <= 0);
        // Delete the first query from the schedule table
        assertEquals(1, JDBC.executeUpdate("DELETE FROM schedule WHERE serviceNumber = 200"));
        // Run the queries in a transaction
        assertTrue(JDBC.executeUpdatesAtomic(queries) == null);
        // Make sure the first query was not run
        ResultSet rs = JDBC.executeQuery("SELECT * FROM schedule WHERE serviceNumber = 200");
        try {
            assertFalse(rs.next());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
