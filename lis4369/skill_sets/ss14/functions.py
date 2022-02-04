def getRequirements():
    print("Developer: Sarah Huerta\n")
    print("Program Requirements")
    print("Python Calculator with Error Handling")
    print("1. Program calculates two numbers, and rounds to two decimal places.")
    print("2. Prompt user for two numbers, and a suitable operator.")
    print("3. Use Python error handling to validate data.")
    print("4. Test for correct arithmetic operator.")
    print("5. Division by zero not permitted.")
    print("6. Note: Program loops until correct input entered - numbers and arithmetic operator.")
    print("7. Replicate display below. \n")

def calculate():
    num1 = checkNum("Enter number 1: ")
    num2 = checkNum("\nEnter number 2: ")

    op = checkOp()

    if op == '+':
        total = num1 + num2

    elif op == '-':
        total = num1 - num2

    elif op == '*':
        total = num1 * num2

    elif op == '/':
        while True:
            try:
                total = num1 / num2
                break
            except ZeroDivisionError:
                num2 = checkNum("Sorry, you need to try a different number 2: ")

    elif op == '//':
        while True:
            try:
                total = num1 // num2
                break
            except ZeroDivisionError:
                num2 = checkNum("Sorry, you need to try a different number 2: ")
    elif op == '%':
        while True:
            try:
                total = num1 % num2
                break
            except ZeroDivisionError:
                num2 = checkNum("Sorry, you need to try a different number 2: ")
    elif op == '**':
        total = num1 ** num2

    print("Your answer is: " + "{:,.2f}".format(total))

def checkNum(num):
    while True:
      try:
          return float(input(num))
      except ValueError:
         print("Not an integer! Try again.")
         continue
      else:
         break

def checkOp():
    operator = ['+', '-', '*', '/', '//', '&', '**']

    print("\nSuitable Operators: +, -, *, /, //(integer division), & (modulo operator), ** (power)")

    while True:
      op = input("Enter Operator: ")
      try:
          operator.index(op)
          return op
      except ValueError:
         print("Invaild Operators! Try again.\n")
