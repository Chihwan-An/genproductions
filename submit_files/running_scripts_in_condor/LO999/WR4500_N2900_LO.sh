#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR4500_N2900 cards/LO999/WRtoNLtoLLJJ_WR4500_N2900 pdmv
ls
mkdir result_WR4500_N2900
ls
mv *.tar.xz result_WR4500_N2900
mv *.log result_WR4500_N2900
cd result_WR4500_N2900
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
