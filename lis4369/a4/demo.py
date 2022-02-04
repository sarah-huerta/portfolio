import re
import numpy as np
np.set_printoptions(threshold=np.inf)
import pandas as pd

import matplotlib.pyplot as plt
from matplotlib import style

def main():
    get_requirements()
    data_analysis_2()

def get_requirements():
    print("Data Analysis 2")
    print("Developer: Sarah Huerta")
    print("Program Requirements:")
    print("1. Run demo.py")
    print("2. If errors, more than likely missing installations.")
    print("3. Test Python Package Installer: pip freeze")
    print("4. Research how to do the following installations: numpy, re.")
    print("5. Create at least three functions that are called by the program: ")
    print("\ta. main(): calls at least two other functions.")
    print("\tb. get_requirements(): displays the program requirements")
    print("\tc. data_analysis_2(): displays the following data.")
    print("\n6. Display graph as per instruction w/in demo.py.")

def data_analysis_2():

    url = "https://raw.github.com/vincentarelbundock/Rdatasets/master/csv/Stat2Data/Titanic.csv"
    df = pd.read_csv(url)

    print("***DataFrame composed of three components: index, columns, and data. Data also known as values.***")

    index = df.index
    columns = df.columns
    values = df.values

    print("\n1. Print indexes: ")
    print(index)

    print("\n2. Print columns: ")
    print(columns)

    print("\n3. Print columns (another way): ")
    print(df.columns[:])

    print("\n4. Print (all) values, in array format: ")
    print(values)

    print("\n5. ***Print component data types: ***")
    print("\na) index type: ")
    print(type(index))

    print("\nb) columns type: ")
    print(type(columns))

    print("\nc) values type: ")
    print(type(values))

    print("\n6. Print summary of DataFrame (similar to 'describe tablename;' in MySQL): ")
    print(df.info())

    print("\n7. First five lines(all columns): ")
    print(df.head())

    df=df.drop('Unnamed: 0', 1)
    print("\n8. Print summary of DataFrame (after dropping column 'Unnamed: 0'): ")
    print(df.info())

    print("\n9. First five lines (after dropping column 'Unnamed: 0'): ")
    print(df.head())

    print("\n***Precise data selection (data slicing): ***")
    print("\n10. Using iloc, return first 3 rows: ")
    print(df.iloc[:3])

    print("\n11. Using iloc, return last 3 rows (start on index 1310 to end): ")
    print(df.iloc[1310:])

    print("\n12. Select rows 1, 3, and 5; and columns 2, 4, and 6 (includes index column): ")
    a = df.iloc[[0,2,4], [1,3,5]]
    print(a)

    print("\n13. Select all rows, and columns 2, 4, and 6 (includes index column): ")
    a = df.iloc [:, [1,3,5]]
    print(a)

    print("\n14. Select all rows, and columns 1, 3, and 5 (includes index column): ")
    a = df.iloc [[1,3,5], :]
    print(a)

    print("\n15. Select all rows, and columns(includes index column) Note: only first and last 30 records displayed: ")
    a = df.iloc [:, :]
    print(a)

    print("\n16. Select all rows; and columns starting at column 2 (includes index column). Note: only first and last 30 records displayed: ")
    a = df.iloc [:, 1:]
    print(a)

    print("\n17. Select row 1, and column 1, (includes index column): ")
    a = df.iloc [0:1, 0:1]
    print(a)

    print("\n18. Select rows 3-5, and column 3-5, (includes index column): ")
    a = df.iloc [2:5, 2:5]
    print(a)

    print("\n19. *** Convert pandas Dataframe df to NumPy ndarray, use values command: ***")
    b = df.iloc[:,1:].values


    print("\n20. Print data frame type:")
    print(type(df))

    print("\n21. Print a type :")
    print(type(a))

    print("\n22. Print b type :")
    print(type(b))

    print("\n23. Print number of dimensions and items in array (rows, columns). Remember: starting at column 2:")
    print(b.shape)

    print("\n24. Print type of itmes in array. Remember: ndarray is an array of arrays. Each record/item is an array. ")
    print(b.dtype)

    print("\n25. Printing a:")
    print(a)

    print("\n26. Length of A :")
    print(len(a))

    print("\n27. Printing B :")
    print(b)

    print("\n28. Length of B :")
    print(len(b))

    print("\n29. Print element of (NumPy array) ndarray b in *second* row, *third* column: ")
    print(b[1,2])

    print("\n30. Print all records for NumPy array column 2: ")
    print(b[:, 1])

    print("\n31. Get passenger names: ")
    names = df["Name"]
    print(names)


    print("\n32. Find all passengers with name 'Allison' (using regular expressions): ")
    for name in names:
        print(re.search(r'(Allison)', name))

    print("\n***33.Statistical Analysis (DataFrame notation): **** ")

    print("\na) Print mean age: ")
    avg=df["Age"].mean()
    print(avg)

    print("\nb) Print mean age, rounded to two decimal places: ")
    avg=df["Age"].mean().round(2)
    print(avg)

    print("\nc) Print mean of every column in DataFrame (may not be suitable with certain columns): ")
    avg_all=df.mean(axis=0)
    print(avg_all)

    print("\nd) Print summary statistics (DataFrame notation): ")
    describe=df["Age"].describe()
    print(describe)

    print("\ne) Print minimum age (DataFrame notation): ")
    min=df["Age"].min()
    print(min)

    print("\nf) Print maximum age (DataFrame notation): ")
    max=df["Age"].max()
    print(max)

    print("\ng) Print median age (DataFrame notation): ")
    median=df["Age"].median()
    print(median)

    print("\nh) Print mode age (DataFrame notation): ")
    mode=df["Age"].mode()
    print(mode)

    print("\ni) Print number of values (DataFrame notation): ")
    count=df["Age"].count()
    print(count)

    print("\n***Graph: Display ages of the 20 passengers (use code from previous assignment): ***")


    plt.style.use('seaborn-whitegrid')

    df['Age'].plot()

    plt.legend()
    plt.show()




if __name__ == "__main__":
        main()
