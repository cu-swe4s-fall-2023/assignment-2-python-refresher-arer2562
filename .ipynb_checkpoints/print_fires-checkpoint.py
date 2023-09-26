import my_utils as muts
region='United States of America'
savannh_faires = 2
forest_fires = 3
org_Fire = 23
hum_fire = 24
result_column = []
file_name = 'Agrofood_co2_emission.csv'
fires = muts.get_column(file_name, region, savannh_faires, forest_fires, org_Fire, hum_fire, result_column)
print(fires)
