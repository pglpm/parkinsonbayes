### We now construct the metadata file for the toydata.
###
### First we load the 'modelfreeinference' package.
### Check the README in
### https://github.com/pglpm/bayes_nonparametric_inference
### for installation instructions.

library('modelfreeinference')

### We use the utility function 'buildmetadata()' to save a first version
### of a metadata file, to work on:

buildmetadata('toydata.csv', file = 'temp_metatoydata.csv',
    excludevrt = 'Subject.Id')
