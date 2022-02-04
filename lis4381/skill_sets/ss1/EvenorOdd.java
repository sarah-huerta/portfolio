import java.util.*;

public class EvenorOdd {
  public static void main(String[] args) {
    System.out.print("\nProgram evaluates integers as even or odd.\n");
    System.out.print("Note: Program does *not* check for non-numberic characters.\n");

    Scanner sc = new Scanner(System.in);
    System.out.print("\nEnter integer: ");
    int input = sc.nextInt();

    int evaluate = input % 2;
    if (evaluate == 0) {
      System.out.print(input + " is an even number");
    } else {
      System.out.print(input + " is an odd number");
    }

    System.out.print("\nExiting program thank you.\n");
  }
}

/*
 * import java.util.Scanner;
 *
 * public class InvoiceApp { public static void main(String[] args) { Scanner sc
 * = new Scanner(System.in); String choice = "y"; while (choice.equals("y")) {
 * System.out.print("Enter subtotal:   "); double subtotal = sc.nextDouble();
 * double salesTax = subtotal * .0875; double invoiceTotal = subtotal +
 * salesTax; String message = "Subtotal = " + subtotal + "\n" +
 * "   Sales tax = " + salesTax + "\n" + "Invoice total = " + invoiceTotal +
 * "\n\n"; System.out.println(message);
 * System.out.print("Continue? Enter y or n: "); choice = sc.next(); } } }
 */
