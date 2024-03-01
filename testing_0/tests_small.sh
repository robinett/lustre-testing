#!/bin/bash

#SBATCH --output=./outputs/out.log
#SBATCH --time=01:00:00
#SBATCH --nodes=1 --ntasks-per-node=8
#SBATCH --partition=catch-m6a4xl-demand

n=0
while [ $n -le 1000000 ]
do
    remainder=$((n % 2))
    if [ $remainder -eq 0 ]; then
        true
        #cp ./data_1_large/*200601*.nc4 ./data_2_large/
        /bin/mv ./data_1_large/*20060101*.nc4 ./data_2_large/
        #cp ./data_2_large/*200601*.nc4 ./data_1_large/
        #rm ./data_1_large/*200601*.nc4
    else
        true
        #cp ./data_2_large/*200601*.nc4 ./data_1_large/
        /bin/mv ./data_2_large/*20060101*.nc4 ./data_1_large/
        #cp ./data_1_large/*200601*.nc4 ./data_2_large/
        #rm ./data_2_large/*200601*.nc4
    fi
    time echo $THISMONTH | rev | cut -d'/' -f1 | cut -c1-2 | rev
    n=$((n+1))
done

