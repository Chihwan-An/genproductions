import re
import pandas as pd

def parse_line(line, is_nlo=False):
    """
    각 줄에서 파일명, cross section 값, 오차를 추출합니다.
    LO: "Cross-section :" 기준, NLO: "Total cross section:" 기준.
    """
    if is_nlo:
        pattern = r"^(.*?)\s*\|\s*cross\s+section:\s*Total\s+cross\s+section:\s*([\d.eE+-]+)\s*\+-\s*([\d.eE+-]+)\s*pb"
    else:
        pattern = r"^(.*?)\s*\|\s*cross\s+section:\s*Cross-section\s*:\s*([\d.eE+-]+)\s*\+-\s*([\d.eE+-]+)\s*pb"
    match = re.match(pattern, line)
    if match:
        filename = match.group(1).strip()
        try:
            xsec = float(match.group(2))
            err = float(match.group(3))
        except ValueError:
            xsec, err = None, None
        return filename, xsec, err
    else:
        return None, None, None

def extract_wr_n(identifier):
    """
    'WRxxxx_Nyyyy' 형식에서 숫자 부분을 추출하여 정렬에 사용합니다.
    """
    match = re.search(r"WR(\d+)_N(\d+)", identifier)
    if match:
        wr = int(match.group(1))
        n = int(match.group(2))
        return wr, n
    return (99999, 99999)

def process_combined_file(input_file, output_csv, lo_line_count=438):
    # 파일 전체 줄 읽기 (빈 줄 제거)
    with open(input_file, "r") as f:
        lines = [line.strip() for line in f if line.strip()]
    
    total_lines = len(lines)
    if total_lines < 2 * lo_line_count:
        print(f"전체 줄 수({total_lines})가 기대한 2*{lo_line_count} 보다 적습니다.")
        return
    
    # 첫 lo_line_count줄은 LO 데이터, 그 다음 lo_line_count줄은 NLO 데이터
    lo_lines = lines[:lo_line_count]
    nlo_lines = lines[lo_line_count:2 * lo_line_count]

    combined_rows = []
    for lo_line, nlo_line in zip(lo_lines, nlo_lines):
        lo_filename, lo_xsec, lo_err = parse_line(lo_line, is_nlo=False)
        nlo_filename, nlo_xsec, nlo_err = parse_line(nlo_line, is_nlo=True)
        # 각 행별 NLO/LO 비율 (단, 해당 행의 값)
        ratio = nlo_xsec / lo_xsec if lo_xsec and lo_xsec != 0 else None
        wr, n = extract_wr_n(lo_filename or "")
        combined_rows.append({
            "LO_Filename": lo_filename,
            "LO_CrossSection": lo_xsec,
            "LO_Error": lo_err,
            "NLO_Filename": nlo_filename,
            "NLO_CrossSection": nlo_xsec,
            "NLO_Error": nlo_err,
            "Row_NLO/LO_Ratio": ratio,  # 각 행에 대한 기본 비율 (이미 계산된 값)
            "WR": wr,  # 정렬용 임시 컬럼
            "N": n    # 정렬용 임시 컬럼
        })

    df = pd.DataFrame(combined_rows)
    # WR, N 기준으로 정렬하고 정렬용 임시 컬럼 제거
    df = df.sort_values(by=["WR", "N"]).drop(columns=["WR", "N"]).reset_index(drop=True)
    
    # ※ 여기서 "Global_Ratio"를 각 행의 마지막 열에 추가합니다.
    # 5번째 행(인덱스 4)의 NLO_CrossSection과 2번째 행(인덱스 1)의 LO_CrossSection을 사용하여 계산합니다.

    df.to_csv(output_csv, index=False)
    print(f"최종 CSV 파일 저장 완료: {output_csv}")

process_combined_file("result/cross_section_summary.txt", "result/calculated_ordered_kfactor.csv", lo_line_count=438)




