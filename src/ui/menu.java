package ui;

/**
 * Menu class for menu objects
 */
public class menu {
    // Header for menu
    private String header;
    // Feedback for menu
    private String feedback;
    // Lines to display first
    private String[] lines;
    // Prompts for the user
    private String[] prompts;
    // Prompt responses
    private String[] promptResponses;
    // Menu options
    private String[] options;
    // Menu response
    private int menuResponse;

    /**
     * Constructor for menu objects
     * @param header Header for the menu
     * @param lines (Optional) Lines to display first
     * @param prompts (Optional) Prompts for the user
     * @param options
     */
    public menu(String header, String[] lines, String[] prompts, String[] options) {
        // Set header
        setHeader(header);
        // Set lines
        setLines(lines);
        // Set prompts
        setPrompts(prompts);
        // Set options
        setOptions(options);
    }

    /**
     * Private getter for header
     * 
     * @param header Header of the menu
     */
    private String getHeader()
    {
        return header;
    }

    /**
     * Private setter for header
     * 
     * @param header Header for the menu
     * @throws IllegalArgumentException if header is null
     */
    private void setHeader(String header)
    {
        // Don't allow null header
        if (header == null) {
            throw new IllegalArgumentException("Header cannot be null");
        }
        this.header = header;
    }

    /**
     * Private getter for feedback
     * 
     * @return feedback Feedback for the menu
     */
    private String getFeedback()
    {
        return feedback;
    }

    /**
     * Public setter for feedback
     * 
     * @param feedback Feedback for the menu
     */
    public void setFeedback(String feedback)
    {
        this.feedback = feedback;
    }

    /**
     * Private getter for lines
     * 
     * @param lines Lines to display first
     */
    private String[] getLines() {
        return lines;
    }

    /**
     * Setter for lines
     * 
     * @param lines Lines to display first
     */
    public void setLines(String[] lines) {
        this.lines = lines;
    }

    /**
     * Private getter for prompts
     * 
     * @param prompts Prompts for the user
     */
    private String[] getPrompts() {
        return prompts;
    }

    /**
     * Setter for prompts
     * 
     * @param prompts Prompts for the user
     */
    public void setPrompts(String[] prompts) {
        this.prompts = prompts;
    }

    /**
     * Public getter for options
     * 
     * @param options Menu options
     */
    public String[] getOptions() {
        return options;
    }

    /**
     * Setter for options
     * 
     * @param options Menu options
     */
    public void setOptions(String[] options) {
        this.options = options;
    }

    /**
     * Getter for promptResponses
     * 
     * @return promptResponses
     */
    public String[] getPromptResponses() {
        return promptResponses;
    }

    /**
     * Getter for the specific prompt response
     * 
     * @return the String of the prompt response
     * @throws IllegalArgumentException if index is out of bounds
     */
    public String getPromptResponse(int index) {
        if (index < 0 || index >= promptResponses.length) {
            throw new IllegalArgumentException("Index out of bounds");
        }
        return promptResponses[index];
    }

    /**
     * Getter for menuResponse
     * 
     * @return menuResponse
     */
    public int getMenuResponse() {
        return menuResponse;
    }

    /**
     * Display Menu
     * 
     * @return menuResponse - the user's menu response (or 0 if invalid)
     */
    public int display()
    {
        // Clear the screen
        UI.clearScreen();

        // If feedback isn't null, print the header and the feedback
        int titleLength = getHeader().length();
        if (getFeedback() != null) {
            System.out.println(getHeader() + " || " + getFeedback());
            // Also add the length of the feedback to the title length
            titleLength += getFeedback().length() + 4;
            // Clear feedback
            setFeedback(null);
        }
        // Otherwise, just print the header
        else {
            System.out.println(getHeader());
        }
        // Print a line of dashes equal to the length of the title
        for (int i = 0; i < titleLength; i++) {
            System.out.print("-");
        }
        // Line of padding
        System.out.println();

        // Display lines
        if (getLines() != null) {
            for (String line : getLines()) {
                System.out.println(line);
            }
            // Line of padding
            System.out.println();
        }

        // Display prompts
        if (getPrompts() != null) {
            promptResponses = new String[getPrompts().length];
            for (int i = 0; i < getPrompts().length; i++) {
                System.out.print(getPrompts()[i] + ": ");
                promptResponses[i] = UI.input.nextLine().trim();
                // SQL injection prevention on prompt responses
                promptResponses[i] = promptResponses[i].replace("'", "");
            }
            // Line of padding
            System.out.println();
        }

        // Display menu options
        for (int i = 0; i < getOptions().length; i++) {
            System.out.println((i + 1) + ". " + getOptions()[i]);
        }

        // Get user input
        menuResponse = 0;
        while (menuResponse < 1 || menuResponse > getOptions().length) {
            System.out.print("Enter your choice: ");
            try {
                menuResponse = Integer.parseInt(UI.input.nextLine());
                if (menuResponse < 1 || menuResponse > getOptions().length) {
                    System.out.println("Invalid choice. Please try again.");
                }
            } catch (NumberFormatException e) {
                menuResponse = 0;
                System.out.println("Invalid input. Please try again.");
            }
        }

        // Print menu response for debugging
        System.out.println("You chose: " + menuResponse);

        // Return the user's menu response
        return menuResponse;
    }

}
