### Re-organization of some data from
### https://ars.els-cdn.com/content/image/1-s2.0-S1550413122000456-mmc2.xlsx
### for a toy analysis.
###
### Two sheets from that database have been saved:

datademofile <- 'data_demographics.csv'
datamdsfile <- 'data_mds.csv'

### Load and take a look at the data:

datademo <- read.csv(datademofile, na.strings = '')

str(datademo)
## 'data.frame':	30 obs. of  9 variables:
##  $ Subject.Id                             : chr  "01-001" "01-002" "01-003" "01-004" ...
##  $ TreatmentGroup                         : chr  "Placebo" "NR" "Placebo" "Placebo" ...
##  $ Sex                                    : chr  "Male" "Female" "Male" "Male" ...
##  $ Age                                    : int  66 65 66 65 66 64 55 69 72 69 ...
##  $ MDS.Clinical.Diagnosis.Criteria        : chr  "Probable" "Established" "Probable" "Probable" ...
##  $ Anamnestic.Loss.of.smell               : chr  "No" "Yes" "Yes" "No" ...
##  $ History.of.REM.Sleep.Behaviour.Disorder: chr  "No" "No" "No" "No" ...
##  $ Months.since.first..PD.symptom         : int  24 36 12 48 30 44 36 18 36 24 ...
##  $ Smoking                                : chr  "No" "No" "No" "No" ...

datamds <- read.csv(datamdsfile, na.strings = '')

str(datamds)
## 'data.frame':	60 obs. of  8 variables:
##  $ Subject.Id               : chr  "01-001" "01-001" "01-002" "01-002" ...
##  $ TreatmentGroup           : chr  "Placebo" "Placebo" "NR" "NR" ...
##  $ Visit                    : chr  "V01" "V02" "V01" "V02" ...
##  $ MDS.UPDRS..Subsection.I  : int  8 7 9 4 7 7 0 3 5 4 ...
##  $ MDS.UPDRS..Subsection.II : int  16 16 8 16 4 4 7 8 13 13 ...
##  $ MDS.UPDRS..Subsection.III: int  44 42 32 42 31 35 35 38 35 38 ...
##  $ MDS.UPDRS..Subsection.IV : int  3 3 3 3 2 2 3 2 2 2 ...
##  $ Total.MDS.UPDRS.score    : int  71 68 52 65 44 48 45 51 55 57 ...

### IMPORTANT: note that this contains 60 rows because each subject
### is now categorized under visit V01 and visit V02


### To start with, as agreed with Katarina,
### We want to extract the following variates for each subject:

variates <- c(
    ## will NOT be used in the analysis:
    ## only needed to match data across dataset
    'Subject.Id',
    'TreatmentGroup', # 1st dataset
    'Sex', # 1st dataset
    'Age', # 1st dataset
    'Anamnestic.Loss.of.smell', # 1st dataset
    'History.of.REM.Sleep.Behaviour.Disorder', # 1st dataset
    ## of these last two we really only want the difference V02-V01.
    'MDS.UPDRS..Subsection.III', # 2nd dataset, Visit V01
    'MDS.UPDRS..Subsection.III' # 2nd dataset, Visit V02
)


### First, let's select the variates of interest from the 1st dataset:

tempdata <- datademo[, colnames(datademo) %in% variates]

### then let's select the variates of interest from the 2nd dataset
### but only for the Visit=V01 case:

tempdata1 <- datamds[datamds$Visit == 'V01', colnames(datamds) %in% variates]

### check that we indeed get 30 subjects:
nrow(tempdata1)
## [1] 30

### change name to variate 'MDS.UPDRS..Subsection.III', add visit V01
names(tempdata1)[
    names(tempdata1) == 'MDS.UPDRS..Subsection.III'
] <- 'MDS.UPDRS..Subsection.III.V1'


### Same but with Visit=V02:

tempdata2 <- datamds[datamds$Visit == 'V02', colnames(datamds) %in% variates]

### change name to variate 'MDS.UPDRS..Subsection.III', add visit V02
names(tempdata2)[
    names(tempdata2) == 'MDS.UPDRS..Subsection.III'
] <- 'MDS.UPDRS..Subsection.III.V2'

### check that we indeed get 30 subjects:
nrow(tempdata2)
## [1] 30

### We now merge the three temporary datasets,
### making sure that the subjects IDs match:

temp <- merge(tempdata1, tempdata2,
    by.x=c('Subject.Id', 'TreatmentGroup'),
    by.y=c('Subject.Id', 'TreatmentGroup'))

### create a new variate in temp, the difference between the two MDS:

temp$diff.MDS.UPRS.III <- temp$MDS.UPDRS..Subsection.III.V2 -
    temp$MDS.UPDRS..Subsection.III.V1

### Now we remove the MDS variate for the second visit.
### IMPORTANT: the reason is that
### the 'diff' variate is a FUNCTION (the difference) of the other two.
### For this reason it is perfectly correlated with the other two
### THIS MAKES THE MONTE CARLO INFERENCE MUCH MORE LENGTHY

temp$MDS.UPDRS..Subsection.III.V2 <- NULL

### Check that this partial result is what we want:

str(temp)
## 'data.frame':	30 obs. of  4 variables:
##  $ Subject.Id                  : chr  "01-001" "01-002" "01-003" "01-004" ...
##  $ TreatmentGroup              : chr  "Placebo" "NR" "Placebo" "Placebo" ...
##  $ MDS.UPDRS..Subsection.III.V1: int  44 32 31 35 35 29 15 18 36 50 ...
##  $ diff.MDS.UPRS.III           : int  -2 10 4 3 3 -3 10 -5 -6 -1 ...

### Finally we merge the first dataset with this

toydata <- merge(tempdata, temp,
    by.x=c('Subject.Id', 'TreatmentGroup'),
    by.y=c('Subject.Id', 'TreatmentGroup'))

### Check:
str(toydata)
## 'data.frame':	30 obs. of  8 variables:
##  $ Subject.Id                             : chr  "01-001" "01-002" "01-003" "01-004" ...
##  $ TreatmentGroup                         : chr  "Placebo" "NR" "Placebo" "Placebo" ...
##  $ Sex                                    : chr  "Male" "Female" "Male" "Male" ...
##  $ Age                                    : int  66 65 66 65 66 64 55 69 72 69 ...
##  $ Anamnestic.Loss.of.smell               : chr  "No" "Yes" "Yes" "No" ...
##  $ History.of.REM.Sleep.Behaviour.Disorder: chr  "No" "No" "No" "No" ...
##  $ MDS.UPDRS..Subsection.III.V1           : int  44 32 31 35 35 29 15 18 36 50 ...
##  $ diff.MDS.UPRS.III                      : int  -2 10 4 3 3 -3 10 -5 -6 -1 ...

### Let's save this
write.csv(toydata, file = 'toydata.csv',
    row.names = FALSE, quote = FALSE, na = '')
