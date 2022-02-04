def get_requirements():
    print("Square Feet to Acres")
    print("\nProgram Requirements:\n"
          + "1. Research: number of square feet to acre of land. \n"
          + "2. Must use float data type for user input and calculation.\n"
          + "3. Format and round conversion to two decimal places.\n")

def calculate():

    conversion_factor = 43560

    print("Input:")
    squ_feet = float(input('Enter square feet: '))

    acres = squ_feet / conversion_factor

    print("\nOutput:")
    print("{:,.2f}".format(squ_feet), "square feet = ", "{:.2f}".format(acres), "acres")
          #"{1:,.2f}".format(acres))
