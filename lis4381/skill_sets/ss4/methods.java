import java.util.*;

public class methods {
  public static void decisionStructure() {

    Scanner sc = new Scanner(System.in);

    System.out.println("Phone types: W or w (work), C or c (cell), H or h (home), N or n (none).");
    System.out.print("\nEnter phone type: ");

    char choice = sc.next().charAt(0);
    choice = Character.toLowerCase(choice);
    System.out.println("if...else");
    if(choice == 'w')
    {
      System.out.println("Phone type: work");
    }
    else if(choice == 'c')
    {
      System.out.println("Phone type: cell");
    }
    else if(choice == 'h')
    {
      System.out.println("Phone type: home");
    }

    else if(choice == 'n')
    {
      System.out.println("Phone type: none");
    }
    else
    {
      System.out.println("Incorrect Character entry.");
    }

    System.out.println("\nswitch:");
    switch (choice)
    {
    case 'w':

      System.out.println("Phone type: work");
      break;

    case 'c':

      System.out.println("Phone type: cell");
      break;

    case 'h':

      System.out.println("Phone type: home");
      break;

    case 'n':

      System.out.println("Phone type: none");
      break;

    default:
      System.out.println("Incorrect character entry.");





    }
  }
}
