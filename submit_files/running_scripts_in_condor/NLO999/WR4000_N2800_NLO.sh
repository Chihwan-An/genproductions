#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR4000_N2800_NLO cards/NLO999/WRtoNLtoLLJJ_WR4000_N2800_NLO pdmv
ls
mkdir result_WR4000_N2800_NLO
ls
mv *.tar.xz result_WR4000_N2800_NLO
mv *.log result_WR4000_N2800_NLO
cd result_WR4000_N2800_NLO
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
rm -rf mgbasedir/
