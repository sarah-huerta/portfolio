import java.util.*;

public class Methods {
  public static void getReqirements() {

    System.out.println("1) getReqirements(): Void method displays program requirements.");
    System.out.println(
        "2) getUserInput(): Void method prompts for user input,\n\t then calls two methods: myVoidMethod() and myValueReturningMethod().");
    System.out.println(
        "3) myVoidMethod(): \n\t a. Accepts two arguments: String and int. \n\t b. Prints user's first name and age.");
    System.out.println(
        "4) myValueReturningMethod():\n\t a. Accepts two arguments: String and int. \n\t b. Returns String containing first name and age.");
  };

  public static void getUserInput() {
    Scanner sc = new Scanner(System.in);

    System.out.print("Enter first name: ");

    String name = sc.next();

    System.out.print("\nEnter age: ");
    int age = sc.nextInt();

    myVoidMethod(name, age);
    System.out.println(myValueReturningMethod(name, age));
  };

  public static void myVoidMethod(String name, int age) {

    System.out.println("\nvoid method call: " + name + " is " + age);
  };

  public static String myValueReturningMethod(String name, int age) {

    String methodReturn = "value returning method call: " + name + " is " + age;

    return methodReturn;

  };

};
