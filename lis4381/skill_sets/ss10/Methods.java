
import java.util.*;

public class Methods {

  public static void getReqirements() {
    System.out.println("Program populates ArrayList of Strings with user-entered animal type values.");
    System.out.println("Examples: Polar bear, Guinea pig, dog, cat, bird.");
    System.out.println("Program continues to collect user-entered values unil user types 'n'");
    System.out.println("Program displays Arraylist valyes after each itereation as well as size.");

  }

  public static void createArrayList()
   {
    Scanner sc = new Scanner(System.in);
    ArrayList<String> obj = new ArrayList<String>();
    String myStr = "";
    String choice = "y";
    int num = 0;

    while (choice.equals("y")) {
      System.out.print("Enter animal type: ");
      myStr = sc.nextLine();
      obj.add(myStr);
      num = obj.size();
      System.out.println("ArrayList elements:" + obj + "\nArravList Size = " + num);
      System.out.print("\nContinue? Enter y or n: ");
      choice = sc.next().toLowerCase();
      sc.nextLine();

    }

  }
}
