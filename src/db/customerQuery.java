package db;

import ui.UI;
import java.sql.*;

// Import array list
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

/**
 * Queries for customers
 */
public class customerQuery {
    
    /**
     * Retrieve customer profile using eid and sid from UI
     * 
     * @return String[] of customer profile
     */
    public static String[] getProfile() {
        // Create a query
        String query = "SELECT * FROM Customer WHERE cid = '" + UI.getCurrentEID() + "' AND sid = '" + UI.getCurrentSID() + "'";
        // Run the query
        try {
            ResultSet result = JDBC.executeQuery(query);
            // If there is a result, return it as an array
            if (result.next()) {
                // Create an array to hold the result
                String[] profile = new String[5];
                // Add the result to the array
                // Customer ID
                profile[0] = result.getString("cid");
                // Full Name
                profile[1] = result.getString("first_name") + " " + result.getString("last_name");
                // Address
                profile[2] = result.getString("address");
                // Email address
                profile[3] = result.getString("email");
                // Phone number
                profile[4] = result.getString("phone");
                // Return the array
                return profile;
            }
            return null;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    /**
     * Retrieve customer vehicles using eid and sid from UI
     */
    public static String[][] getVehicles() {
        // Create a query
        String query = "SELECT * FROM Vehicle WHERE cid = '" + UI.getCurrentEID() + "' AND sid = '" + UI.getCurrentSID() + "'";
        // Run the query
        try {
            ResultSet result = JDBC.executeQuery(query);
            // Create an array list to hold the result
            ArrayList<String[]> vehicles = new ArrayList<String[]>();
            // Return the list of vehicles as a 2d array
            while (result.next()) {
                // Create an array to hold the result
                String[] vehicle = new String[4];
                // VIN
                vehicle[0] = result.getString("vin");
                // Make
                vehicle[1] = result.getString("manf");
                // Model
                vehicle[2] = result.getString("mileage");
                // Year
                vehicle[3] = result.getString("year");
                // Add array to the list
                vehicles.add(vehicle);
            }
            // If there is a result, return it as an array
            if (vehicles.size() > 0) {
                // Convert the array list to an array
                return vehicles.toArray(new String[vehicles.size()][]);
            }
            return null;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    public static boolean validateVehicle(String Vin) {
        String query = "select * from Vehicle where vin='"+Vin+"' AND cid='"+UI.getCurrentEID()+"'";
        try {
            ResultSet result = JDBC.executeQuery(query);
            if (result.next()) {
                return true;
            }
            return false;
        }
        catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }
    public static String[][] getServiceHistory(String Vin) {
        // Create a query
        String query = "SELECT I.id, I.vin, I.total_amount, CONCAT(CONCAT(E.first_name, ' '), E.last_name) AS mechanic_name, CONCAT(CONCAT(I.start_timeslot_day, ', '), I.start_timeslot_week) AS start_time, CONCAT(CONCAT(I.end_timeslot_day, ', '), I.end_timeslot_week) AS end_time from Invoice  I, Employee  E where E.eid = I.eid AND I.vin='"+Vin+"'";
         // in (SELECT vin from Vehicle where cid="+UI.getCurrentEID() + " AND sid="+UI.getCurrentSID() +" )";
        // Run the query
        try {
            ResultSet result = JDBC.executeQuery(query);
            // Create an array list to hold the result
            ArrayList<String[]> serviceHistory = new ArrayList<String[]>();
            // Return the list of vehicles as a 2d array
            while (result.next()) {
                // Create an array to hold the result
                String[] history = new String[6];
                // id
                history[0] = result.getString("id");
                // vin
                history[1] = result.getString("vin");
                // total amount
                history[2] = result.getString("total_amount");
                // mechanic name
                history[3] = result.getString("mechanic_name");
                // start time
                history[4] = result.getString("start_time");
                // end time
                history[5] = result.getString("end_time");
                // Add array to the list
                serviceHistory.add(history);
            }
            // If there is a result, return it as an array
            if (serviceHistory.size() > 0) {
                // Convert the array list to an array
                return serviceHistory.toArray(new String[serviceHistory.size()][]);
            }
            return null;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }


    /* 
     * Get eligible maintenance 
    */
    public static String[] getEligibleMaintenance(String Vin) {
        // Get the next schedule name
        String query = "SELECT SCHEDULE AS CURRENT_SCHEUDLE, CASE WHEN SCHEDULE= 'A' THEN 'B' WHEN SCHEDULE= 'B' THEN 'C' ELSE 'A' END AS NEXT_SCHEDULE FROM VEHICLE WHERE VIN='" + Vin + "'";
        //String query = "SELECT Schedule FROM Vehicle WHERE VIN='" + Vin + "'";
        String nextSchedule = null;
        String nextScheduleNumber = null;
        try {
            ResultSet result = JDBC.executeQuery(query);
            while (result.next()) {
                nextSchedule = result.getString("NEXT_SCHEDULE");}
            if (nextSchedule == null) {nextSchedule = "A";}
            // get schedlenmber for the schedule 
            String scheduleNumberQuery = "SELECT * FROM Schedule WHERE serviceName = '" + nextSchedule + "'";
            ResultSet res = JDBC.executeQuery(scheduleNumberQuery);
            while (res.next()) {
                nextScheduleNumber = res.getString("serviceNumber");}
            String[] temp = {"",""};
            temp[0] = nextSchedule;
            temp[1] = nextScheduleNumber;
            return temp;
        } catch (SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return null;
    }
    }

    // get services for the category

    public static ArrayList<String[]> getServicesForCategory(String category) {
        String query = "SELECT DISTINCT serviceName, serviceNumber FROM Services WHERE repair_category='"+category +"' AND schedule is NULL";
        try {
            ResultSet result = JDBC.executeQuery(query);
        ArrayList<String[]> services = new ArrayList<String[]>();
        while (result.next()) {
            String[] service = new String[2];
            service[0] = result.getString("serviceName");
            service[1] = result.getString("serviceNumber");
            services.add(service);
        }
        // If there is a result, return it as an array
        if (services.size() > 0) {
            // Convert the array list to an array
            return services;
        }
        } catch (SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return null;}
        
        return null;
    }

    public static String getScheduleCost(String scheduleName, String scheduleNumber, String Vin) {
        String query = "SELECT PRICE from Cost_details WHERE serviceName='" + scheduleName +"' AND serviceNumber='"+ scheduleNumber + "' AND sid='" + UI.getCurrentSID() + "' AND manf=(SELECT TRIM(manf) AS manf from Vehicle where vin='"+Vin+"')";
        try {
            String scheduleCost =null;
            ResultSet res = JDBC.executeQuery(query);
            while (res.next()) {
                scheduleCost = res.getString("PRICE");
                return scheduleCost;}
            return scheduleCost;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;}
    }

    public static String[] getCartCostDur(String querystr, String Vin) {
        
        String querycost = "SELECT SUM(price) AS PRICE FROM Cost_Details WHERE (serviceName, serviceNumber) in (" + querystr +") AND sid='"+ UI.getCurrentSID() + "' AND manf=(SELECT TRIM(manf) AS manf from Vehicle where vin='"+Vin+"')";
        String querydur = "SELECT SUM(dur) AS DUR FROM Duration_Details WHERE (serviceName, serviceNumber) in (" + querystr +") AND manf=(SELECT TRIM(manf) AS manf from Vehicle where vin='"+Vin+"')";
        try {
            String cartCost =null, cartDur =null;;
            ResultSet res = JDBC.executeQuery(querycost);
            while (res.next()) {
                cartCost = res.getString("PRICE");
            }
            res = JDBC.executeQuery(querydur);
            while (res.next()) {
                cartDur = res.getString("DUR");
            }
            String[] temp = new String[2];
            temp[0] = cartCost;
            temp[1] = cartDur;
            return temp;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;}
    }

    public static ArrayList<String[]> getTimeSlots(String Vin, String duration) {
        ArrayList<String[]> timeSlots = new ArrayList<>();
        try {
            String query = "SELECT * FROM Calendar c WHERE c.sid = " + UI.getCurrentSID() + " AND c.invoice_id IS NULL AND (SELECT COUNT(c2.id) FROM Calendar c2 WHERE c2.sid = c.sid AND c2.eid = c.eid AND c2.id >= c.id AND c2.id <= c.id + "+duration+" AND c2.invoice_id IS NULL) = "+duration+" ORDER BY c.timeslot_week, c.timeslot_day, c.timeslot, c.eid";
            ResultSet res = JDBC.executeQuery(query);
            if (res==null) {
                return null;
            }
            while (res.next()) {
                String[] ts = new String[5];
                ts[0] = res.getString("timeslot_day");
                ts[1] = res.getString("timeslot_week");
                ts[2] = res.getString("timeslot");
                ts[3] = res.getString("eid");
                ts[4] = res.getString("id");
                timeSlots.add(ts);
            }
            return timeSlots;
        }
        catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
    public static boolean mechanic_overwork(String[] timeSlot, String duration){
            String end_timeslot_week="",end_timeslot_day="",end_timeslot="";
        try {
            String query1 = "SELECT timeslot_week,timeslot_day,timeslot,eid FROM Calendar WHERE id = " + String.valueOf(Integer.parseInt(timeSlot[4]) +  Integer.parseInt(duration) - 1) + " and eid = " + timeSlot[3] +" AND sid = " + UI.current_sid;
            ResultSet result = JDBC.executeQuery(query1);
            while(result.next()) {
                end_timeslot_week = result.getString("timeslot_week");
                end_timeslot_day = result.getString("timeslot_day");
                end_timeslot = result.getString("timeslot");
            }
            //get the two timeslot values 
            int start_id = 0, end_id = 0;
            String query3 = "SELECT id FROM Calendar" +
            " WHERE timeslot_week = " + timeSlot[1] +
            " AND timeslot_day = " + timeSlot[0] +
            " AND timeslot = " + timeSlot[2]  +
            " AND eid = " + timeSlot[3] +
            " AND sid = " + UI.getCurrentSID();
            ResultSet result1 = JDBC.executeQuery(query3);
            if(result1.next()) {
                start_id = result1.getInt("id");
            }
            String query4 = "SELECT id FROM Calendar" +
            " WHERE timeslot_week = " + end_timeslot_week +
            " AND timeslot_day = " + end_timeslot_day +
            " AND timeslot = " + end_timeslot  +
            " AND eid = " + timeSlot[3] +
            " AND sid = " + UI.getCurrentSID();
            ResultSet result2 = JDBC.executeQuery(query4);
            if(result2.next()) {
                end_id = result2.getInt("id");
            }
            // ensures that if this got scheduled with this mechanic, the mechanic wouldn't be working more than the required time a week 
            // you cannot use having here as there is no way to evaluate how many hours to be worked were attributed to a particular week 
            for(int week_number = Integer.parseInt(timeSlot[1]); week_number <= Integer.parseInt(end_timeslot_week); week_number++){
                int hoursworked = 0, hoursToWork = 0;
                String query5 = "SELECT COUNT(*) as hoursWorked FROM Calendar o WHERE o.eid = " + timeSlot[3] + " AND o.sid = " + UI.getCurrentSID() + " AND o.timeslot_week = " + week_number + " AND o.invoice_id IS NOT NULL";
                ResultSet result3 = JDBC.executeQuery(query5);
                if(result3.next()) {
                    hoursworked = result3.getInt("hoursWorked");
                }
                String query6 = "SELECT COUNT(*) as hoursToWork FROM Calendar o WHERE o.eid = " + timeSlot[3] + " AND o.sid = " + UI.getCurrentSID() + " AND o.timeslot_week = " + week_number + " AND id >= " + start_id + " AND id <= " + end_id;
                ResultSet result4 = JDBC.executeQuery(query6);
                if(result4.next()) {
                    hoursToWork = result4.getInt("hoursToWork");
                }
                if(hoursworked + hoursToWork > 50){
                    return false;
                }
            }
        }
        catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
            return true;
    }

    public static Integer customerCartCheckout(String Vin, String[] timeSlot, String cost, String duration, HashSet<String> cart, HashMap<String, String> serviceMapping ) {
        // insert into invoice has service
        String invoiceID = "1";
        try{
            // generate id for invoice
            ResultSet result = JDBC.executeQuery("SELECT MAX(id) AS id FROM Invoice_HasService");
            while(result.next()) {
                invoiceID = result.getString("id");
                invoiceID = String.valueOf(Integer.parseInt(invoiceID) + 1);
            }

            // insert into invoice has schedule

            // insert into invoice
            // gives the ending timeslot1
           
            String end_timeslot_week="",end_timeslot_day="",end_timeslot="";
            String query1 = "SELECT timeslot_week,timeslot_day,timeslot,eid FROM Calendar WHERE id = " + String.valueOf(Integer.parseInt(timeSlot[4]) +  Integer.parseInt(duration) - 1) + " and eid = " + timeSlot[3] +" AND sid = " + UI.current_sid;
            result = JDBC.executeQuery(query1);
            while(result.next()) {
                end_timeslot_week = result.getString("timeslot_week");
                end_timeslot_day = result.getString("timeslot_day");
                end_timeslot = result.getString("timeslot");
            }

            // invoice has service query

            String querystr = "INSERT ALL ";
            for(String ele:cart) {
            querystr += "INTO Invoice_HasService ( id, serviceName, serviceNumber ) VALUES ( "+invoiceID+",'"+ele+"'," + serviceMapping.get(ele) + ") ";
            }
            querystr += " SELECT * FROM DUAL";
            int response = JDBC.executeUpdate(querystr);
            if(response <= 0) {
                return -1;
            }
            String query2 = "INSERT INTO Invoice(id,sid,eid,cid,start_timeslot_week,start_timeslot_day,start_timeslot,end_timeslot_week,end_timeslot_day,end_timeslot,vin, total_amount)  VALUES (" + invoiceID + ", " + UI.getCurrentSID() + ", "+ timeSlot[3] +", "+ UI.getCurrentEID() +", " + timeSlot[1] + ", " + timeSlot[0] + ", " + timeSlot[2] + ", " + end_timeslot_week + ", " + end_timeslot_day + ", " + end_timeslot + ", '" + Vin + "', "+cost+")";
            JDBC.executeUpdate(query2);
             return Integer.parseInt(invoiceID);
            
        }
        catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return -1;
            
        }
    }

    public static String[] getInvoice(String invoice_id) {
        String[] invoice = new String[10];
        try {
            String query = "SELECT i.cid AS cid,i.vin AS vin,i.status AS status,CONCAT(CONCAT(e.first_name,' '),e.last_name) AS name,i.total_amount AS total_amount,i.start_timeslot_day AS start_timeslot_day,i.start_timeslot_week AS start_timeslot_week,TRIM(v.manf) AS manf FROM Invoice i CROSS JOIN Employee e CROSS JOIN Vehicle v WHERE i.eid = e.eid and i.vin = v.vin and i.cid = "+ UI.getCurrentEID() +" and i.sid = " + UI.getCurrentSID() +" and i.id = " + invoice_id;
            ResultSet res = JDBC.executeQuery(query);
            while (res.next()) {
                invoice[0] = invoice_id;
                invoice[1] = res.getString("cid");
                invoice[2] = res.getString("vin");
                invoice[3] = "Week:" + res.getString("start_timeslot_week") + " Day:" + res.getString("start_timeslot_day"); // service date
                invoice[4] = ""; // service ids
                invoice[5] = ""; // service types
                invoice[8] = ""; // cost for each service
                invoice[6] = (res.getString("status").equals("0")) ? "Unpaid" : "Paid"; // invoice status
                invoice[7] = res.getString("name"); // mechanics name
                invoice[9] = res.getString("total_amount"); // total cost
                String query2 = "Select cd.serviceNumber as snum,cd.price as price,s.repair_category as rcat,s.schedule as sch from Invoice_HasService ihs CROSS JOIN Cost_Details cd CROSS JOIN Services s where ihs.serviceName=s.serviceName AND ihs.serviceNumber=s.serviceNumber AND ihs.serviceName=cd.serviceName AND ihs.serviceNumber=cd.serviceNumber AND ihs.id=" + invoice_id +" AND cd.sid="+ UI.current_sid +" AND cd.manf='"+res.getString("manf")+"'";
                ResultSet res2 = JDBC.executeQuery(query2);
                String query3 = "Select cd.serviceNumber as snum,cd.price as price,s.repair_category as rcat,s.schedule as sch from Invoice_HasService ihs CROSS JOIN Cost_Details cd CROSS JOIN Services s where ihs.serviceName=s.schedule AND ihs.serviceNumber=s.serviceNumber AND ihs.serviceName=cd.serviceName AND ihs.serviceNumber=cd.serviceNumber AND ihs.id=" + invoice_id +" AND cd.sid="+ UI.current_sid +" AND cd.manf='"+res.getString("manf")+"'";
                ResultSet res3 = JDBC.executeQuery(query3);
                while (res2.next()) {          
                    String stype = "Repair and maintenance service";
                    invoice[4] += ("\n"+res2.getString("snum"));      
                    invoice[8] += ("\n"+res2.getString("price")); 
                    if(res2.getString("rcat") == null) {
                        stype = "Maintenance service";
                    }
                    else if(res2.getString("sch") == null) {
                        stype = "Repair service";
                    }
                    invoice[5] += ("\n"+stype);
                }
                while (res3.next()) {          
                    invoice[4] += ("\n"+res3.getString("snum"));      
                    invoice[8] += ("\n"+res3.getString("price")); 
                    invoice[5] += ("\nMaintenance schedule"); 
                    break; // don't loop for all services within schedule. remove if individual service names needed.
                }
                return invoice;
            }
            return null;
        }
        catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    /**
     * Add Car to the database
     * 
     * @param String[] Vehicle information (vin, manf, mileage, year)
     * @return boolean true if successful, false if not
     */
    public static boolean addVehicle(String[] information) {
        String query1 = "Select * from Vehicle where vin = '"+information[0]+"'";
        String query = "INSERT INTO vehicle (vin, manf, mileage, year, cid, sid) VALUES ('" + information[0] + "', '" + information[1] + "', '" + information[2] + "', '" + information[3] + "', '" + UI.getCurrentEID() + "', '" + UI.getCurrentSID() + "')";
        // Run the query
        try {
            ResultSet result = JDBC.executeQuery(query1);
            if (result.next()) {
            return false;
            }   
            boolean response = JDBC.executeQuery(query).next();
            return response;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
        catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Delete car from the database
     *
     * @param String VIN of the car to delete
     * @return boolean true if successful, false if not
     */
    public static boolean deleteVehicle(String vin) {
        String query1 = "Select * from Vehicle where vin = '"+vin+"'";
        String query = "DELETE FROM vehicle WHERE vin = '" + vin + "' AND cid = '" + UI.getCurrentEID() + "' AND sid = '" + UI.getCurrentSID() + "'";
        try {
            ResultSet result = JDBC.executeQuery(query1);
            if (!result.next()) {
                return false;
            }  
            return (JDBC.executeUpdate(query) > 0);
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return false;
        }
    }

    public static String[] getInvoiceStatus(String invoice_id) {
        String query = "SELECT * FROM Invoice where id='"+invoice_id+"'";
        String[] invoice_details = new String[3];
        try {
            ResultSet result = JDBC.executeQuery(query);
            while (result.next()) {
                invoice_details[0] = result.getString("total_amount");
                invoice_details[1] = result.getString("amount_paid");
                invoice_details[2] = result.getString("Status");
                return invoice_details;
            }
            return null;
        } catch (SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return null;
    }
    }

    public static boolean payInvoice(String invoice_id) {
        String query = "UPDATE Invoice SET amount_paid=total_amount, status=1 where id='"+invoice_id+"'";
        
        try {
            if (JDBC.executeUpdate(query) <= 0) {
                throw new java.sql.SQLException("Error updating duration details");
            }
            return true;
        } catch(SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return false;
    }
    }

}
