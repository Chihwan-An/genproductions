#!/bin/bash
# cross_section_summary_NLO.sh
# LO, NLO 디렉토리 내 WRtoNLtoLLJJ_*.log 파일만 처리하여 cross section 정보 추출

output_file="result/cross_section_summary.txt"
rm -f "$output_file"

# LO 디렉토리 처리
for logfile in ../submit_files/condorfiles/LO/*/WRtoNLtoLLJJ_*.log; do
    [ -f "$logfile" ] || continue

    matching_lines=$(grep "Cross-section" "$logfile")
    [ -z "$matching_lines" ] && continue

    selected_line=$(echo "$matching_lines" | head -n 1)
    echo "$logfile | cross section: $selected_line" >> "$output_file"
done

# NLO 디렉토리 처리
for logfile in ../submit_files/condorfiles/NLO/*/WRtoNLtoLLJJ_*.log; do
    [ -f "$logfile" ] || continue

    matching_lines=$(grep "cross section" "$logfile")
    [ -z "$matching_lines" ] && continue

    selected_line=$(echo "$matching_lines" | tail -n 1)
    echo "$logfile | cross section: $selected_line" >> "$output_file"
done

echo "정리된 결과가 $output_file 에 저장되었습니다."