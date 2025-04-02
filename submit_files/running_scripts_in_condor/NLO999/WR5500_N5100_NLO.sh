#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_WR5500_N5100_NLO cards/NLO999/WRtoNLtoLLJJ_WR5500_N5100_NLO pdmv
ls
mkdir result_WR5500_N5100_NLO
ls
mv *.tar.xz result_WR5500_N5100_NLO
mv *.log result_WR5500_N5100_NLO
cd result_WR5500_N5100_NLO
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
rm -rf mgbasedir/
