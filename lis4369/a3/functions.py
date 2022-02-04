def get_requirements():
    print("Painting Estimator\n")
    print("Program Requirements:")
    print("1. Calculate home interior paint cost(w/o primer)" +
          "\n2. Must use float data types." +
          "\n3. Must use SQFT_PER_GALLON constant (350)" +
          "\n4. Must use iteration structure (aka 'loop')" +
          "\n5. Format, right-align numbers, and round to two decimal places." +
          "\n6. Create at least five functions that are called by the program: " +
          "\n\ta. main(): calls two other functions: get_requirements() and estimate_painting_cost()." +
          "\n\tb. get_requirements(): displays the program requirements." +
          "\n\tc. estimate_painting_cost(): calculates interior home painting and calls print functions." +
          "\n\td. print_painting_estimate(): displays painting costs. " +
          "\n\te. print_painting_percentage(): displays painting costs percentages.\n")

def estimate_painting_cost():

    sqFtGallon = 350.00
    print("Input: ")
    interior = float(input('Enter total interior sq ft: '))
    gallonPrice = float(input('Enter price per gallon paint: '))
    hourlyRate = float(input('Enter hourly painting rate per sq ft: '))
    numGallon = interior / sqFtGallon
    print_painting_estimate(interior, sqFtGallon, numGallon, gallonPrice, hourlyRate)

    print_painting_percentage(interior, sqFtGallon, numGallon, gallonPrice, hourlyRate)




def print_painting_estimate(sqFtTotal, sqFtGallon, numGallon, paintGallon, labor):
    print("\nOutput: ")
    print("Item" + "{0:>31}".format("Amount"))
    print("{0:<10} {1:>10,.2f}".format('Total sq ft:\t\t', sqFtTotal))
    print("{0:<10} {1:>10,.2f}".format('Sq Ft per Gallon:\t', sqFtGallon))
    print("{0:<10} {1:>10,.2f}".format('Number of Gallons:\t', numGallon))
    print("{0:<10} ${1:>9,.2f}".format('Paint per Gallon:\t', paintGallon))
    print("{0:<10} ${1:>9,.2f}".format('Labor per Sq Ft:\t', labor))

def print_painting_percentage(sqFtTotal, sqFtGallon, numGallon, paintGallon, labor):
    totalPercent = 100.00
    paint = numGallon * paintGallon
    laborCost = labor * sqFtTotal
    total = paint + laborCost
    paintPercent = (paint / total ) * 100
    laborPercent = (laborCost / total ) * 100

    print("\nCost\t\t Amount\t Percentage ")
    print("{0:<10} ${1:>10,.2f} {2:>10,.2f}%".format('Paint:\t', paint, paintPercent))
    print("{0:<10} ${1:>10,.2f} {2:>10,.2f}%".format('Labor:\t', laborCost, laborPercent))
    print("{0:<10} ${1:>10,.2f} {2:>10,.2f}%".format('Total:\t' , total, totalPercent))
