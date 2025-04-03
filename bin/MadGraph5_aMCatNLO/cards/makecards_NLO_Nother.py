import os

WRMASSEND = 6500
WRMASS = 1000


while (WRMASS <= WRMASSEND):
    NMASS = 100
    while (NMASS <= WRMASS-100):
        DIRNAME = "WRtoNLtoLLJJ_WR"+(str)(WRMASS)+"_N"+(str)(NMASS)+"_NLO"
        os.system("mkdir "+DIRNAME)
        os.system("cp skeletons_for_NLO_Nother/run_card.dat "+DIRNAME+"/"+DIRNAME+"_run_card.dat")     
        os.system("cp skeletons_for_NLO_Nother/extramodels.dat "+DIRNAME+"/"+DIRNAME+"_extramodels.dat")
        proclines_path = "skeletons_for_NLO_Nother/proc_card.dat"
        custolines_path = "skeletons_for_NLO_Nother/customizecards.dat"

        with open(proclines_path, "r") as f:
            proclines = f.readlines()

        with open(custolines_path, "r") as f:
            custolines = f.readlines()

        with open(f"{DIRNAME}/{DIRNAME}_proc_card.dat", "w") as procnew:
            for line in proclines:
                if "###OUTPUT" in line:
                    procnew.write(f"output {DIRNAME} --nojpeg --hel_recycling=False\n")
                else:
                    procnew.write(line)

        with open(f"{DIRNAME}/{DIRNAME}_customizecards.dat", "w") as custonew:
            for line in custolines:
                if "###SETMASS9900012" in line:
                    custonew.write(f"set param_card mass 9900012 999999\n")
                elif "###SETMASS9900014" in line:
                    custonew.write(f"set param_card mass 9900014 999999\n")
                elif "###SETMASS9900016" in line:
                    custonew.write(f"set param_card mass 9900016 {NMASS}\n")
                elif "###SETMASS34" in line:
                    custonew.write(f"set param_card mass 34 {WRMASS}\n")
                else:
                    custonew.write(line)
        NMASS = NMASS + 100
    WRMASS = WRMASS + 500
