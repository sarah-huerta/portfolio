
import java.util.*;

public class Methods {

  public static void getReqirements() {
    System.out.println("Program determines whether user entered values is alpha, numeric, or special character.");

  }

  public static void determineChar()
  {
    Scanner sc = new Scanner(System.in);
    System.out.print("Enter character: ");
    char ch = sc.next().charAt(0);


    if((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))
    {

      System.out.println(ch + " is alpha. ASCII value: " + (int)ch);
    }
    else if(ch >= '0' && ch <= '9')
    {
      System.out.println(ch + " is numeric. ASCII value: " + (int) ch);
    }
    else
     {
      System.out.println(ch + " is special character. ASCII value: " + (int) ch);
    }
  }
}
