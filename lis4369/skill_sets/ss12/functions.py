def get_requirements():
    print("Developer Sarah Huerta")
    print("Temperature Conversion Program")
    print("Program Requirements: ")
    print("1. Program converts user-entered temperatures unto Fahrenheit or Celsius scales.")
    print("2. Program continues to prompt for user entry until no longer requested.")
    print("3. Note: upper or lower case letters permitted. Though, incorrect entries are not permitted.")
    print("4. Note: Program does not validate numeric data (optional Requirements)")

def temperature_conversion():

    temperature = 0.0
    choice = ' '
    type = ' '

    print( "Input:")
    choice = input("Do you want to convert a temperature (y or n)? ").lower()
    print("\nOutput:")

    while(choice == 'y'):
        type = input( "Fahrenheit to Celsius? Type \"f\", or Celsius to Fahrenheit? Type \"c\": ").lower()

        if type == 'f':
            temperature = float(input("Enter temperature in Fahrenheit: "))
            temperature = ((temperature - 32)*5)/9
            print( "Temperature in Celsius = " + str(temperature))
            choice = input("InDo you want to convert another temperature (y or n)? ").lower()

        elif type == 'c':
            temperature = float(input("Enter temperature in Celsius: "))
            temperature = (temperature * 9/5) + 32
            print("Temperature in Fahrenheit = " + str(temperature))
            choice = input( "\nDo you want to convert another temperature (y or n)? ").lower()

        else:
            print("Incorrect entry. Please try again.")
            choice = input("\nDo you want to convert a temperature (y or n)? ").lower()
            print("\nThank you for using our Temperature Conversion Program!")
