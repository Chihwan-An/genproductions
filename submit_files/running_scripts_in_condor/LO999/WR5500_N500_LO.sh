#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR5500_N500 cards/LO999/WRtoNLtoLLJJ_WR5500_N500 pdmv
ls
mkdir result_WR5500_N500
ls
mv *.tar.xz result_WR5500_N500
mv *.log result_WR5500_N500
cd result_WR5500_N500
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
