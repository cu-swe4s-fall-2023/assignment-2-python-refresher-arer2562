import csv

# Specify the input and output file names
input_file = "Agrofood_co2_emission.csv"
output_file = "subsetted_data.csv"

# Specify the column indices you want to include in the subset
selected_column_indices = [0, 2, 3, 22, 23]  # Replace with the indices of the columns you want

# Open the input and output CSV files
with open(input_file, "r") as csv_in, open(output_file, "w", newline="") as csv_out:
    reader = csv.reader(csv_in)
    writer = csv.writer(csv_out)

    # Read the header row from the input file and write it to the output file
    header = next(reader)
    selected_header = [header[i] for i in selected_column_indices]
    writer.writerow(selected_header)

    # Iterate through the remaining rows, selecting the specified columns and writing to the output file
    for row in reader:
        selected_row = [row[i] for i in selected_column_indices]
        writer.writerow(selected_row)
