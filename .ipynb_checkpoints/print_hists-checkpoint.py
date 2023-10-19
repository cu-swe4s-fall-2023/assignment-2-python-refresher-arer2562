import argparse
import hist
# Create an argument parser
parser = argparse.ArgumentParser(description='Generate a histogram from data')

# Add command-line arguments
parser.add_argument('data_file', type=str, help='Path to the data file')
parser.add_argument('out_file', type=str, help='Path to the output image file')
parser.add_argument('title', type=str, help='Title for the histogram')
parser.add_argument('x_label', type=str, help='Label for the X-axis')
parser.add_argument('y_label', type=str, help='Label for the Y-axis')

# Parse the command-line arguments
args = parser.parse_args()

hist.main()

# Print the parsed arguments (for testing purposes)
print("Data File:", args.data_file)
print("Output File:", args.out_file)
print("Title:", args.title)
print("X Label:", args.x_label)
print("Y Label:", args.y_label)

