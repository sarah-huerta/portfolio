
import java.util.*;
import java.math.*;
import java.text.*;
public class Methods {

  public static void getReqirements() {
System.out.println(" Developer Sarah Huerta");
System.out.println("1. Calculates amount of money saved for a period of years, at a *monthly* compounded interest rate.");

System.out.println("2. Returned amount is formatted in U.S. currency, and rounded to two decimal places.");
System.out.println("3. Must perform data validation: for non-numeric values, as well as only integer values for years.");

  }

  public static void getInterestValues()
   {
    Scanner sc = new Scanner(System.in);
    double principle = 0.0;
    double rate = 0.0;
    int time = 0;
    System.out.println("Current Princple: $");
    while(!sc.hasNextDouble())
    {
      System.out.println("Not a vaild number!\n");
      sc.next();
      System.out.print("Try again, enter principle: ");
    }
    principle = sc.nextDouble();


    System.out.println("interest Rate (per year): ");
    while(!sc.hasNextDouble())
    {
      System.out.println("Not a vaild number!\n");
      sc.next();
      System.out.print("Try again, rate: ");
    }
    rate = sc.nextDouble();
    rate = rate/100;

    System.out.println("Total Time in years: ");
    while(!sc.hasNextInt())
    {
      System.out.println("Not a vaild number!\n");
      sc.next();
      System.out.print("Try again, years: ");
    }
    time = sc.nextInt();
    sc.close();
    calculateInterest(principle, rate, time);

    }

    public static void calculateInterest(double p, double r, int t)
    {
      int n = 12;
      double i = 0.0;
      double a = 0.0;

      a = p * Math.pow(1 + (r/n), n * t);
      i = a -p;
      r = r * 100;

      NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.US);
System.out.println("\n Initial principle: " + nf.format(p));
System.out.printf("Annual interest rate: %.1f%%%n", r);
System.out.println("Total monthly compound interest after " + t + " years: " + nf.format(i));
System.out.println("Total amount: " + nf.format(a));


    }



  }
