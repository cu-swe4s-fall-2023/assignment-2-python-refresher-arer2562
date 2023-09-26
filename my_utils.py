def main(fn, cont, cont_col, sav_fir, for_fir, org_Fir, hum_fir, fir_col=1):
    try:
        f = open(fn, "r+")
    except FileNotFoundError:
        print('Could not find ' + fn)
    except PermissionError:
        print('Could not open ' + fn)
    finally:
        with open(fn, "r+") as my_file:
            next(my_file)
            fir_col = []
            for j in my_file:
                A = j.rstrip().split(',')
                if A[cont_col] == cont:
                    fir_col.append(A[hum_fir])
                    fir_col.append(A[sav_fir])
                    fir_col.append(A[for_fir])
                    fir_col.append(A[org_Fir])
                else:
                    pass
            int_fires_column = []
            for i in range(len(fir_col)):
                try:
                    fir_col[i] = int(float(fir_col[i]))
                except ValueError:
                    print('Skipping non-int value ' + fir_col[i])
                finally:
                    int_fires_column.append(fir_col[i])
            fir_col = sum(int_fires_column)

    return (fir_col)


if __name__ == '__main__':
    print('You are suppposed to call this funciton from another script')
    main()
