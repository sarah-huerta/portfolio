import datetime
import pandas_datareader as pdr
import matplotlib.pyplot as plt
from matplotlib import style

def main():
    get_requirements()
    data_analysis_1()

def get_requirements():
    print("Data Analysis 1")
    print("Developer: Sarah Huerta")
    print("Program Requirements:")
    print("1. Run demo.py")
    print("2. If errors, more than likely missing installations.")
    print("3. Test Python Package Installer: pip freeze")
    print("4. Research how to do the following installations:")
    print("\ta. pandas (only if missing)")
    print("\tb. pandas_datareader (only if missing)")
    print("\tc. matplotlib (only if missing)")
    print("5. Create at least three functions that are called by the program: ")
    print("\ta. main(): calls at least two other functions.")
    print("\tb. get_requirements(): displays the program requirements")
    print("\tc. data_analysis_1(): displays the following data.")



def data_analysis_1():

    start = datetime.datetime(2010, 1, 1)
    end = datetime.date.today()

    df = pdr.DataReader("XOM", "yahoo", start, end)

    print("\nPrint number of records: ")

    print(df.columns)


    print("\nPrint data frame: ")
    print(df)

    print("\nPrint first five lines: ")
    df1 = df.head(3)
    print(df1)

    print("\nPrint first 2 lines:")
    df2 = df.head(2)
    print(df2)


    print("\nPrint last 2 lines")
    df3 = df.tail(2)
    print(df3)


    style.use('ggplot')

    df['Ages'].plot()
    
    plt.legend()
    plt.show()


if __name__ == "__main__":
    main()
