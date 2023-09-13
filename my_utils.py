def get_column(file_name, query_column, query_value, result_column):
    with open(file_name, "r+") as my_file:
        next(my_file)
        result_column = []
        for j in my_file:
                A = j.rstrip().split(',')
                #print(A)
                number = A[int(query_column)] + ' ' + A[int(query_value)]
                #print(number)
                if A[query_value]  == '' :
                        pass
                else:
                    #print(result_column)
                    result_column.append(A[query_value])
                    #head(result_column)

    return result_column
