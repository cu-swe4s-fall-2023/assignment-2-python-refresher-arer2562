def get_column(file_name, query_column, query_value, result_column):
    with open(file_name, "r+") as my_file:
        result_column = []
        for i in my_file:
            if i == my_file[0]:
                pass
            else:
                A = i.rstrip().split(',')
                number = A[int(query_column)] + ' ' + A[int(query_value)]
                    result_column=result_column.append(A[int(query_value)])
            print(result_column) 

    return None
