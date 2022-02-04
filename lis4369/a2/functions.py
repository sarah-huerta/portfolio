def get_requirements():
    print("Payroll Calculator")
    print("\nProgram Requirements:\n"
    + "1. Must use float data type for user input. \n"
    + "2. Overtime rate: 1.5 times hourly rate (hours over 40). \n"
    + "3. Holiday rate: 2.0 times hourly rate (all holiday hours). \n"
    + "4. Must format currency with dollar sign, and round to two decimal places. \n"
    + "5. Create at least three functions that are called by the program: \n"
    + "\ta. main(): calls at least two other functions. \n"
    + "\tb. get_requirments(): displays the program requirements. \n"
    + "\tc. calculate_payroll(): calculatesß an individual one-week paycheck. \n")




def calculate_payroll():
    #constants to represent base hours, overtime and holiday rates
    BASE_HOURS = 40 #base hours
    OT_RATE = 1.5 #overtime rate
    HOLIDAY_RATE = 2.0 #holiday rate

    #IPO: Input > Process > Output
    #get user data
    print("Input:")
    #get hours worked and hourly pay rate
    hours = float(input('Enter hours worked: '))
    holiday_hours = float(input('Enter holiday hours: '))
    pay_rate = float(input('Enter hourly pay rate: '))

    #Process:
    #calculations
    base_pay = BASE_HOURS * pay_rate
    overtime_hours = hours - BASE_HOURS

    #calculate and display gross pay

    if hours > BASE_HOURS:
        #calculate gross pay with overtime

        #calculate overtime pay
        overtime_pay = overtime_hours * pay_rate * OT_RATE

        #calculate holiday pay
        holiday_pay = holiday_hours * pay_rate * HOLIDAY_RATE

        #calculate gross pay
        gross_pay = BASE_HOURS * pay_rate + overtime_pay + holiday_pay
        print_pay(base_pay, overtime_pay, holiday_pay, gross_pay)
    else:
        #calculate gross pay without overtime, but include holiday pay
        overtime_pay = 0
        holiday_pay = holiday_hours * pay_rate * HOLIDAY_RATE
        gross_pay = hours * pay_rate + holiday_pay

        # display pay
        print_pay(base_pay, overtime_pay, holiday_pay, gross_pay)

def print_pay(base_pay, overtime_pay, holiday_pay, gross_pay):
    print("\nOutput:")
    print("{0:<10} ${1:,.2f}".format('Base:', base_pay))
    print("{0:<10} ${1:,.2f}".format('Overtime:', overtime_pay))
    print("{0:<10} ${1:,.2f}".format('Holiday:',holiday_pay))
    print("{0:<10} ${1:,.2f}".format('Gross:', gross_pay))
