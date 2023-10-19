test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest
. ssshtest
# Define test cases
run "Test read_data with valid data" python fires_by_country.py --data_file subsetted_data.csv --out_dir histograms --title "Fires by Country" --x_label "Country" --y_label "Number of Fires"
assert_equal $file_name $( ls $bar_plot.png )
assert_exit_code 0

run "Test read_data with valid data" python fires_by_country.py --data_file valid_data.csv --out_dir histograms --title "Fires by Country" --x_label "Country" --y_label "Number of Fires"
assert_equal $file_name $($quartile_2.png )
assert_exit_code 0

run "Test read_data with missing values" python fires_by_country.py --data_file test_missing_data.csv --out_dir histograms --title "Fires by Country" --x_label "Country" --y_label "Number of Fires"
assert_no_stdout

run "Test read_data with non-numeric values" python fires_by_country.py --data_file test_non_numeric_values.csv --out_dir histograms --title "Fires by Country" --x_label "Country" --y_label "Number of Fires"
assert_stderr



# Cleanup: Remove any generated files
rm -f test_plot.png

# Run the tests
run "Test suite finished" echo "All tests passed."

