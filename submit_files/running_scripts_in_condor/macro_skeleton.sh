#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR1000_N100 cards/LO/WRtoNLtoLLJJ_WR1000_N100 pdmv

mkdir result_WR1000_N100
echo "mkdir result_WR1000_N100 done"
mv *.tar.xz result_WR1000_N100
echo "mv *.tar.xz result_WR1000_N100 done"
mv *.log result_WR1000_N100 
echo "mv *.log result_WR1000_N100 done"
echo "mv *.tar.xz *.log result_WR1000_N100 done"
cd result_WR1000_N100
echo  "cd result_WR1000_N100 done"
tar -xavf *.tar.xz
echo "tar -xavf *.tar.xz done"
rm -f *.tar.xz
echo "rm -f *.tar."
./runcmsgrid.sh 10000
#cd ..
#mv result_WR1000_N100 /data6/Users/snuintern1/genproductions/bin/MadGraph5_aMCatNLO



