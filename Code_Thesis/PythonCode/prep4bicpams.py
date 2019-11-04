import pandas as pd
import sys
from sklearn import preprocessing
import numpy as np

if len(sys.argv) >2:

    filename = sys.argv[1]
    new_file = filename[:-4]
    print("Opening file " + filename)
    df = pd.read_csv(filename, sep="\t", header=0, index_col=False)
    df = df.drop(df.columns[0], axis=1)
    print(df.shape[0])
    print(df.shape[1])

    file = sys.argv[2]
    id_f_name = filename[:-4]
    print("Opening file " + file)
    id_f = pd.read_csv(file, sep="\t", header=0, index_col=False)
    print(id_f.shape[0])
    print(id_f.shape[1])


    print("Amount of missing data: " + str(df.isnull().sum().sum()))

    prep1 = pd.concat([id_f, df], axis=1, ignore_index=False)
    print("Initial amount of missing data: " + str(prep1.isnull().sum().sum()))

    new_file1 = "bicpams_data.txt"
    prep1.to_csv(new_file1, header=True, index=False, sep='\t')
    print(prep1.shape[0])
    print(prep1.shape[1])

else:
    print("Give at least 2 filenames. Try again.")
    sys.exit(1)