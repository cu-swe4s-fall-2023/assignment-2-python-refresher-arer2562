import my_utils as muts
import argparse

parser = argparse.ArgumentParser(
            description='Calculate sum of fires in all 4 regions.',
            prog='print_fires')
parser.add_argument('--fn',
                    type=str,
                    help='Name of the file',
                    required=True)
parser.add_argument('--cont',
                    type=str,
                    help='Name of country',
                    required=True)
parser.add_argument('--cont_col',
                    type=int,
                    help='Column of country',
                    required=True)
parser.add_argument('--sav_fir',
                    type=int,
                    help='Column of savannah fires',
                    required=True)
parser.add_argument('--for_fir',
                    type=int,
                    help='Column of forest fires',
                    required=True)
parser.add_argument('--org_Fir',
                    type=int,
                    help='Column of fires in organic soils',
                    required=True)
parser.add_argument('--hum_fir',
                    type=int,
                    help='Column of fires in humid tropical soils',
                    required=True)
parser.add_argument('--fir_col',
                    type=list,
                    help='Add two square brackets',
                    required=True)
parser.add_argument('--operation',
                    type=str,
                    choices=['mean', 'median', 'stdev', 'histogram'],
                    help='specify the operation (mean, median, stdev, histogram)',
                    required=True)
parser.add_argument('--out_file',
                    type=str,
                    help='out_file name',
                    required=True)
parser.add_argument('--title',
                    type=str,
                    help='descriptive title for graph',
                    required=True)
parser.add_argument('--x_label',
                    type=str,
                    help='graph x_label',
                    required=True)
parser.add_argument('--y_label',
                    type=str,
                    help='graph y_label',
                    required=True)
args = parser.parse_args()

data = muts.main(args.fn, args.cont, args.cont_col, args.sav_fir, args.for_fir, args.org_Fir, args.hum_fir)
if args.operation == "mean":
    mean_result = muts.cal_mean(data, None)
    print(f"Mean: {mean_result}")
elif args.operation == "median":
    median_result = muts.cal_med(data, None)
    print(f"Median: {median_result}")
elif args.operation == "stdev":
    stdev_result = muts.cal_stdev(data)
    print(f"Standard Deviation: {stdev_result}")
elif args.operation == "histogram":
    muts.generate_histogram(data, args.out_file, args.title, args.x_label, args.y_label)
    print(f"Histogram image saved as '{args.out_file}'")

