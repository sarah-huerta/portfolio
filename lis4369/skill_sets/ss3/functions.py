def get_requirements():
    print("IT/ICT Student Percentage")
    print("\nProgram Requirements:\n"
          + "1. Find number of IT/ICT students in class.\n"
          + "2. Calculate IT/ICT Student Percentage.\n"
          + "3. Must use float data type (to facilitate right-alignment).\n"
          + "4. Format, right-align numbers, and round to two decimal places.\n")

def percentage_calculations ():
        print("Input:")
        it_students = float(input('Enter number of IT students: '))
        ict_students = float(input('Enter number of ICT students: '))

        total_students = it_students + ict_students
        it_student_percentage = it_students / total_students
        ict_student_percentage = ict_students / total_students

        print("Output:")
        print("Total Students:\t", "{:,.2f}".format(total_students))
        print ("IT Students\t", "{0:.2%}".format(it_student_percentage))
        print ("ICT Students\t", "{0:.2%}".format(ict_student_percentage))
