
import java.util.*;

public class Methods {

  public static void getReqirements() {
    System.out.println("Developer: Sarah Huerta");
System.out.println("\t1. Write Applicaiton that displays integer equivalents of uppercase letters");
System.out.println("\t2. Display Character equivalents of ASCII values 48-122.");
System.out.println("\t3.Display character equivalents of ASCII value user input.");

}
  public static void getAscii()
  {
    int num = 0;
    boolean isValidNum = false;
    Scanner sc = new Scanner(System.in);
    System.out.println("Printing characters A-Z as ASCII values: ");
    for(char character = 'A'; character <= 'Z';character++)
    {
      System.out.printf("Character %c has ascii value %d\n", character, ((int )character));
    }
    System.out.println("\nAllowing user ASCII value Input: ");

    while(isValidNum == false)
    {
      System.out.print("Please enter ASCII value (32 - 127): " );
      if (sc.hasNextInt())
      {
        num = sc.nextInt();
        isValidNum = true;
      }
        else
        {
          System.out.println("Invalid integer--ASCII value must be a number. \n");
        }
        sc.nextLine();

        if(isValidNum == true && num < 32 || num > 127)
        {
        System.out.println("ASCII value must be >= 32 and <= 127.\n");
        isValidNum = false;
      }
      if (isValidNum == true)
      {
        System.out.println();

        System.out.printf("ASCII value %d has character value %c\n", num, ((char)num));
      }
    }
}
}
