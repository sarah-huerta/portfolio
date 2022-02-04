import java.util.*;

public class ArrayLoops {
  public static void main(String[] args) {
    System.out.println("\nProgram loops through array of strings.");
    System.out.println("Use following values: kristoff, sven, anna, elsa, olaf.");
    System.out.println("Use following loop structures: for, enhanced for, while, do...while.\n");

    System.out.println("Note: Pretest loops: for, enhanced for, while. Posttest loop: do...while.\n");

    Scanner sc = new Scanner(System.in);
    String[] array = { "kristoff", "sven", "anna", "elsa", "olaf" };

    System.out.println("for loop:");
    for (int i = 0; i < array.length; i++) // length is the property of the array
      System.out.println(array[i]);

    System.out.println("\nEnhanced for loop:");

    for (String value : array) {
      System.out.println(value);
    }

    System.out.println("\nEnhanced for loop:");
    int index = 0;

    System.out.println("\nwhile loop:");
    while (index < array.length) {
      // get element
      String num = array[index];
      // work with element
      System.out.println(num);
      // increment index
      index++;
    }

    System.out.println("\ndo...while loop:");
    int i = 0;
    do {
      System.out.println(array[i]);
      i++;
    } while (i < array.length);

    System.out.println("\nexiting program, thank you.");
  }
}
