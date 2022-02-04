def get_requirements():
    print("Square Feet to Acres")
    print("\nProgram Requirements:\n"
          + "1. Convert MPG.\n"
          + "2. Must use float data type for user input and calculation.\n"
          + "3. Format and round conversion to two decimal\n")

def convert_mpg():

    print("Input:")
    miles_driven = float(input('Enter miles driven: '))
    gallons_used = float(input('Enter gallons of fuel used: '))

    mpg_calculation = miles_driven / gallons_used

    print("\nOutput:")
    print("{:.2f}".format(miles_driven), "miles driven and ", "{:.2f}".format(gallons_used), "gallons used = ", "{:.2f}".format(mpg_calculation),"mpg")
