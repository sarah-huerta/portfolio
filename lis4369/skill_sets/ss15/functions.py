import os

def get_requirements():
    print("Developer Sarah Huerta")
    print("Write Read Program")
    print("Program Requirements:")
    print("1. Create write _read file subdirectory with two files: main.py and functions.py.")
    print("2. Use President Abraham Lincoln's Gettysburg Address: Full Text.")
    print("3. Write address to file.")
    print("4. Read address from same file.")
    print("5. Create Python Docstrings for functions in functions. py file.")
    print("6. Display Python Docstrings for each function in functions.py file.")
    print("7. Display full file path.")
    print("8. Replicate display below.")

    print("\nHelp on function write read file in module functions: ")
    print("Write_read file()")
    print("\tUsage: Calls two functions:")
    print("\t  1. file write() # writes to file")
    print("\t  2. file read() # reads from file")
    print("\tParameters: none")
    print("\tReturns: none")
    print("\nHelp on function file write in module functions:")
    print("file write()")
    print("\tUsage: creates file, and writes contents of global variable to file")
    print("\tParameters: none")
    print("\tReturns: none")
    print("\nHelp on function file_read in module functions:")
    print("file read()")
    print("\tUsage: reads contents of written file")
    print("\tParameters: none")
    print("\tReturns: none\n")


def file_write():

    f = open("tests.txt", "w")
    f.write("President Abraham Lincoln's Gettysburg's Address: \nFour score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in liberty, and dedicated to the proposition that 'all men are created equal' Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle field of that war. We have come to dedicate a portion of it, as a final resting place for those who died here, that the nation might live. This we may, in all propriety do. But, in a larger sense, we can not dedicate -- we can not consecrate -- we can not hallow, this ground-- The brave men, living and dead, who struggled here, have hallowed it, far above our poor power to add or detract. The world will little note, nor long remember what we say here; while it can never forget what they did here. It is rather for us, the living, to stand here, we here be dedicated to the great task remaining before us -- that, from these honored dead we take increased devotion to that cause for which they here, gave the last full measure of devotion -- that we here highly resolve these dead shall not have died in vain; that the nation, shall have a new birth of freedom, and that government of the people by the people for the people, shall not perish from the earth. \nAbraham Lincoln November 19, 1863 ")
    f.write("\n\nFull File Path: ")
    f.write(os.path.realpath(f.name))
    f.close()

def file_read():
    f = open("tests.txt", "r")
    print(f.read())


def write_read_file():
    file_write()
    file_read()
