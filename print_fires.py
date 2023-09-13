import my_utils as muts
country='United States of America'
county_column = 1
fires_column = 4
file_name = 'Agrofood_co2_emission.csv'
query_column=county_column 
query_value=fires_column 
result_column=query_value
fires = muts.get_column(file_name,county_column,fires_column,result_column)
print(fires)
