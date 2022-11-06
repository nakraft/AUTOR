package autor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

public class ScanHelper {
    public static Scanner  scanner   = new Scanner( System.in );
    private static boolean wentCatch = false;

    public static int nextInt () {
        // scanner.nextLine();
        final int selection = 0;
        do {
            try {
                wentCatch = false;
                return scanner.nextInt();
            }
            catch ( final Exception e ) {
                e.printStackTrace();
                wentCatch = true;
                // scanner.nextLine();
                // System.out.println("Try again: ");
            }
        }
        while ( wentCatch );

        return selection;
    }

    public static String next () {
        try {
            wentCatch = false;
            return scanner.next();
        }
        catch ( final Exception e ) {
            e.printStackTrace();
            wentCatch = true;
            scanner.nextLine();
            System.out.println( "Try again: " );
        }
        return null;
    }

    public static Double nextDouble () {
        // scanner.nextLine();
        do {
            try {
                wentCatch = false;
                return scanner.nextDouble();
            }
            catch ( final Exception e ) {
                e.printStackTrace();
                wentCatch = true;
                scanner.nextLine();
                System.out.println( "Try again: " );
            }
        }
        while ( wentCatch );

        return 0.0;
    }

    public static String nextLine () {
        try {
            wentCatch = false;
            final String stringInput = scanner.nextLine();
            return stringInput;
        }
        catch ( final Exception e ) {
            e.printStackTrace();
            wentCatch = true;
            // scanner.nextLine();
            System.out.println( "Try again: " );
        }

        return null;
    }

    public static Date nextDate () {
        // scanner.nextLine();
        do {
            try {
                wentCatch = false;
                final SimpleDateFormat formatter = new SimpleDateFormat( "dd-MMM-yyyy" );
                final Date stringDate = formatter.parse( scanner.next() );
                // DateTimeFormatter formatter =
                // DateTimeFormatter.ofPattern("dd-MMM-yyyy HH:mm:ss");

                return stringDate;

            }
            catch ( final Exception e ) {
                e.printStackTrace();
                wentCatch = true;
                scanner.nextLine();
                System.out.println( "Try again: " );
            }
        }
        while ( wentCatch );
        return null;
    }
}
