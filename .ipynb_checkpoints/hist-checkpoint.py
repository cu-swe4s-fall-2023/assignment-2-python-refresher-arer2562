import sys
import matplotlib.pyplot as plt

def generate_histogram(data_file, out_file, title, x, y):
    D = []
    for line in open(data_file):
        D.append(float(line))

    fig, ax = plt.subplots()
    ax.hist(D)
    ax.spines['top'].set visible(False)
    ax.spines['right'].set visible(False)
    ax.set_xlabel(x)
    ax.set_ylabel(y)
    ax.set_title(title)

    plt.savefig(out_file, bbox_inches='tight')

if __name__ == "__main__":
    if len(sys.argv) != 6:
        print("Usage: python script.py data_file out_file title x_label y_label")
    else:
        data_file = sys.argv[1]
        out_file = sys.argv[2]
        title = sys.argv[3]
        x_label = sys.argv[4]
        y_label = sys.argv[5]
        generate_histogram(data_file, out_file, title, x_label, y_label)

