public class Car extends Vehicle
{

    //Create Method without returning any value (without object)
    private float speed;

      public Car()
      {
        super();
        System.out.println("\nInside car default constructor.");
        speed = 100;
      }

       public Car(String m, String d, int y, float s)
       {
         super(m, d, y);
         System.out.println("\nInside car constructor with parameters.");
         speed = s;
       }

        public double getSpeed()
        {
          return speed;
        }

        public void setSpeed(float s)
        {
          speed = s;
        }

        public void print()
        {
          super.print();
          System.out.println(",Speed: " + speed);
        }
        }
