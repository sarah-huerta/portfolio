
import java.util.*;

public class Methods {

  public static void getReqirements() {
    System.out.println("Program Requirements:");
    System.out.println("\t1. Counts number and types of characters from user-entered string.");
    System.out.println("\t2. Count: total, letters (upper/lower case), numbers, spacesm and other characters. ");
  }

  public static void counter() {
    Scanner sc = new Scanner(System.in);
    System.out.print("Enter String: ");
    String st = sc.nextLine();
    char[] ch = st.toCharArray();

    int letter = 0;
    int uLetter = 0;
    int lLetter = 0;
    int number = 0;
    int space = 0;
    int other = 0;
    int total = 0;

    total = st.length();

    for (int i = 0; i < st.length(); i++) {
      if (Character.isLetter(ch[i])) {
        if (Character.isUpperCase(ch[i]))
          uLetter++;
        if (Character.isLowerCase(ch[i])) {
          lLetter++;
        }
        letter++;
      }

      else if (Character.isDigit(ch[i]))
        number++;
      else if (Character.isSpaceChar(ch[i]))
        space++;
      else
        other++;
    }
    System.out.println("Total characters: " + total);
    System.out.println("Total Letters: " + letter);
    System.out.println("Total Upper Case: " + uLetter);
    System.out.println("Total Lower Case: " + lLetter);
    System.out.println("Total Numbers: " + number);
    System.out.println("Total Spaces: " + space);
    System.out.println("Total other: " + other);

  }
}
