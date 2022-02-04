import java.util.*;

public class Methods {

  public static void getReqirements()
   {
    System.out.println("Skill Set 1");
    System.out.println("Developer: Sarah Huerta");
    System.out.println("Program lists system properties.");

  };

  public static void sysProp()
   {
    Properties prop = System.getProperties();

    String separator = System.getProperty("file.separator");
    System.out.println("System file path separator " + separator);

    System.out.println("Java Class Path: " + prop.getProperty("java.library.path"));

    System.out.println("Java Installation Path: " + prop.getProperty("java.home"));


    System.out.println ("Java Vendor Name : " + prop.getProperty("java.vendor"));


    System.out.println("Java Vendor URL: " + System.getProperty("java.vendor.url"));

    System.out.println("Java Version Number " + System.getProperty("java.version"));

    System.out.println("JRE Version " + System.getProperty("java.version"));

    System.out.println("OS arch : "+System.getProperty("os.arch"));

    System.out.println("OS name : "+System.getProperty("os.name"));


    System.out.println("OS version : "+System.getProperty("os.version"));

    String pathSeparator = System.getProperty("file.pathSeparator");
        System.out.println("User path separator: " + separator);

    String userdir = System.getProperty("user.dir");
    System.out.println("User Working Directory = " + userdir);

    String userhome = System.getProperty("user.home");
    System.out.println("User Home Directory = " + userhome);


    String username = System.getProperty("user.name");
    System.out.println("username = " + username);





  }

};
