import pandas as pd
import re

# 1. CSV 파일 읽기
# 파일은 아래와 같이 열 헤더가 있습니다:
# NLO,Filename,CrossSection,Error,LO,Filename,CrossSection,Error, ,NLO/LO
# pandas는 중복되는 열명을 자동으로 바꿉니다.
df = pd.read_csv("result/calculated_ordered_kfactor.csv")
print("원본 CSV의 열:", df.columns.tolist())

# 2. 열 이름 재지정 (예시)
# 자동으로 pandas가 생성한 열명이 다음과 같다고 가정:
# ['NLO', 'Filename', 'CrossSection', 'Error', 'LO', 'Filename.1', 'CrossSection.1', 'Error.1', 'Unnamed: 8', 'NLO/LO']
df.columns = [ 'NLO_Filename', 'NLO_CrossSection', 'NLO_Error',
               'LO_Filename', 'LO_CrossSection', 'LO_Error', 'Ratio']

# 3. Ratio 컬럼을 숫자형으로 변환
df['Ratio'] = pd.to_numeric(df['Ratio'], errors='coerce')

# 4. LO_Filename에서 WR와 N 값 추출 함수
def extract_wr_n(filename):
    # 예: "condorfiles/LO/result_WR1000_N100/WRtoNLtoLLJJ_WR1000_N100.log"
    m = re.search(r"WR(\d+)_N(\d+)", filename)
    if m:
        return int(m.group(1)), int(m.group(2))
    else:
        return None, None

# 5. LO_Filename에서 WR와 N을 추출하여 새로운 컬럼 추가
df[['WR', 'N']] = df['LO_Filename'].apply(lambda x: pd.Series(extract_wr_n(x)))

# 6. WR, N 값이 없는 행은 제거
df = df.dropna(subset=['WR', 'N'])
df['WR'] = df['WR'].astype(int)
df['N'] = df['N'].astype(int)

# 7. 그룹 지정 함수 (세 그룹 기준)
def assign_group(row):
    wr = row['WR']
    n = row['N']
    if n >= 100 and n < wr / 2:
        return "N100"
    elif n == wr / 2:
        return "WR/2"
    elif n > wr / 2 and n <= wr - 100:
        return "WR-100"
    else:
        return "Other"

df['Group'] = df.apply(assign_group, axis=1)

# 8. WR와 Group별로 NLO/LO Ratio의 평균 계산
grouped = df.groupby(['WR', 'Group']).agg(
    Avg_Ratio=('Ratio', 'mean')
).reset_index()

print("그룹별 평균 계산 결과:")
print(grouped)

# 9. 결과를 CSV 파일로 저장
grouped.to_csv("result/grouped_ratio.csv", index=False)
print("\nGrouped CSV saved as 'grouped_ratio.csv'.")