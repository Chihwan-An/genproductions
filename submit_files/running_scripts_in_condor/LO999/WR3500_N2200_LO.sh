#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR3500_N2200 cards/LO999/WRtoNLtoLLJJ_WR3500_N2200 pdmv
ls
mkdir result_WR3500_N2200
ls
mv *.tar.xz result_WR3500_N2200
mv *.log result_WR3500_N2200
cd result_WR3500_N2200
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
