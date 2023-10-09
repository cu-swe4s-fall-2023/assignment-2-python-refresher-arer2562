import unittest
import statistics as stats
import random
import my_utils

class TestCalc(unittest.TestCase):
    def test_main(self):
        file_path = 'Agrofood_co2_emission.csv'
        result = my_utils.main(fir_col=[1], fn=file_path, cont='United States of America', cont_col=0, sav_fir=2, for_fir=3, org_Fir=22, hum_fir=23)
        self.assertEqual(result, 103213)

    def test_cal_mean_positive_random(self):
        fir_col = [random.randint(1, 10000) for _ in range(10)]
        result = my_utils.cal_mean(fir_col, mean=None)
        self.assertEqual(result, stats.mean(fir_col))

    def test_cal_mean_negative(self):
        fir_col = ['one', 'six', '7']
        result = my_utils.cal_mean(fir_col, mean=None)
        self.assertIsNone(result)

    def test_cal_med_positive_random(self):
        fir_col = [random.randint(1, 10000) for _ in range(10)]
        result = my_utils.cal_med(fir_col, med=None)
        self.assertEqual(result, stats.median(fir_col))

    def test_cal_med_negative(self):
        fir_col = ['one', 'six', '7']
        result = my_utils.cal_med(fir_col, med=None)
        self.assertIsNone(result)

    def test_cal_stdev_positive_random(self):
        fir_col = [random.randint(1, 10000) for _ in range(10)]
        result = my_utils.cal_stdev(fir_col, stdev=None)
        self.assertEqual(result, stats.stdev(fir_col))

    def test_cal_stdev_negative(self):
        fir_col = ['one', 'six', '7']
        result = my_utils.cal_stdev(fir_col, stdev=None)
        self.assertIsNone(result)


if __name__ == '___main__':
    unittest.main()
