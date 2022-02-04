import java.util.*;

public class Methods {

  static final Scanner sc = new Scanner(System.in);

  public static void getReqirements() {

    System.out.println("Developer: Sarah Huerta");
    System.out.println("1. Program creates array size at run-time.");
    System.out.println("2. Program displays array size.");
    System.out.println("3) Porgram rounds sum and average of numbers to two decimal places.");
    System.out.println("4) Numers *must* be float data type, not double.\n");
  };

public static int validateArraySize()
{

  int arraySize = 0;

  System.out.print("Please enter array size: ");

    while (!sc.hasNextInt())
    {
      System.out.println("Not vaild integer!\n");
      sc.next();
      System.out.print("Please try again. Enter array size: ");
      }
      arraySize = sc.nextInt();
      System.out.println();



    return arraySize;
  };

public static void calculateNumbers(int arraySize)
{
  float sum = 0.0f;
  float average = 0.0F;

  System.out.print("Please enter " + arraySize + " numbers.\n");

  float numsArray[] = new float[arraySize];

  for(int i = 0; i < arraySize; i++)
  {
    System.out.print("Enter num" + (i+1) + ": ");

    while(!sc.hasNextFloat())
    {
      System.out.print("Not a vaild number!\n");
      sc.next();
      System.out.print("Please try again. Enter num" + (i+1) + ": ");

    }

    numsArray[i] = sc.nextFloat();
    sum = sum + numsArray[i];

  }
  average = sum / arraySize;


  System.out.print("\nNumbers entered: ");
  for (int i = 0; i < numsArray.length; i++)
    System.out.print(numsArray[i]+" ");

    printNumber(sum,average);

}
public static void printNumber(float sum, float average)
{
  System.out.println("\nSum: "+ String.format("%.2f",sum));
  System.out.println("Average: " + String.format("%.2f", average));

}
}
