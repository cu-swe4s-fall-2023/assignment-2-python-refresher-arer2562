import statistics as stats
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
            fir_col = int_fires_column

    return sum(fir_col)

def cal_mean(fir_col,mean):
    try:
        total = sum(fir_col)
    except ValueError:
        print('Skipping non-int value ' + fir_col)
    finally:
        mean = total / len(fir_col)
        print(mean)
    return(mean)


def cal_med(fir_col,med):
    try:
        sorted_fir_col = sorted(fir_col)
    except ValueError:
        print('Skipping non-int value ' + fir_col)
    finally:
        n = len(sorted_fir_col)
        if n % 2 == 1:
            med = sorted_fir_col[n // 2]
        else:
            middle1 = sorted_fir_col[(n -1) // 2]
            middle2 = sorted_fir_col[(n +1) // 2]
            med = (middle1 + middle2) /2

        print(med)
    return(med)

    


if __name__ == '__main__':
    print('You are suppposed to call this funciton from another script')
    main()
