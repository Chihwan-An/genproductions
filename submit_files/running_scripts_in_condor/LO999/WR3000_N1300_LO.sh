#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR3000_N1300 cards/LO999/WRtoNLtoLLJJ_WR3000_N1300 pdmv
ls
mkdir result_WR3000_N1300
ls
mv *.tar.xz result_WR3000_N1300
mv *.log result_WR3000_N1300
cd result_WR3000_N1300
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
