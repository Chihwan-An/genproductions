import pandas as pd

# 기존 CSV 파일 불러오기 (정렬된 파일이어야 함)
df = pd.read_csv("final_output.csv")

# 각 행마다 Row_Ratio 계산: NLO_CrossSection ÷ LO_CrossSection
df["Row_Ratio"] = df["NLO_CrossSection"] / df["LO_CrossSection"]

# (예시) 첫 행은 3.626/3.103, 둘째 행은 3.466/2.943 등으로 계산됨.
# 계산된 값은 각 행마다 새 마지막 열에 들어갑니다.

# 업데이트된 DataFrame을 새로운 CSV 파일로 저장
df.to_csv("result/final_output_with_row_ratio.csv", index=False)

print("각 행의 계산된 비율(Row_Ratio)을 마지막 열에 추가하여 저장했습니다.")
