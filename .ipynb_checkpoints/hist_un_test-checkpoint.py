import unittest
import math_by_country as muts
import csv
import csv
import unittest
import math_by_country as muts
import tempfile
import os

class TestReadDataFunction(unittest.TestCase):
    def setUp(self):
        self.test_dir = tempfile.TemporaryDirectory()
        self.valid_data = [
            ["Country1", "10", "20", "30", "40"],
            ["Country2", "15", "25", "35", "45"],
        ]
        self.invalid_data = [
            ["USA", "10", "20", "xyz", "30"],
            ["Canada", "15", "abc", "25", "35"],
            ["Mexico", "def", "30", "40", "45"],
        ]

        self.valid_data_file = os.path.join(self.test_dir.name, "valid_data.csv")
        self.invalid_data_file = os.path.join(self.test_dir.name, "invalid_data.csv")

        with open(self.valid_data_file, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Country", "Savannah", "Forest", "Organic", "Humid"])
            writer.writerows(self.valid_data)

        with open(self.invalid_data_file, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Country", "Savannah", "Forest", "Organic", "Humid"])
            writer.writerows(self.invalid_data)

    def tearDown(self):
        self.test_dir.cleanup()

    def test_read_data_valid_data(self):
        data = muts.read_data(self.valid_data_file)
        # Assertions to check specific values from the data
        self.assertEqual(data["Country1"], [10.0, 20.0, 30.0, 40.0])
        self.assertEqual(data["Country2"], [15.0, 25.0, 35.0, 45.0])

    def test_read_data_non_numeric_values(self):
        data = muts.read_data(self.invalid_data_file, None)
        # Assertions to verify handling of non-numeric values
        self.assertEqual(data["USA"], [10.0, 20.0, 0.0, 0.0])
        self.assertEqual(data["Canada"], [15.0, 25.0, 35.0, 0.0])
        self.assertEqual(data["Mexico"], [30.0, 40.0, 45.0, 0.0])

    def test_read_data_string_exceptions(self):
    # Test that an exception is raised when reading data with non-numeric values
        with self.assertRaises(ValueError):
            data = muts.read_data(self.invalid_data_file)

    def test_read_data_non_numeric_values(self):
        # Create a test CSV file with non-numeric values
        test_csv = "test_non_numeric_values.csv"
        with open(test_csv, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Country", "Savannah Fires", "Forest Fires", "Organic Fires", "Humid Fires"])
            writer.writerow(["USA", "10", "20", "xyz", "30"])
            writer.writerow(["Canada", "15", "abc", "25", "35"])

        data = muts.read_data(test_csv)

        # Assert that non-numeric values are handled correctly
        with self.assertRaises(ValueError):
            data = muts.read_data(test_csv)

class TestGenerateHistogram(unittest.TestCase):
    def test_generate_histogram(self):
        data = {
            "Country1": [100, 200, 300, 400],
            "Country2": [50, 150, 250, 350],
            "Country3": [200, 300, 400, 500],
            "Country4": [10, 20, 30, 40]
        }
        out_dir = "histograms"
        title = "Test Histogram"
        x_label = "X-axis Label"
        y_label = "Y-axis Label"
        
        muts.generate_histogram(data, out_dir, title, x_label, y_label)
        
        # Perform assertions here to check if the histograms were generated correctly in the "test_out" directory.
        # You can use file I/O functions and image comparison libraries to validate the output images.

class TestGenerateSingleHistogram(unittest.TestCase):
    def test_generate_single_histogram(self):
        data = [("Country1", 100), ("Country2", 50), ("Country3", 200)]
        out_dir = "histograms"
        out_file = "test_histogram.png"
        title = "Test Histogram"
        x_label = "X-axis Label"
        y_label = "Y-axis Label"
        
        muts.generate_single_histogram(data, out_dir, out_file, title, x_label, y_label)
        
        # Perform assertions here to check if the single histogram was generated correctly in the "test_out" directory.




if __name__ == '__main__':
    unittest.main()


    # Add more test cases for other functions if needed

    
    #self.assertEqual(data["USA"], [10.0, 20.0, 0.0, 0.0])
        #self.assertEqual(data["Canada"], [15.0, 0.0, 0.0, 0.0])