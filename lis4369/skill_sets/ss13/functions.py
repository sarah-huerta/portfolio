import math as m

def get_requirements():
    print("Sphere Volume Program")
    print("Developer: Sarah Huerta")

    print("\nProgram Requirements:")
    print("Program calculates sphere volume in liquid U.S. gallons from user entered diameter in value in inches, and rounds to two decimal places.")
    print("2. Muse use Python's *built-in* PI and pow() capabilites.")
    print("3. Program checks for non-integers and non-numeric values.")
    print("4. Program continues to prompt for user entry until no longer requested, prompt accepts upper or lower case letters.")

def calculate():
    pi = 3.14159265;
    di = 0.0
    frac = 1.33333;
    gal = 19.25317;
    choice = ' '
    ans = 0;

    print("Input: ")
    choice = input("Do you want to calculate a sphere volume (y or n)? ").lower()

    print("Output: ")

    while(choice == 'y'):
        while True:
          try:
              dia = int(input("Please enter diameter in inches (integers only): "))
              dia = dia*.5

              ans = (((m.pow(dia,3))*frac*pi)/12)/gal
              ans = str(round(ans, 2))
              print("Sphere volume: " + ans + " liquid U.S. gallons.")

              choice = input("Do you want to calculate a sphere volume (y or n)? ")

          except ValueError:
             print("Not an integer! Try again.")
             continue
          else:
             break
    else:
        print("Thanks for using our Calculator!")
