for WR in $(seq 1000 500 6500); do
    for N in $(seq 100 100 $((WR - 100))); do
        condor_submit WR${WR}_N${N}_LO.jds
    done
done