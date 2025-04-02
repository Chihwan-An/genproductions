#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR6500_N5000 cards/LO999/WRtoNLtoLLJJ_WR6500_N5000 pdmv
ls
mkdir result_WR6500_N5000
ls
mv *.tar.xz result_WR6500_N5000
mv *.log result_WR6500_N5000
cd result_WR6500_N5000
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
