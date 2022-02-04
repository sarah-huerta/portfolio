def getRequirements():
    print("Developer: Sarah Huerta\n")
    print("Program Requirements: "
          + "\n1. Print while loop"
          + "\n2. Print for loops using range() function, and implict and explict lists."
          + "\n3. Use break and continue statements"
          + "\n4. Replicate display below.")


def whileLoop():
    print("\n1. While loop:")
    i = 1
    while i < 4:
        print(i)
        i +=1

def rangeLoop1():
    print("\n2. for loop: using range() function with 1 arg: ")
    for x in range(4):
        print(x)

def rangeLoop2():
    print("\n3. for loop: using range() function with 2 args: ")
    for x in range(1,4):
        print(x)


def rangeLoop3():
    print("\n4. for loop: using range() funtion with 3 args (interval 2): ")
    for x in range(1,4,2):
        print(x)

def rangeLoop4():
    print("\n5. for loop: using range() function with 3 args (negative interval): ")
    for x in range(3,0,-2):
        print(x)

def implictLoop():
    print("\n6. for loop using (implict) list (i.e. lists not assigned to variable): ")
    num = range(1,4)
    new_list = []
    for n in num:
        new_list.append(n)
    print(*new_list, sep="\n")

def explictLoop():
    print("\n7. for loop iterating through (explicit) string list: ")
    list = ["Mango", "Peach", "Berry"]
    for x in list:
        print(x)

def breakLoop():
    print("\n8. for loop using break statement (stops loop): ")
    list = ["Mango", "Peach", "Berry"]
    for x in list:
        print(x)
        if x == "Mango":
            break
def continueLoop():
    print("\n9. for loop using continue statment (stops and continues with next): ")
    list = ["Mango", "Peach", "Berry"]
    for x in list:
        print(x)
        if x == "Mango":
            continue
        if x == 'Peach':
            break
def printLoop():
    print("\n10. print list length: ")
    list = ["Mango", "Peach", "Berry"]
    print(len(list))
