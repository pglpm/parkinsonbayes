import pandas as pd

df_1 = pd.read_excel('data/nadpark/1-s2.0-S1550413122000456-mmc2.xlsx', sheet_name='Demographics & anamnestic data')
df_2 = pd.read_excel('data/nadpark/1-s2.0-S1550413122000456-mmc2.xlsx', sheet_name='Individual MDS-UPDRS scores')
#Columns to be used
columns = ['TreatmentGroup', 'Sex', 'Age', 'Anamnestic Loss of smell', 'History of REM Sleep Behaviour Disorder']
columns_newname = ['TreatmentGroup', 'Sex', 'Age', 'Anamnestic.Loss.of.smell', 'History.of.REM.Sleep.Behaviour.Disorder', 'MDS-UPDRS..Subsection III', 'diff.MDS-UPDRS..Subsection.III']
#Filter out the columns we dont need
filtered_df = df_1[columns]

#MDS-UPDRS Subsection III column
treatment_values = df_2['MDS-UPDRS  Subsection III']

#Filter for only visit 1 values
treatment_values_v1 = treatment_values.iloc[::2].values

#Add visit 1 and 2 together
add_rows = treatment_values.iloc[1::2].values - treatment_values.iloc[::2].values

#Merge all columns
merge_df = pd.concat([filtered_df, pd.DataFrame(treatment_values_v1, columns=['MDS-UPDRS  Subsection III']), pd.DataFrame(add_rows, columns=['MDS-UPDRS  Subsection III'])], axis=1)
merge_df.columns = columns_newname
#Convert merged columns to csv file
merge_df.to_csv('data/nadpark/toydata_Simen.csv', index=False)
print(merge_df)