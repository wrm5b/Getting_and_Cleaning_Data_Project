---
title: "Codebook"
author: "Walker"
date: "Saturday, December 20, 2014"
output: html_document
---

The original data contains test and train data measuring various activities 
with an accelerometer and gyroscope for several subjects.


The script run_analysis.R does the following:

- downloads and loads necessary packages (reshape2 and data.table)
- downloads and unzips the data, if necessary
- reads in the data, extracts mean and standard deviation measurements, and 
names the tests/activities
- merges test and train data
- melts the data into unique id-variable combinations and labels the data with 
appropriate names
- creates a second dataset using dcast with averages of each activity and subject
- writes the new tidy dataset to a text file


The final, tidy dataset contains 30 subjects performing 6 activities each 
(a total of 180 observations) measured by 79 variables.
The observations are mean angular velocities (Hz).
