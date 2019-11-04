import pandas as pd
import openpyxl as xl
from pandas import ExcelWriter
from pandas import ExcelFile
import numpy as np

df=pd.read_csv("clean_data1.txt", delimiter="\t")

print("Column headings:")

print(str(len(df.index)))

#Concatenate lists
lst1 = df.loc[0:, 'column1']
lst1 = pd.concat([lst1, df.loc[0:, 'column2']], axis=1, sort=False)
lst1 = pd.concat([lst1, df.loc[0:, 'column3']], axis=1, sort=False)

#Select set of columns
lst2 = df.loc[0:, 'columnA':'columnB']

#Fill missing data with '0'
result1 = lst1
result2 = lst2

#Write data into csv file
result1.to_csv('data_segment1.txt', header=True, sep='\t')
result2.to_csv('data_segment2.txt', header=True, sep='\t')



