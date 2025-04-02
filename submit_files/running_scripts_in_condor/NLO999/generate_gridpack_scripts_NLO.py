wr_start = 1000
wr_end = 6500
wr_step = 500

for wr in range(wr_start, wr_end + 1, wr_step):
    for n in range(100, wr, 100):
        tag = f"WR{wr}_N{n}_NLO"
        filename = f"{tag}.sh"
        content = f"""#!/bin/bash
echo "[INFO] Working in: $PWD"
git clone https://github.com/Chihwan-An/genproductions.git
cd genproductions/bin/MadGraph5_aMCatNLO/
ls
./gridpack_generation.sh WRtoNLtoLLJJ_{tag} cards/NLO999/WRtoNLtoLLJJ_{tag} pdmv
ls
mkdir result_{tag}
ls
mv *.tar.xz result_{tag}
mv *.log result_{tag}
cd result_{tag}
tar -xavf *.tar.xz
./runcmsgrid.sh 5000 234567
rm -rf mgbasedir/
"""

        with open(filename, 'w') as f:
            f.write(content)

        print(f"✅ Generated: {filename}")
