import java.util.*;

public class Methods {

  public static void getReqirements() {
    System.out.println("Skill Set 2");
    System.out.println("Developer: Sarah Huerta");
    System.out.println("\nProgram loops through array of floats.");

    System.out.println("Use following values: 1.0, 2.1, 3.2, 4.3, 5.4.");

    System.out.println("Use following loop structures: for, enhanced for, while, do...while.\n");

    System.out.println("Note: Pretest loops: for, enhanced for, while. Posttest loop: do...while.\n");
  };

  public static void arrayLoop() {
    float[] array = { 1.0f, 2.1f, 3.2f, 4.3f, 5.4f };

    System.out.println("for loop:");
    for (int i = 0; i < array.length; ++i) {
      // length is the property of the array
      System.out.println(array[i]);
    }

    System.out.println("\nEnhanced for loop:");
    for (float value : array) {
      System.out.println(value);
    }

    System.out.println("\nwhile loop:");
    int index = 0;
    while (index < array.length) {
      // get element
      float num = array[index];
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
};
