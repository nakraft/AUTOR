package autor;
import db.JDBC;
import ui.UI;

/**
 * AUTOR class, main class of program
 */
public class AUTOR {
    // Database String
    static final private String jdbcURL = "jdbc:oracle:thin:@ora.csc.ncsu.edu:1521:orcl01";
    // Database username (NCSU Unity ID)
    static final private String jdbcUser = "wagrocho";
    // Database password
    static final private String jdbcPassword = "abcd1234";

    /**
     * Main method
     * Loads the database, runs the UI, and closes the database when the UI is finished
     * 
     * @param args command line arguments
     */
    public static void main(String[] args) {
        // Load the remote database
        JDBC.loadDatabase(jdbcURL, jdbcUser, jdbcPassword);
        // Start up the UI
        UI.welcomeMenu();
        // Close the database connection
        JDBC.closeDatabase();
    }
}
