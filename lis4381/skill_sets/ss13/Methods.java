import java.util.*;
import java.lang.Math;


public class Methods {
  public static void getReqirements() {
    System.out.println("Developer Sarah Huerta");
    System.out.println("Sphere Volume Program");
    System.out.println("Program calculates sphere volume in liquid U.S. gallons from user entered diameter in value in inches, and rounds to two decimal places.");
    System.out.println("2. Muse use Python's *built-in* PI and pow() capabilites.");
    System.out.println("3. Program checks for non-integers and non-numeric values.");
    System.out.println("4. Program continues to prompt for user entry until no longer requested, prompt accepts upper or lower case letters.");


}
 public static void calculate()
{
    Scanner sc = new Scanner(System.in);

    double pi = 3.14159265;
    double frac = 1.33333;
    double gal = 19.25317;
    char choice = ' ';

    boolean isNumeric = false;
    while(!isNumeric)
     try {
       do {


        System.out.print("\nPlease enter a diameter in inches: ");
        int diameter = sc.nextInt();
        sc.nextLine();
        isNumeric = true;

        double radius = diameter/2;
        double power = Math.pow(radius, 3);
        double ans = frac * pi * power;
        double feet = ans/12;
        double fin = feet/gal;


        Formatter formatter = new Formatter();
        formatter.format("%.2f", fin);
        System.out.println("Sphere volume: " + formatter.toString() + " liquid U.S. gallons.");
        System.out.print("Do you want to calculate another sphere volume(y or no)? ");
        choice = sc.next().charAt(0);
        choice = Character.toLowerCase(choice);
      } while (choice == 'y');

      } catch(InputMismatchException ime) {

     System.out.println("Not a vaild integer!");

     sc.nextLine();
    }

        System.out.println("Thanks for using Sphere Volume Calculator!");

  }
}
