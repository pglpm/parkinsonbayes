#### Prepare metadata
library('inferno')

dat <- 'toy_data_0.csv'
outfile <- 'meta_toy_data_0_CI.csv'

metadatatemplate(data = dat, file = outfile,
    includevrt = c('Group',
        'Cohort',
        'SNpc_n',
        'SNpc_percent',
        'PFC1_n',
        'PFC1_percent',
        'Age_of_death',
        'Sex',
        'PMI',
        'DV200',
        'RIN'
        ))


dat <- 'toy_data_0_onlyPD.csv'
outfile <- 'meta_toy_data_0_onlyPD.csv'

metadatatemplate(data = dat, file = outfile,
    includevrt = c('Group',
        'Cohort',
        'SNpc_n',
        'SNpc_percent',
        'PFC1_n',
        'PFC1_percent',
        'Age_of_death',
        'Age_first_reported_symptom',
        'Disease_duration',
        'Sex',
        'PMI',
        'DV200',
        'RIN',
        'Dementia',
        'PD_subtype_AR_TD',
        'PD_subtype_PIGD_TD',
        'Daily_cigarettes',
        'Years_smoker',
        'Years_since_smokestop',
        'Ethanol_units/week',
        'Freequency_alcohol',
        'MMSE_final_examination',
        'total_score_UPDRS_first_examination',
        'total_score_UPDRS_final_examination'
        ## 'UPDRS1_first_examination',
        ## 'UPDRS1_last_examination',
        ## 'UPDRS2_first_examination',
        ## 'UPDRS2_last_examination',
        ## 'UPDRS3_first_examination',
        ## 'UPDRS3_last_examination',
        ## 'UPDRS4_first_examination',
        ## 'UPDRS4_last_examination',
        ## 'Cause_of_death',
        ## 'PD_medication_during_followup'
        ))
