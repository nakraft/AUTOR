## Readme
Welcome to AUTOR. The following provides information about interacting with the CLI and database backend to meet project specifications. Any assumptions made not explicit in the requirements have been addressed here as well. 

### Contributors 

Natalie Kraft                               |   nakraft       
William Grochocinski                        |   wagrocho     
Ajith Kumar Vinayakamoorthy Patchaimayil    |   avinaya      
Aditya Srivastava                           |   asrivas7     
Leo Hsiang                                  |   yhsiang    

### Run Instructions 

- Connect to NCSU VPN or eduroam. 
- Open the folder containing `execution.jar`.
- Shift + right click in the folder, then hit `Open in Terminal` or equivalent.
- Enter `java -jar execution.jar` into the terminal and press enter. The terminal will load at this time
- Enter `3` and press the `Enter` key to enter the admin page.
- Enter `5` and press the `Enter` key to enter the more options page.
- Enter `1`, `2`, or `3` and press the 'Enter' key to populate the data to your requirements (see below for explaination).
- Enter `6` and press the `Enter` key to return to the admin page.
- Enter `4` and press the `Enter` key to logout and return to the main page.

__Populating Data__ 
To start over with a fresh database with tables, the ```setup.sql``` file will be ran. This flow can be conducted in the `Admin: More Options` menu within the CLI by selecting `1`. Ensure ```setup.sql``` is in the same folder as `execution.jar` before selecting this option.

To generate the tables and populate the database with the initial store setup, the ```populating_partial.sql``` file will be ran. This flow can be conducted in the `Admin: More Options` menu within the CLI by selecting `2`. Ensure ```setup.sql``` and ```populating_partial.sql``` are in the same folder as `execution.jar` before selecting this option.

To generate the tables and further populate the database with the entirity of the sample data, the ```populating_full.sql``` file will be ran sunsequently to the first scheme. This flow can be conducted in the `Admin: More Options` menu within the CLI by selecting `3`. This ensures the user has the ability to interact with a different database setup for testing purposes. Ensure ```base_logic.sql```, ```populating.sql```, and ```populating_full.sql``` are in the same folder as `execution.jar` before selecting this option.

__Navigation__ 
Every task can be completed through the frontend and backend of the CLI. 
To access the backend through SQL queries, visit the `Admin: More Options` menu and select `4`. These queries directly interact with the database. 

__Pre-Generated Queries__
All 6 pre-generated SQL commands can be accessed through the frontend of the program. To access these SQL commands, visit the `Admin: More Options` menu and select `4`. From there, you can select which SQL command you would like to run. The command as well as the output of the command is printed to the terminal.

### Overall Assumptions 
In order to maintain accuracy of application flow, some assumptions about the user input have been made. The following list of assumptions have been noted to ensure that we are aware of some of the limitations to our implementation. 

__Schedule__ 
- The day scheme is marked as {1: Monday, 2: Tuesday, ... 6: Saturday}. Sunday is not an option and restrictions are in place to not allow for Saturday when the service center is closed. 
- The available timeslots on Saturday are only {2, 3, 4} for 9:00, 10:00, 11:00. As the store (if open) hours end at 1:00 PM with a 12:00 - 1:00 lunch, only three slots are allowed for this date and the number matches the typical value expected for this time during any other day of the week.
- Only one month of data is generated in advance upon start up. 

__Mechanics__
- Only one mechanic can be assigned for a particular Service Job 
- It is assumed that once a mechanic takes time off they cannot cancel that time off and work that period again. 

### Corrections in Sample Data 
Based on our implementation, two of the entries of the sample data is inaccurate: 
- This is the invoice data for: Bruce Wayne (15DC9A87) for Week 2, Day 6, Time 2-8. As Day 6 is a Saturday, the time allotment is invalid. This sample has been removed due to the inconsistency.
- This is the invoice data for: Sam Wilson (29T56WC3) for Week 1, Day 1, Time 1-2. As this service requires a time of 2 hours, the scheduled time is too short. This sample has been extended by one hour to account for the inconsistency. 
