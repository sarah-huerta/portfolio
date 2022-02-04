import java.util.*;

public class Methods
{

  public static void getReqirements()
  {
    System.out.println("Developer Sarah Huerta");
    System.out.println("Temperature Conversion Program");
    System.out.println("Program Requirements: ");
    System.out.println("1. Program converts user-entered temperatures unto Fahrenheit or Celsius scales.");
    System.out.println("2. Program continues to prompt for user entry until no longer requested.");
    System.out.println("3. Note: upper or lower case letters permitted. Though, incorrect entries are not permitted.");
    System.out.println("4. Note: Program does not validate numeric data (optional Requirements)");
}

public static void convertTemp()
{
  Scanner sc = new Scanner(System.in);

    double temperature = 0.0;
    char choice = ' ';
    char type = ' ';


    do
    {
      System.out.println( "Fahrenheit to Celsius? Type \"f\", or Celsius to Fahrenheit? Type \"c\": ");
      type = sc.next().charAt(0);
      type = Character.toLowerCase(type);

        if(type == 'f')
        {
            System.out.print("Enter temperature in Fahrenheit: ");
            temperature = sc.nextDouble();
            temperature = ((temperature - 32)*5)/9;
            System.out.println( "Temperature in Celsius = " + temperature);
          }

        else if(type == 'c')
        {


          System.out.print("Enter temperature in Celsius: ");
            temperature = sc.nextDouble();
            temperature = (temperature * 9/5) + 32;
            System.out.println("Temperature in Fahrenheit = " + temperature);

          }

        else
        {
            System.out.println("Incorrect entry. Please try again.");
          }

            System.out.print("\nDo you want to convert a temperature (y or n)? ");
            choice = sc.next().charAt(0);
            choice = Character.toLowerCase(choice);
          }
          while (choice == 'y');

            System.out.print("\nThank you for using our Temperature Conversion Program!");
}
}
