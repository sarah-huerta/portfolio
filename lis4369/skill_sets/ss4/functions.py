def get_requirements():
    print("Calorie Calculator ")
    print("\nDeveloper: Sarah Huerta\n")
    print("\nProgram Requirements:\n"
          + "1. Find calories per grams of fat,carbs, and protien.\n"
          + "2. Calculate Percentage.\n"
          + "3. Must use float data types.\n"
          + "4. Format, right-align numbers, and round to two decimal places.\n")

def calculations():
        print("Input:")
        fat = float(input('Enter total fat grams: '))
        carb = float(input('Enter total carb grams: '))
        protien = float(input('Enter total protien grams: '))

        total_fat_calories = fat*9
        total_carb_calories = carb*4
        total_protien_calories = protien*4
        total_calories = total_fat_calories + total_carb_calories +total_protien_calories

        fat_percentage = total_fat_calories / total_calories
        carb_percentage = total_carb_calories / total_calories
        protien_percentage = total_protien_calories / total_calories

        print("Output:")
        print("Type\t", "Calories\t", "Percentage\t" )

        print ("Fat\t", "{:,.2f}".format(total_fat_calories), "\t", "{0:.2%}".format(fat_percentage))
        print ("Carb\t", "{:,.2f}".format(total_carb_calories), "\t", "{0:.2%}".format(carb_percentage))
        print ("Protien\t", "{:,.2f}".format(total_protien_calories), "\t", "{0:.2%}".format(protien_percentage, "\n"))
