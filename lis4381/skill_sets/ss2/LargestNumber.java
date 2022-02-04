import java.util.*;

public class LargestNumber {
  public static void main(String[] args) {
    System.out.println("\nProgram Evaluates larget of two integers.");
    System.out.println("Note: Program does *not* check for non-number characters or non-integers values.");

    Scanner sc = new Scanner(System.in);

    System.out.print("\nEnter first integer: ");
    int first_int = sc.nextInt();

    System.out.print("Enter second integer: ");
    int second_int = sc.nextInt();

    if (first_int > second_int) {
      System.out.println(first_int + " is larger than " + second_int);
    } else {
      System.out.println(second_int + " is larger than " + first_int);
    }

    if (first_int == second_int) {
      System.out.println("the integers are equal\n");
    }
    System.out.println("\nexiting program, thank you.\n");
  }
}
