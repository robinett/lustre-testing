#!/bin/bash

#SBATCH --output=./outputs/out_%j.log
#SBATCH --time=01:00:00
#SBATCH --nodes=1 --ntasks-per-node=8
#SBATCH --partition=catch-m6a4xl-demand

echo 'this is the command that we need to run quickly:'
echo 'time echo $THISMONTH | rev | cut -d'/' -f1 | cut -c1-2 | rev'
sleep 5
echo 'lets try it in isolation to confirm it runs quickly by default'
time echo $THISMONTH | rev | cut -d'/' -f1 | cut -c1-2 | rev
sleep 5
echo 'pretty quick'
echo 'the theory is that too many calls to the above command'
echo 'slows its performance'
echo 'lets test this by firing up nodes one at a time that'
echo 'will continually call the above command'
echo 'in between calls, the script will move a small number of'
echo 'files between directories and then do the same thing again'
echo 'progress should slow as more nodes are called in'
sleep 10

echo 'lets start'

n=0
while [ $n -le 9 ]
do
    echo "calling in node $n"
    cd ./testing_$n
    sbatch tests_med.sh
    cd ../
    sleep 5
    tail -n4 ./testing_0/outputs/out.log
    sleep 5
    tail -n4 ./testing_0/outputs/out.log
    n=$((n+1))
done

echo 'all have been submitted'
echo 'lets continue to watch for a performance decrease'

x=0
SECONDS=0
while [ $x -le 1 ]
do
    sleep 5
    duration=$SECONDS
    echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
    tail -n4 ./testing_0/outputs/out.log
done
