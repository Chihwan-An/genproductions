#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR3000_N2800 cards/LO999/WRtoNLtoLLJJ_WR3000_N2800 pdmv
ls
mkdir result_WR3000_N2800
ls
mv *.tar.xz result_WR3000_N2800
mv *.log result_WR3000_N2800
cd result_WR3000_N2800
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
