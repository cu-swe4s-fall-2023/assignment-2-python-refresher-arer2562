#!/usr/bin/env python
import csv
import matplotlib.pyplot as plt
import collections
import numpy as np


def read_data(data_file):
    data = collections.defaultdict(lambda: [0.0, 0.0, 0.0, 0.0])

    with open(data_file, 'r') as file:
        reader = csv.reader(file)
        next(reader)
        for row in reader:
            country = row[0]
            sav_fir = for_fir = org_fir = hum_fir = 0.0

            try:
                if row[1]:
                    sav_fir = float(row[1])
                if row[2]:
                    for_fir = float(row[2])
                if row[3]:
                    org_fir = float(row[3])
                if row[4]:
                    hum_fir = float(row[4])
            except ValueError as e:
                raise ValueError(
                    f"Skip row with non-numeric values: {row}")
            finally:
                data[country][0] += sav_fir
                data[country][1] += for_fir
                data[country][2] += org_fir
                data[country][3] += hum_fir

    with open('red_data.txt', 'w') as out_file:
        writer = csv.writer(out_file)
        writer.writerow(['Country',
                         'Sav_Fir',
                         'For_Fir',
                         'Org_Fir',
                         'Hum_Fir'])
        for country, values in data.items():
            writer.writerow([country] + values)

    return data


def generate_histogram(data, out_dir, title, x_label, y_label):
    countries = list(data.keys())
    totals = [sum(data[country]) for country in countries]

    # Sort countries by total fires
    sorted_data = sorted(zip(countries, totals), key=lambda x: x[1])

    # Calculate cutoffs for quartiles
    num_countries = len(sorted_data)
    quartile_1_cutoff = int(num_countries * 0.25)
    quartile_2_cutoff = int(num_countries * 0.50)
    quartile_3_cutoff = int(num_countries * 0.75)

    # Extract countries and totals for each quartile
    quartile_1 = sorted_data[:quartile_1_cutoff]
    quartile_2 = sorted_data[quartile_1_cutoff:quartile_2_cutoff]
    quartile_3 = sorted_data[quartile_2_cutoff:quartile_3_cutoff]
    quartile_4 = sorted_data[quartile_3_cutoff:]

    # Generate histograms for each quartile
    generate_single_histogram(quartile_1,
                              out_dir,
                              "quartile_1.png",
                              title,
                              x_label,
                              y_label)
    generate_single_histogram(quartile_2,
                              out_dir,
                              "quartile_2.png",
                              title,
                              x_label,
                              y_label)
    generate_single_histogram(quartile_3,
                              out_dir,
                              "quartile_3.png",
                              title,
                              x_label,
                              y_label)
    generate_single_histogram(quartile_4,
                              out_dir,
                              "quartile_4.png",
                              title,
                              x_label,
                              y_label)


def generate_single_histogram(data,
                              out_dir,
                              out_file,
                              title,
                              x_label,
                              y_label):
    countries, totals = zip(*data)
    plt.figure(figsize=(12, 6))

    plt.bar(countries, totals, color='blue')
    plt.xlabel(x_label)
    plt.ylabel(y_label)
    plt.title(title)
    plt.xticks(rotation=45, ha='right')

    plt.tight_layout()
    plt.savefig(f"{out_dir}/{out_file}")


if __name__ == "__main__":
    data = read_data("data_with_missing_values.csv")
    out_dir = "histograms"  # Directory to save the histograms
    title = "Country Fire Distribution"
    x_label = "Country"
    y_label = "Total Fires"

    generate_histogram(data, out_dir, title, x_label, y_label)
