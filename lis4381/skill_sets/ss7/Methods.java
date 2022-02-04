import java.util.*;

public class Methods {
  public static void getReqirements() {
    System.out.println("Developer: Sarah Huerta");
    System.out.println("Print minimum andmaximum integer values.");
    System.out.println("Program prompts user to enter desired number of pseudorandom-generated integers (min 1).");
    System.out.println("Use following loop structures: for, enhanced for,while, do...while.");

    System.out.println("Integer.MIN_VALUE = -2147483648");
    System.out.println("Integer.MAX_VALUE = 2147483647");

  };

  public static int[] createArray() {
    Scanner sc = new Scanner(System.in);
    int arraySize = 0;

    System.out.print("Enter desired number of pseudo-random integers (min 1): ");
    while (!sc.hasNextInt()) {
      System.out.println("Not vaild integer!");
      sc.next();
      System.out.print("Please try again.Enter vaild integer (min 1): ");

    }
    arraySize = sc.nextInt();

    while (arraySize < 1) {
      System.out.print("\nNumber must be greater than 0. Please enter integer greater than 0: ");
      while (!sc.hasNextInt()) {
        System.out.println("Number must be integer: ");
        sc.next();
        System.out.print("Please try again. Enter vaild integer greater than 0: ");

      }
      arraySize = sc.nextInt();
    }
    int yourArray[] = new int[arraySize];
    return yourArray;
  };

  public static void generatePseudoRandomNumbers(int[] myArray) {

    Random r = new Random();
    int i = 0;

    System.out.println("for loop: ");
    for (i = 0; i < myArray.length; i++) {
      System.out.println(r.nextInt());
    }

    System.out.println("\nEnhanced for loop: ");
    for (int n : myArray) {
      System.out.println(r.nextInt());
    }

    System.out.println("\nwhile loop: ");
    i = 0;
    while (i < myArray.length) {
      System.out.println(r.nextInt());
      i++;
    }

    System.out.println("\ndo...while loop: ");
    i = 0;
    do {
      System.out.println(r.nextInt());
      i++;
    } while (i < myArray.length);

  }
};
