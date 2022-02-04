import random
def getRequirements():

    print("Pseudo-Random Number Generator \nDeveloper: Sarah Huerta")
    print("Program Requirements:")
    print("1. Get user beginning and ending integer values, and store in two variables.")
    print("2. Display 10 pseudo-random numbers between, and including, above values")
    print("3. Must use integer data types.")
    print("4. Example 1: Using range() and randint() functions.")
    print("5. Example 2: Using a list with range() and shuffle() functions.")

def random_numbers():
    start = 0
    end = 0

    print("Input: ")
    start = int(input("Enter beginning value: "))
    end = int(input("Enter ending value: "))

    print("\nOutput:")
    print("Example 1: Using range() and randint() functions:")
    for count in range(10):
        print(random.randint(start, end), sep="," , end=" ")

    print()

    print("\nExample 2: Using a list, with range() and shuffle() functions:")

    r = list(range(start, end + 1))

    random.shuffle(r)
    for i in r:
        print(i, sep=",", end=" ")

    print()
