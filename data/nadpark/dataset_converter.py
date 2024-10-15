import pandas as pd

df_demo = pd.read_csv('dataset_demographics.csv')
df_NAD = pd.read_csv('dataset_NAD.csv')

columns_demo = ['Subject Id', 'TreatmentGroup', 'Sex', 'Age', 'Anamnestic.Loss.of.smell', 'History.of.REM.Sleep.Behaviour.Disorder', 'MDS.UPDRS..Subsection.III.V1', 'diff.MDS.UPRS.III']
columns_NAD = ['ID', 'Treatment group', 'v1.NAD', 'v2.NAD']
columns_merged = ['Subject Id', 'TreatmentGroup', 'Sex', 'Age', 'Anamnestic.Loss.of.smell', 'History.of.REM.Sleep.Behaviour.Disorder', 'MDS.UPDRS..Subsection.III.V1', 'diff.MDS.UPRS.III', 'ID', 'Treatment group', 'v2.NAD', 'visit.ratio']

sorted_demo = df_demo.sort_values(by = ['TreatmentGroup', 'Subject Id'], ascending=[False, True])

df_merged = pd.concat([sorted_demo, df_NAD], axis=1)

df_merged.to_csv('dataset_demographics_NAD2.csv', index=False)