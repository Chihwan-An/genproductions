#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR6500_N4200 cards/LO999/WRtoNLtoLLJJ_WR6500_N4200 pdmv
ls
mkdir result_WR6500_N4200
ls
mv *.tar.xz result_WR6500_N4200
mv *.log result_WR6500_N4200
cd result_WR6500_N4200
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
