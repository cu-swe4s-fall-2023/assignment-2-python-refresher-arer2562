[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/oQi7O4AA)
# python-refresher

Final commit - this will help you pull in file to read and then determine sum of all fires in desired country (denoted as region).

In final version default of results_column is 1.
Edited my_utils, print_fire as well.

Assn3

Gitclone repo!!

FIND AGROFOOD SHEET BEFORE YOU START

Updated to follow pycodestyle with one exception in print_fires that required shrinking variable names to point of being uninformative.

Run fires takes in file in SAME directory as long as you spell name correctly. To use file in different directory use your full path. 

Run fires provides column names of listed file corresponding to Country name present in column 0 and four fire conditions (column 2,3,23,24)

Two examples file to show off code corresponding to exceptions when file not found and when fires column contains values that cannot be converted to int.

Print_fires.py contains arg parse information to parse out inputs from run shell script and applies main function from my_utils

my_utils is python script to actually define main funciton used to count and sum all fires in country and conditions from run shell script.

Final commit will be tagged V2 to correspond to changes and new update. 


Now added descriptive stats to my_utils and funcitonal and unit tests.
Subsetted data to contain only fires into new csv called subsetted_data

Unit test and functional test hard coded in can run functional test with: 

bash fun_test.sh

Unit test is:

python test_my_utils.py

Unit tests runs on Agro_food file from google drive.
Functional tests run on subsetted_data.csv in this directory
Subsetted dataset made with subset.py that will require Agro_food sheet to subset.

Final commit will be tagged V4 to correspond to changes and new update.


Added Assn5 branch

Added .gitignore file to unignore .githubworkflows
Now .github workflows works to allow test c1.yml 
This edit is testing if it workks
Updated to run in accorance to pylint
final release tagged as v5.0


Science fair paragraph.
Assn6.1 is for assignment 6.1.

The goal: gather preliminary evidence to write grant funding lawsuit again world leaders for evnironmental negligence. 

Data:
To do so we have downloaded data from the UN on countries Agrucuulutre and co2 emmisions.

Approach:
The data have been subsetted for just fires in each country. Following that, we have split the countries into quartiles based on number of fires.

Result:
Indonesia and Zimbabwe are at the top of the most negligent countries based on this analysis.

Limitation:

This analysis does not correct for number of fires or amount of forestry in regions. Thus resutls could be quite biased. 

This should run through snakemake.

If not run_by_country with provide args for fires_by_country to parse and drop into math_by_country.


Here you will get to work on making histograms for each country ranked in quartiels by total number of fires. 



