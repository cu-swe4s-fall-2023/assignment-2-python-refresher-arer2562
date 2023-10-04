import statistics as stats

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

def cal_std(fir_col,stdev):
    try:
        stdev = stats.stdev(fir_col)
        print(stdev)
        return stdev
    except stats.StatisticsError:
        return None

fir_col = [1,2,3,4,5,6,7]
mean = 0
med = 0
stdev = 0

cal_mean(fir_col,mean)
cal_med(fir_col,med)
cal_std(fir_col,stdev)
