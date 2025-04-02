#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR1500_N400 cards/LO999/WRtoNLtoLLJJ_WR1500_N400 pdmv
ls
mkdir result_WR1500_N400
ls
mv *.tar.xz result_WR1500_N400
mv *.log result_WR1500_N400
cd result_WR1500_N400
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
