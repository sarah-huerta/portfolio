import java.util.*;

public class Methods {

  public static void getReqirements()
   {
    System.out.println("Skill Set 3");
    System.out.println("Developer: Sarah Huerta");
    System.out.println("Program swaps two user-entered floating-point values.");
    System.out.println("Create at least two user-defined methods: getReqirements and numSwap");
    System.out.println("Must perform data validation:numbers must be floats.");
    System.out.println("Print numbers before or after swapping\n");
  };

  public static void numSwap() {
    Scanner sc = new Scanner(System.in);
    float num1 = 0;
    float num2 = 0;

    System.out.print("Please enter the first number: ");
    while (!sc.hasNextFloat()) {
      System.out.println("Not vaild integer!\n");
      sc.next();
      System.out.print("Please try again. Enter first number: ");

    }
    num1 = sc.nextFloat();

    System.out.print("Please enter the second number: ");
    while (!sc.hasNextFloat()) {
      System.out.println("Not vaild integer!\n");
      sc.next();
      System.out.print("Please try again. Enter second number: ");

    }
    num2 = sc.nextFloat();

    System.out.println();


    swap(num1,num2);




  }

  public static void swap(float num1, float num2)
  {
    float temp = num1;

    System.out.println("Before Swap:");
    System.out.println("num1 = " +  num1);
    System.out.println("num2 = " +  num2);

    num1 = num2;

    num2 = temp;

    System.out.println("After Swap:");
    System.out.println("num1 = " +  num1);
    System.out.println("num2 = " +  num2);
  }
}
