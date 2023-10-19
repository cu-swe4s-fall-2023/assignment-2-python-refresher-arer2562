import argparse
import math_by_country as muts

parser = argparse.ArgumentParser(
    description='Calculate and plot the number of fires for each country.')
parser.add_argument(
    '--data_file', type=str,
    help='Path to the data file (CSV format)',
    required=True)
parser.add_argument(
    '--out_dir', type=str,  # Updated argument for the output directory
    help='Directory to save histograms',  # Updated help message
    required=True)
parser.add_argument(
    '--title', type=str,
    help='Title for the histograms',  # Updated help message
    required=True)
parser.add_argument(
    '--x_label', type=str,
    help='X-axis label',
    required=True)
parser.add_argument(
    '--y_label', type=str,
    help='Y-axis label',
    required=True)

args = parser.parse_args()

if __name__ == "__main__":
    data = muts.read_data(args.data_file)
    muts.generate_histogram(
        data,
        args.out_dir,
        args.title,
        args.x_label,
        args.y_label
    )  # Updated function call
