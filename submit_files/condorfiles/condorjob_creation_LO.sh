#!/bin/bash
# generate_jobs.sh

# 템플릿 파일 이름
template="template_LO.jds"

# WR 값을 1000부터 6500까지 500 단위로 반복
for WR in {1000..6500..500}; do
    # N 값을 100부터 (WR - 100) 까지 100 단위로 반복
    for N in $(seq 100 100 $((WR-100))); do
        # 출력 파일 이름: 예) WR2000N100.jds, WR2000N200.jds, ..., WR2000N1900.jds
        outfile="WR${WR}_N${N}_LO.jds"
        
        # 템플릿 파일에서 "WR1000"을 "WR${WR}"로, "N100"을 "N${N}"로 치환
        sed -e "s/WR1000/WR${WR}/g" -e "s/N100/N${N}/g" "$template" > "$outfile"
        
        echo "Generated $outfile"
    done
done