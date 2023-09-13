def get_column(file_name, query_column, query_value, result_column):
    with open("file_name", "r+") as my_file:
        for i in my_file:
            A = i.rstrip().split(',')
            date = A[0]
            county_city = A[1]
            state = A[2]
            fips = A[3]
            cases = int(A[4])
            deaths = int(A[5])
            
            number = [query_column, query_value]
            print(number) 

    return None
