import pandas as pd
import openpyxl as xl
from pandas import ExcelWriter
from pandas import ExcelFile
import numpy as np
import sys

if len(sys.argv) >1:

    filename = sys.argv[1]
    new_file = "clean_" + filename[:-5]
    print("Opening file " + filename)
    df = pd.read_excel(filename)

    initial_rows = df.shape[0]
    initial_columns = df.shape[1]
    print("Initial dimensions: Rows_ " + str(initial_rows) + "; Columns_ " + str(initial_columns))


    if len(sys.argv)>=3:
        #SELECT DATA FROM A GIVEN REGION
        if int(sys.argv[2])!= 0:
            new_file = new_file + "_NUTII" + sys.argv[2]
            # Select people from a specific region
            df = df.loc[df['NUTII']==int(sys.argv[2])]
            #DROP 'NUTII' COLUMN SINCE IT LOOSES IT RELEVANCE IN THIS CASE
            df = df.drop('NUTII', axis=1)
            print("#Rows after selecting patients from NUTII region " + sys.argv[2] + ": " + str(df.shape[0]))

    print("Initial amount of missing data: " + str(df.isnull().sum().sum()))

    #REMOVE CERTAIN LISTS
    if len(sys.argv) >3:
        col_list = list(sys.argv[3:])
        print(col_list)
        new_file = new_file + "_wCut"
        df = df.drop(col_list, axis=1)
        print("Dropped " + str(len(col_list)) + " columns with missing values (" + str(
            df.shape[1]) + " total columns)")

    # REMOVE COLUMNS WITH 30% DATA MISSING
    limit_columns = round(30 * df.shape[0] / 100)
    print("Limit columns: " + str(limit_columns))
    columns2drop = []
    # Iterate columns
    columns = list(df)
    for i in columns:
        if df[i].isnull().sum() > limit_columns:
            columns2drop.append(i)
    df = df.drop(columns2drop, axis=1)
    print("Dropped " + str(len(columns2drop)) + " columns with missing values (" + str(
        df.shape[1]) + " total columns)")

    #REMOVE ROWS WITH 30% DATA MISSING
    limit_rows = round(30 * df.shape[1] / 100)
    print("Limit rows: " + str(limit_rows))
    rows2drop = []
    #Iterate rows
    for i in range(len(df.index)):
        if df.iloc[i].isnull().sum() > limit_rows:
            rows2drop.append(i)
    df = df.drop(df.index[rows2drop], axis=0)
    print("Dropped " + str(len(rows2drop)) + " rows with missing values (" + str(df.shape[0]) + " total rows)")

    #REMOVE STRINGS
    df = df.select_dtypes(exclude=[object])
    print("#Columns after removing columns with strings: " + str(df.shape[1]))

    #REMOVE DATES AND TIME
    df = df.select_dtypes(exclude='datetime')
    print("#Columns after removing columns with date/time: " + str(df.shape[1]))

    #Fill missing data with '-1'
    print("Total amount of missings to fill: " + str(df.isnull().sum().sum()))
    df = df.fillna(-1)

    #Isolate ID column on its own for later analysis
    lst_ID = df.loc[0:, 'ID']
    id_file = new_file + "IDM.txt"
    lst_ID.to_csv(id_file, header=True, index=False, sep='\t')

    # DROP 'ID' COLUMN
    df = df.drop('ID', axis=1)

    print("Final dimensions: Rows_ " + str(df.shape[0]) + "; Columns_ " + str(df.shape[1]))
    #Write data into csv file
    new_file = new_file + "M.txt"
    df.to_csv(new_file, header=True, index=False, sep='\t')

else:
    print("Give at least a filename. Try again.")
    sys.exit(1)