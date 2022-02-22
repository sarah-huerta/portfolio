
import java.util.*;

public class Methods {

  public static void

   getReqirements() {
     System.out.println("Sarah Huerta");
  System.out.println("Program determines specific information with user entered text.");


  }

  public static void determineChar()
  {
    Scanner sc = new Scanner(System.in);
    System.out.println("Enter line of text:");
    String st = sc.nextLine();
    System.out.print("Enter character you would like to check: ");

    char ch = sc.next().charAt(0);



    System.out.println("The number of characters in the line of text is: " + st.length());

      int count=0;
      for(int i=0; i<st.length(); i++)
      {
          if(st.charAt(i) == ch)
          count++;
      }

    System.out.println("The character " + ch +  " appears " + count + " time(s) in line of text. " );

      System.out.println("ASCII value: " + (int)ch);
}}
