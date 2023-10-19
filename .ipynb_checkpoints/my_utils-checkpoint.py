import statistics as stats
import matplotlib.pyplot as plt


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
            print(sum(fir_col))
    return fir_col


def cal_mean(fir_col, mean):
    try:
        int_fir_col = [int(x) for x in fir_col if isinstance(x, (int, float))]
        if not int_fir_col:
            raise ValueError('No Valid integer values in input list')
        mean = stats.mean(int_fir_col)
        return mean
    except (TypeError, ValueError) as e:
        print(f"Error: {e}")
        return None


def cal_med(fir_col, med):
    try:
        int_fir_col = [int(x) for x in fir_col if isinstance(x, (int, float))]
        if not int_fir_col:
            raise ValueError('No Valid integer values in input list')
        med = stats.median(fir_col)
        print(med)
        return med
    except (TypeError, ValueError) as e:
        print(f"Error: {e}")
        return None


def cal_stdev(fir_col):
    try:
        numeric_fir_col = [
            float(x) for x in fir_col if isinstance(x, (int, float))]
        if not numeric_fir_col:
            raise ValueError('No valid numeric values in the input list')
        stdev = stats.stdev(numeric_fir_col)
        return stdev
    except (ValueError, ZeroDivisionError, stats.StatisticsError) as e:
        print(f'Error: {e}')
        return None


def generate_histogram(fir_col, out_file, title, x_label, y_label):
    fig, ax = plt.subplots()
    ax.hist(fir_col)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    ax.set_xlabel(x_label)
    ax.set_ylabel(y_label)
    ax.set_title(title)

    plt.savefig(out_file, bbox_inches='tight')


if __name__ == "__main__":
    if len(sys.argv) != 7:
        print("Usage: python script.py "
              "data_file "
              "out_file "
              "title "
              "x_label "
              "y_label "
              "column_to_plot")
    else:
        muts.generate_histogram(fir_col, out_file, title, x_label, y_label)
