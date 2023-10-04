import my_utils as muts
import argparse

parser = argparse.ArgumentParser(
            description='Calulate sum of fires in all 4 reigons.',
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
                    help='Column of savanah fires',
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
                    choices=['mean', 'med', 'stdev'],
                    help='specify the operation mean, med, stdev',
                    required=True)
args = parser.parse_args()


result = muts.main(args.fn, args.cont, args.cont_col, args.sav_fir, args.for_fir, args.org_Fir, args.hum_fir)
# Line above too long, didn't shrink varis again to avoid uninformative vars
if args.operation == "mean":
    mean_result = muts.cal_mean(result, None)
    print(f"Mean: {mean_result}")
elif args.operation == "median":
    median_result = muts.cal_median(result, None)
    print(f"Median: {median_result}")
elif args.operation == "stdev":
    stdev_result = muts.cal_stdev(result)
    print(f"Standard Deviation: {stdev_result}")

print(args.fn, args.cont, args.fir_col)
