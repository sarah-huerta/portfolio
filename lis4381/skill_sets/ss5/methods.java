import java.util.*;

public class methods {
  public static void nestedStructure() {

    Scanner sc = new Scanner(System.in);

    int[] test = { 3, 2, 4, 99, -1, -5, 3, 7 };
    System.out.println("\nArray Length: " + test.length);

    System.out.println("Enter search value: ");
    int val = sc.nextInt();

    for (int i = 0; i < test.length; i++)
    {
      if (test[i] == val) {
        System.out.println(val + " is found at index " + i);
      } else {
        System.out.println(val + " is *not* found at index " + i);
      }
    }
  }
}
