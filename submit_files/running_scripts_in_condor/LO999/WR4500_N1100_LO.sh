#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR4500_N1100 cards/LO999/WRtoNLtoLLJJ_WR4500_N1100 pdmv
ls
mkdir result_WR4500_N1100
ls
mv *.tar.xz result_WR4500_N1100
mv *.log result_WR4500_N1100
cd result_WR4500_N1100
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
