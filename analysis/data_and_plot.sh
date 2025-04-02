source ./python/summary.sh
echo "data aquired from log files"
python ./python/kfactor_sorting.py
python ./python/grouping.py
echo "data ordered and calculated kfactor"
python ./python/Plotting_kfactor.py