import pandas as pd
import sys

if len(sys.argv) >2:

    filename = sys.argv[1]
    new_file = filename[:-4]
    print("Opening file " + filename)
    df = pd.read_csv(filename, sep="\t", header=0, index_col=False)
    print(df.shape[0])

    file = sys.argv[2]
    id_f_name = filename[:-4]
    print("Opening file " + file)
    id_f = pd.read_csv(file, sep="\t", header=0, index_col=False)
    print(id_f.shape[0])

    out_fil = sys.argv[3]
    print("Opening file " + out_fil)
    out = pd.read_csv(out_fil, sep="\n", header=None, index_col=False)
    print()

    for key, val in out.iteritems():
        for v in val:
            id_f = id_f.drop([v])
            df = df.drop([v])

    print()
    print(df.shape[0])
    print(id_f.shape[0])

    new_file = new_file + "Out.txt"
    df.to_csv(new_file, header=True, index=False, sep='\t')

    id_f_name = id_f_name + "OID.txt"
    id_f.to_csv(id_f_name, header=True, index=False, sep='\t')

else:
    print("Give at least 3 filenames. Try again.")
    sys.exit(1)