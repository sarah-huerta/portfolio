
import java.util.*;

public class Methods {

  public static void getReqirements()
  {


    System.out.println("Author: Mark K. Jowett, Ph.D.");
    System.out.println("Program Requirements: ");
    System.out.println("1. Create a string array (str1), based upon users\' number of preferred programming languages.");
    System.out.println("2. Create a second string arrav (str2) based upon the length of str1 array.");
    System.out.println("3. Copy str1 array elements into str2. ");
    System.out.println("4. Print elements of both arrays using Java's *enhanced* for loop. In");
  }

  public static String[] createArray() {
    Scanner sc = new Scanner(System.in);
    int arraySize = 0;
    System.out.print("How many favoriate programming languages do you have (min 1)?");
    while(!sc.hasNextInt())
    {
      System.out.println("Invaild input!\n");
      sc.next();
      System.out.print("Please try again, minimum of 1: ");
    }
    arraySize = sc.nextInt();

    while(arraySize < 1)
    {
      System.out.println("List must be greater than 0. Please enter number of fave languages: ");

      while(!sc.hasNextInt())
      {
        System.out.println("Invaild input!\n");
        sc.next();
        System.out.print("Please try again, minimum of 1: ");
      }
      arraySize = sc.nextInt();

    }

    String yourArray[] = new String[arraySize];
    return yourArray;
  }



  public static void copyArray(String[] str1)
   {
     Scanner sc = new Scanner(System.in);
     System.out.println("Please enter your" + str1.length + " favorite programming languages: ");
     for (int i = 0; i < str1.length; i++)
     {
       str1[i]=sc.nextLine();
     }
     String str2[] = new String[str1.length];
     int myCounter = 0;

     for(String myIterator: str1)
     {
       str2[myCounter++] = myIterator;
     }
     System.out.println();
     System.out.println("Printing str1 array: ");

     for(String myIterator: str1)
     {
       System.out.println(myIterator);
     }

     System.out.println("Printing str2 array: ");

     for(String myIterator: str2)
     {
       System.out.println(myIterator);
     }
     System.out.println();
     sc.close();
   }
}
