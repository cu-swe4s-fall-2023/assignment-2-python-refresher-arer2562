def get_column(file_name, region, savannh_faires, forest_fires, org_Fire, hum_fire, result_column):
    with open(file_name, "r+") as my_file:
        next(my_file)
        result_column = []
        for j in my_file:
                A = j.rstrip().split(',')
                #print(A)
                #number = A[int(query_column)] + ' ' + A[int(query_value)]
                #print(number)
                if A[0] != region:
                        pass
                elif A[savannh_faires] == '':
                    pass
                elif A[forest_fires] == '':
                    pass
                elif A[org_Fire] == '':
                    pass
                elif A[hum_fire]   == '' :
                        pass
                else:
                        #print(result_column)
                        result_column.append((A[int(float(savannh_faires))]))
                        result_column.append((A[int(float(forest_fires))]))
                        result_column.append((A[int(float(org_Fire))]))
                        result_column.append((A[int(float(hum_fire))]))
                        #head(result_column)
        for i in range(0, len(result_column)):
            result_column[i] = int(result_column[i].replace('.',''))
 

    return sum(result_column)
