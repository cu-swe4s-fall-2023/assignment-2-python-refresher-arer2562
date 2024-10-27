#This is a functional testing file that uses sssh testing on run_hotspot_script.R 
#It tests that run_hotspot_script.R creates .png files with the correct module names in the outs directory
#It tests that the rank_based_partner_dists.png is created in the outs directory
#It confirms that an incorrect file name arguments exit with code 1

#!/bin/bash

test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest
. ssshtest

run "TestBadFileName" Rscript --vanilla ./run_hotspot_script.R -i "./doc/incorrect_file.csv" -m "./doc/wrong_file.csv"
assert_exit_code 2

run "TestRscript" Rscript --vanilla ./src/run_hotspot_script.R -i "./doc/ani_mod_scores_allcells.csv" -m "./doc/seq_beh_metadata.csv"

for i in {1..23}; do
    assert_equal "./outs/Module.${i} _violin.png" "$(ls "./outs/Module.${i} _violin.png")"
    assert_equal "./outs/Module.${i} partner_corr.png" "$(ls "./outs/Module.${i} partner_corr.png")"
done
