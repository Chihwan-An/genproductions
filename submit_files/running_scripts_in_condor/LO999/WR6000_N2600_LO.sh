#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR6000_N2600 cards/LO999/WRtoNLtoLLJJ_WR6000_N2600 pdmv
ls
mkdir result_WR6000_N2600
ls
mv *.tar.xz result_WR6000_N2600
mv *.log result_WR6000_N2600
cd result_WR6000_N2600
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
