import datetime
import pandas_datareader.data as pdr
import matplotlib.pyplot as plt
from matplotlib import style

def data_analysis_1():

    start = datetime.datetime(2010, 1, 1)
    end = datetime.date.today()

    df = pdr.DataReader("XOM", "yahoo", start, end)

    print("\nPrint number of records: ")

    print(df.columns)
    

    print("\nPrint data frame: ")
    print(df)

    print("\nPrint first five lines: ")

    print("\nPrint first 2 lines:")

    print("\nPrint last 2 lines")


    style.use('ggplot')

    df['High'].plot()
    df['Adj Close'].plot()
    plt.legend()
    plt.show()
