#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR5000_N4600 cards/LO999/WRtoNLtoLLJJ_WR5000_N4600 pdmv
ls
mkdir result_WR5000_N4600
ls
mv *.tar.xz result_WR5000_N4600
mv *.log result_WR5000_N4600
cd result_WR5000_N4600
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
