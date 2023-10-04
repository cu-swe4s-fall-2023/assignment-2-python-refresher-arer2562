. ssshtest

run test_mean_operation python print_fires.py --fn subsetted_data.csv --cont 'United States of America' --cont_col 0 --sav_fir 1 --for_fir 2 --org_Fir 3 --hum_fir 4 --fir_col '' --operation mean
assert_stdout "Total Fire Column Sum: 103213\n"
assert_exit_code 0

run test_mean_operation python print_fires.py --fn subsetted_data.csv --cont 'United States of America' --cont_col 0 --sav_fir 1 --for_fir 2 --org_Fir 3 --hum_fir 4 --fir_col '' --operation mean
assert_stdout "Mean: 123.45\n" 
assert_exit_code 0

run test_median_operation python print_fires.py --fn subsetted_data.csv --cont 'United States of America' --cont_col 0 --sav_fir 1 --for_fir 2 --org_Fir 3 --hum_fir 4 --fir_col '' --operation med
assert_stdout "Median: 67.89\n"  
assert_exit_code 0

run test_stdev_operation python print_fires.py --fn subsetted_data.csv --cont 'United States of America' --cont_col 0 --sav_fir 1 --for_fir 2 --org_Fir 3 --hum_fir 4 --fir_col '' --operation stdev
assert_stdout "Standard Deviation: 12.34\n" 
assert_exit_code 0



