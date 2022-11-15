## Readme
Welcome to AUTOR. The following provides information about interacting with the CLI and database backend to meet project specifications. Any assumptions made not explicit in the requirements have been addressed here as well. 

### Contributors 

Natalie Kraft                               |   nakraft       
William Grochocinski                        |   wagrocho     
Ajith Kumar Vinayakamoorthy Patchaimayil    |   avinaya      
Aditya Srivastava                           |   asrivas7     
Leo Hsiang                                  |   yhsiang    

### Compilation Instructions 

- After downloading the program, open the project base in VS Code. 
- Ensure you have the appropriate extentions downloaded to be able to run the source code. This includes the Extension Pack for Java. 
- Connect to NCSU VPN or eduroam. 
- Ensure credentials (can be found in JDBC.java) are accessible by the user. 
- Navigate to the AUTOR.java page. 
- Above the main method in the AUTOR.java code, click the ```run``` button to begin the program. A shell will open with the CLI to be interacted with. 
- Enter admin menu to reset database. 
- Select 5 or 6 to populate the data to your requirements (see below for explaination). 

__Populating Data__ 
To populate the database with the initial store setup, the ```populating.sql``` will be ran. This flow can be conducted in the admin platform within the CLI by selecting `5`. 

To further populate the database with the entirity of the sample data, the ```populating_full.sql``` will be ran sunsequently to the first scheme. This flow can be conducted in the admin platform within the CLI by selecting `6`. This ensures the user has the ability to interact with a different database setup for testing purposes.

__Navigation__ 
Every task can be completed through the frontend and backend of the CLI. 
To access the backend through SQL queries, visit the admin menu and select `7`. These queries directly interact with the database and show a log of errors. 

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
