def getRequirements():
    print("Developer: Sarah Huerta\n")
    print("Program Requirements: "
          + "\n1. Use Python selection structure."
          + "\n2. Prompt user for two numbers, and a suitable operator."
          + "\n3. Test for correct numeric operator."
          + "\n4. Replicate display below.")

def calculate():
    print("\nPython Calculator\n")

    num1 = float(input('Enter number 1: '))
    num2 = float(input('Enter number 2: '))

    print("\nSuitable Operators: +, -, *, /, //(integer division), & (modulo operator), ** (power)")

    op = str(input('Enter operator: '))

    if op == '+':
        total = num1 + num2
        print("{:,.2f}".format((total)))

    elif op == '-':
        total = num1 - num2
        print("{:,.2f}".format(total))

    elif op == '*':
        total = num1 * num2
        print("{:,.2f}".format(total))

    elif op == '/':
        total = num1 / num2
        print("{:,.2f}".format(total))

    elif op == '//':
        total = num1 // num2
        print("{:,.2f}".format(total))

    elif op == '%':
        total = num1 % num2
        print("{:,.2f}".format(total))

    elif op == '**':
        total = num1 ** num2
        print("{:,.2f}".format(total))
    else:
        print("Incorrect operator!")

    print("Thank you program now exiting.\n")
