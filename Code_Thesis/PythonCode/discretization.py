import pandas as pd
import sys

if len(sys.argv) >1:

    filename = sys.argv[1]
    new_file = filename[:-4]
    print("Opening file " + filename)
    df = pd.read_csv(filename, sep="\t", header=0, index_col=False)

    info_unique = df.astype('object').describe(include='all').loc['unique', :]

    to_disc = pd.DataFrame()
    for index, value in info_unique.items():
        if value>10:
            output = pd.cut(df[index], 8, labels=False, retbins=True)
            to_disc[index] = output[1]
            df[index] = output[0]

    print(to_disc)
    print("#Columns discretized: " + str(to_disc.shape[1]))
    print("Total amount of missing data: " + str(df.isnull().sum().sum()))

    # Write data into csv file
    cat_file = new_file + "cat.txt"
    to_disc.to_csv(cat_file, header=True, index=False, sep='\t')

    new_file = new_file + "D.txt"
    df.to_csv(new_file, header=True, index=False, sep='\t')

else:
    print("Give at least a filename. Try again.")
    sys.exit(1)