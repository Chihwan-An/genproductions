#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR5000_N4700 cards/LO999/WRtoNLtoLLJJ_WR5000_N4700 pdmv
ls
mkdir result_WR5000_N4700
ls
mv *.tar.xz result_WR5000_N4700
mv *.log result_WR5000_N4700
cd result_WR5000_N4700
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
